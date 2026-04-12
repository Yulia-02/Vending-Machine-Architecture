`timescale 1ns/1ps

module tb_vending_two_phase;

    reg clka;
    reg clkb;
    reg rst_n;

    reg coin_valid;
    reg [1:0] coin_type;
    reg sel_valid;
    reg [1:0] sel_id;
    reg cancel;

    wire dispense_valid;
    wire [1:0] dispense_id;
    wire change_pulse;
    wire [1:0] change_type;
    wire [1:0] status_code;
    wire [1:0] err_code;

    vending_top dut (
        .clka(clka),
        .clkb(clkb),
        .rst_n(rst_n),
        .coin_valid(coin_valid),
        .coin_type(coin_type),
        .sel_valid(sel_valid),
        .sel_id(sel_id),
        .cancel(cancel),
        .dispense_valid(dispense_valid),
        .dispense_id(dispense_id),
        .change_pulse(change_pulse),
        .change_type(change_type),
        .status_code(status_code),
        .err_code(err_code)
    );

    initial begin
        clka = 1'b0;
        clkb = 1'b0;
        forever begin
            #5;
            clka = 1'b1;
            #10;
            clka = 1'b0;

            #5;
            clkb = 1'b1;
            #10;
            clkb = 1'b0;
        end
    end

    task insert_coin(input [1:0] t);
        begin
            @(posedge clka);
            coin_type  <= t;
            coin_valid <= 1'b1;
            @(posedge clka);
            coin_valid <= 1'b0;
            coin_type  <= 2'b00;
        end
    endtask

    task select_item(input [1:0] id);
        begin
            @(posedge clka);
            sel_id    <= id;
            sel_valid <= 1'b1;
            @(posedge clka);
            sel_valid <= 1'b0;
            sel_id    <= 2'b00;
        end
    endtask

    task do_cancel;
        begin
            @(posedge clka);
            cancel <= 1'b1;
            @(posedge clka);
            cancel <= 1'b0;
        end
    endtask

    initial begin
        $dumpfile("vending_top_pre.vcd");
        $dumpvars(0, tb_vending_two_phase);
    end

    always @(negedge clka) begin
        if (dispense_valid)
            $display("[%0t] DISPENSE id=%0d", $time, dispense_id);

        if (change_pulse)
            $display("[%0t] CHANGE type=%b", $time, change_type);

        if (err_code != 0)
            $display("[%0t] ERROR code=%0d", $time, err_code);
    end

    initial begin
        coin_valid = 0;
        coin_type  = 0;
        sel_valid  = 0;
        sel_id     = 0;
        cancel     = 0;

        rst_n = 0;
        repeat(4) @(posedge clka);
        rst_n = 1;

        // Case 1: exact pay item0 ($25 + $5 = $30)
        insert_coin(2'b10);
        insert_coin(2'b00);
        select_item(2'd0);
        repeat(20) @(posedge clka);

        // Case 2: overpay item1 ($25 + $25, price = $40)
        insert_coin(2'b10);
        insert_coin(2'b10);
        select_item(2'd1);
        repeat(30) @(posedge clka);

        // Case 3: insufficient then add more for item2 ($50)
        insert_coin(2'b10);
        select_item(2'd2);
        insert_coin(2'b10);
        select_item(2'd2);
        repeat(30) @(posedge clka);

        // Case 4: cancel/refund
        insert_coin(2'b10);
        insert_coin(2'b00);
        do_cancel();
        repeat(30) @(posedge clka);

        $finish;
    end

endmodule