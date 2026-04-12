`timescale 1ns/1ps

module vending_datapath #(
    parameter [5:0] INIT_PRICE0 = 6'd6,   // $30
    parameter [5:0] INIT_PRICE1 = 6'd8,   // $40
    parameter [5:0] INIT_PRICE2 = 6'd10,  // $50
    parameter [5:0] INIT_PRICE3 = 6'd12,  // $60
    parameter [3:0] INIT_INV    = 4'd8,   //inventory
    parameter [5:0] INIT_BANK   = 6'd10   // $50 -> 10 units
)(
    input  wire       clkb,
    input  wire       rst_n,

    // external-like datapath inputs
    input  wire       coin_valid,
    input  wire [1:0] coin_type,
    input  wire [1:0] sel_id,

    // control from FSM
    input  wire       do_add_coin,
    input  wire       do_latch_sel,
    input  wire       do_dec_inv,
    input  wire       do_compute_change,
    input  wire       do_load_rem_from_bal,
    input  wire       do_clear_balance,
    input  wire       chg_sub_pulse,
    input  wire [1:0] chg_denom,

    // status back to FSM
    output wire       soldout,
    output wire       enough,
    output wire       rem_zero,
    output wire       bank_enough,
    output wire       balance_zero,
    output wire       can25,
    output wire       can10,
    output wire       can5,

    // observation outputs
    output wire [1:0] sel_reg_out,
    output wire [5:0] balance_out,
    output wire [5:0] change_rem_out
);

    reg [5:0] balance;
    reg [5:0] change_bank;
    reg [5:0] change_rem;
    reg [1:0] sel_reg;

    reg [5:0] price [0:3];
    reg [3:0] inv   [0:3];

    integer i;

    wire [5:0] price_sel = price[sel_reg];
    wire [3:0] inv_sel   = inv[sel_reg];

    // decoder
    wire [5:0] coin_value =
        (coin_type == 2'b00) ? 6'd1 :
        (coin_type == 2'b01) ? 6'd2 :
        (coin_type == 2'b10) ? 6'd5 : 6'd0;

    assign soldout      = (inv_sel == 0);
    assign enough       = (balance >= price_sel);
    assign rem_zero     = (change_rem == 0);
    assign bank_enough  = (change_bank >= change_rem);
    assign balance_zero = (balance == 0);

    assign can25 = (change_rem >= 6'd5) && (change_bank >= 6'd5);
    assign can10 = (change_rem >= 6'd2) && (change_bank >= 6'd2);
    assign can5  = (change_rem >= 6'd1) && (change_bank >= 6'd1);

    assign sel_reg_out    = sel_reg;
    assign balance_out    = balance;
    assign change_rem_out = change_rem;

    always @(negedge clkb) begin
        if (!rst_n) begin
            balance     <= 6'd0;
            change_bank <= INIT_BANK;
            change_rem  <= 6'd0;
            sel_reg     <= 2'd0;

            price[0] <= INIT_PRICE0;
            price[1] <= INIT_PRICE1;
            price[2] <= INIT_PRICE2;
            price[3] <= INIT_PRICE3;

            for (i = 0; i < 4; i = i + 1)
                inv[i] <= INIT_INV;
        end else begin
            if (do_add_coin && coin_valid)
                balance <= balance + coin_value;

            if (do_latch_sel)
                sel_reg <= sel_id;

            if (do_dec_inv && inv[sel_reg] != 0)
                inv[sel_reg] <= inv[sel_reg] - 1'b1;

            if (do_compute_change)
                change_rem <= balance - price_sel;

            if (do_load_rem_from_bal)
                change_rem <= balance;

            if (chg_sub_pulse) begin
                case (chg_denom)
                    2'b10: begin
                        change_rem  <= change_rem - 6'd5;
                        change_bank <= change_bank - 6'd5;
                    end
                    2'b01: begin
                        change_rem  <= change_rem - 6'd2;
                        change_bank <= change_bank - 6'd2;
                    end
                    2'b00: begin
                        change_rem  <= change_rem - 6'd1;
                        change_bank <= change_bank - 6'd1;
                    end
                    default: ;
                endcase
            end

            if (do_clear_balance) begin
                balance    <= 6'd0;
                change_rem <= 6'd0;
            end
        end
    end

endmodule