
`timescale 1ns/1ps

module tb_vending_two_phase;

  reg clk;
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
    .clk(clk), .rst_n(rst_n),
    .coin_valid(coin_valid), .coin_type(coin_type),
    .sel_valid(sel_valid), .sel_id(sel_id),
    .cancel(cancel),
    .dispense_valid(dispense_valid), .dispense_id(dispense_id),
    .change_pulse(change_pulse), .change_type(change_type),
    .status_code(status_code), .err_code(err_code)
  );

  // 100MHz clock
  initial clk = 0;
  always #5 clk = ~clk;

  
  task insert_coin(input [1:0] t);
    begin
      @(posedge clk);
      coin_type  <= t;
      coin_valid <= 1'b1;
      @(posedge clk);
      coin_valid <= 1'b0;
      coin_type  <= 2'b00;
    end
  endtask

  task select_item(input [1:0] id);
    begin
      @(posedge clk);
      sel_id    <= id;
      sel_valid <= 1'b1;
      @(posedge clk);
      sel_valid <= 1'b0;
      sel_id    <= 2'b00;
    end
  endtask

  task do_cancel;
    begin
      @(posedge clk);
      cancel <= 1'b1;
      @(posedge clk);
      cancel <= 1'b0;
    end
  endtask

  // Wave dump
  initial begin
    $dumpfile("vending_pre.vcd");
    $dumpvars(0, tb_vending_two_phase);
  end

  // Monitors
  always @(negedge clk) begin
    if (dispense_valid) $display("[%0t] DISPENSE id=%0d", $time, dispense_id);
    if (change_pulse)   $display("[%0t] CHANGE type=%b", $time, change_type);
    if (err_code!=0)    $display("[%0t] ERROR code=%0d", $time, err_code);
  end

  initial begin
    coin_valid=0; coin_type=0;
    sel_valid=0;  sel_id=0;
    cancel=0;

    rst_n=0;
    repeat(4) @(posedge clk);
    rst_n=1;

    // Case 1: Exact pay, vend item0 (price0=6 units=$30)
    insert_coin(2'b10);
    insert_coin(2'b00);
    select_item(2'd0);
    repeat(20) @(posedge clk);

    // Case 2: Overpay, vend item1 (price1=8 units=$40)
    insert_coin(2'b10);
    insert_coin(2'b10);
    select_item(2'd1);
    repeat(30) @(posedge clk);

    // Case 3: Insufficient then add more, vend item2 (price2=10 units=$50)
    insert_coin(2'b10);
    select_item(2'd2);
    insert_coin(2'b10);
    repeat(30) @(posedge clk);

    // Case 4: Cancel and refund
    insert_coin(2'b10);
    insert_coin(2'b00);
    do_cancel();
    repeat(30) @(posedge clk);

    // Case 5: Soldout (force inv[3]=0) then select item3
    dut.inv[3] = 0;
    select_item(2'd3);
    repeat(10) @(posedge clk);

    // Case 6: No-change (force bank=0) with overpay 
    dut.change_bank = 0;
    insert_coin(2'b10);
    insert_coin(2'b10);
    select_item(2'd0);
    repeat(20) @(posedge clk);

    $finish;
  end

endmodule
