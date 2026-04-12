`timescale 1ns/1ps

module vending_top(
    input  wire       clka,
    input  wire       clkb,
    input  wire       rst_n,
    input  wire       coin_valid,
    input  wire [1:0] coin_type,
    input  wire       sel_valid,
    input  wire [1:0] sel_id,
    input  wire       cancel,

    output wire       dispense_valid,
    output wire [1:0] dispense_id,
    output wire       change_pulse,
    output wire [1:0] change_type,
    output wire [1:0] status_code,
    output wire [1:0] err_code
);

    wire do_add_coin, do_latch_sel, do_dec_inv;
    wire do_compute_change, do_load_rem_from_bal, do_clear_balance;
    wire chg_sub_pulse, change_start_pulse;
    wire [1:0] chg_denom;

    wire soldout, enough, rem_zero, bank_enough, balance_zero;
    wire can25, can10, can5;
    wire [1:0] sel_reg_out;
    wire [5:0] balance_out, change_rem_out;

    vending_fsm u_fsm (
        .clka(clka),
        .rst_n(rst_n),
        .coin_valid(coin_valid),
        .sel_valid(sel_valid),
        .cancel(cancel),

        .soldout(soldout),
        .enough(enough),
        .rem_zero(rem_zero),
        .bank_enough(bank_enough),
        .balance_zero(balance_zero),
        .can25(can25),
        .can10(can10),
        .can5(can5),

        .sel_reg_id(sel_reg_out),

        .do_add_coin(do_add_coin),
        .do_latch_sel(do_latch_sel),
        .do_dec_inv(do_dec_inv),
        .do_compute_change(do_compute_change),
        .do_load_rem_from_bal(do_load_rem_from_bal),
        .do_clear_balance(do_clear_balance),
        .chg_sub_pulse(chg_sub_pulse),
        .chg_denom(chg_denom),
        .change_start_pulse(change_start_pulse),

        .dispense_valid(dispense_valid),
        .dispense_id(dispense_id),
        .change_pulse(change_pulse),
        .change_type(change_type),
        .status_code(status_code),
        .err_code(err_code)
    );

    vending_datapath u_datapath (
        .clkb(clkb),
        .rst_n(rst_n),

        .coin_valid(coin_valid),
        .coin_type(coin_type),
        .sel_id(sel_id),

        .do_add_coin(do_add_coin),
        .do_latch_sel(do_latch_sel),
        .do_dec_inv(do_dec_inv),
        .do_compute_change(do_compute_change),
        .do_load_rem_from_bal(do_load_rem_from_bal),
        .do_clear_balance(do_clear_balance),
        .chg_sub_pulse(chg_sub_pulse),
        .chg_denom(chg_denom),

        .soldout(soldout),
        .enough(enough),
        .rem_zero(rem_zero),
        .bank_enough(bank_enough),
        .balance_zero(balance_zero),
        .can25(can25),
        .can10(can10),
        .can5(can5),

        .sel_reg_out(sel_reg_out),
        .balance_out(balance_out),
        .change_rem_out(change_rem_out)
    );

endmodule