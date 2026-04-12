`timescale 1ns/1ps

module vending_fsm(
    input  wire       clka,
    input  wire       rst_n,

    // external inputs observed by controller
    input  wire       coin_valid,
    input  wire       sel_valid,
    input  wire       cancel,

    // datapath flags
    input  wire       soldout,
    input  wire       enough,
    input  wire       rem_zero,
    input  wire       bank_enough,
    input  wire       balance_zero,
    input  wire       can25,
    input  wire       can10,
    input  wire       can5,

    // latched selected id from datapath
    input  wire [1:0] sel_reg_id,

    // control to datapath
    output reg        do_add_coin,
    output reg        do_latch_sel,
    output reg        do_dec_inv,
    output reg        do_compute_change,
    output reg        do_load_rem_from_bal,
    output reg        do_clear_balance,
    output reg        chg_sub_pulse,
    output reg  [1:0] chg_denom,
    output reg        change_start_pulse,

    // external outputs
    output reg        dispense_valid,
    output reg  [1:0] dispense_id,
    output reg        change_pulse,
    output reg  [1:0] change_type,
    output reg  [1:0] status_code,
    output reg  [1:0] err_code
);
    // main_FSM
    localparam [2:0]
        S_IDLE      = 3'd0,
        S_ACCEPT    = 3'd1,
        S_CHECK     = 3'd2,
        S_VEND      = 3'd3,
        S_MAKE_CHG  = 3'd4,
        S_WAIT_CHG  = 3'd5,
        S_RETURN    = 3'd6,
        S_ERROR     = 3'd7;

    // change_FSM
    localparam [2:0] 
        C_IDLE  = 3'd0,
        C_TRY25 = 3'd1,// greedy change return
        C_TRY10 = 3'd2,
        C_TRY5  = 3'd3,
        C_DONE  = 3'd4;

    localparam [1:0]
        ERR_NONE     = 2'd0,
        ERR_SOLDOUT  = 2'd1,
        ERR_NOCHANGE = 2'd2;

    reg [2:0] state, next_state; //main_FSM
    reg [2:0] cstate, cnext_state; //change_FSM
    reg       chg_done_pulse;

    // state registers
    always @(negedge clka) begin
        if (!rst_n)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always @(negedge clka) begin
        if (!rst_n)
            cstate <= C_IDLE;
        else
            cstate <= cnext_state;
    end

    // main_FSM next state 
    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (coin_valid)      next_state = S_ACCEPT;
                else if (sel_valid)  next_state = S_CHECK;
                else if (cancel)     next_state = S_RETURN;
            end

            S_ACCEPT: begin
                if (sel_valid)       next_state = S_CHECK;
                else if (cancel)     next_state = S_RETURN;
                else                 next_state = S_ACCEPT;
            end

            S_CHECK: begin
                if (soldout)         next_state = S_ERROR;
                else if (!enough)    next_state = S_ACCEPT;
                else                 next_state = S_VEND;
            end

            S_VEND:
                next_state = S_MAKE_CHG;

            S_MAKE_CHG: begin
                if (rem_zero)          next_state = S_IDLE;
                else if (!bank_enough) next_state = S_ERROR;
                else                   next_state = S_WAIT_CHG;
            end

            S_WAIT_CHG: begin
                if (chg_done_pulse) next_state = S_IDLE;
                else                next_state = S_WAIT_CHG;
            end

            S_RETURN: begin
                if (balance_zero) next_state = S_IDLE;
                else              next_state = S_WAIT_CHG;
            end

            S_ERROR: begin
                if (cancel) next_state = S_IDLE;
                else        next_state = S_ERROR;
            end

            default:
                next_state = S_IDLE;
        endcase
    end

    // change_FSM next state 
    always @(*) begin
        cnext_state = cstate;
        case (cstate)
            C_IDLE: begin
                if (change_start_pulse)
                    cnext_state = C_TRY25;
            end

            C_TRY25: begin
                if (rem_zero)
                    cnext_state = C_DONE;
                else if (can25)
                    cnext_state = C_TRY25;
                else
                    cnext_state = C_TRY10;
            end

            C_TRY10: begin
                if (rem_zero)
                    cnext_state = C_DONE;
                else if (can10)
                    cnext_state = C_TRY10;
                else
                    cnext_state = C_TRY5;
            end

            C_TRY5: begin
                if (rem_zero)
                    cnext_state = C_DONE;
                else if (can5)
                    cnext_state = C_TRY5;
                else
                    cnext_state = C_DONE;
            end

            C_DONE:
                cnext_state = C_IDLE;

            default:
                cnext_state = C_IDLE;
        endcase
    end

    // output/control register 
    always @(negedge clka) begin
        if (!rst_n) begin
            do_add_coin          <= 1'b0;
            do_latch_sel         <= 1'b0;
            do_dec_inv           <= 1'b0;
            do_compute_change    <= 1'b0;
            do_load_rem_from_bal <= 1'b0;
            do_clear_balance     <= 1'b0;
            chg_sub_pulse        <= 1'b0;
            chg_denom            <= 2'b00;
            change_start_pulse   <= 1'b0;
            chg_done_pulse       <= 1'b0;

            dispense_valid       <= 1'b0;
            dispense_id          <= 2'b00;
            change_pulse         <= 1'b0;
            change_type          <= 2'b00;
            status_code          <= 2'b00;
            err_code             <= ERR_NONE;
        end else begin
            // defaults each cycle
            do_add_coin          <= 1'b0;
            do_latch_sel         <= 1'b0;
            do_dec_inv           <= 1'b0;
            do_compute_change    <= 1'b0;
            do_load_rem_from_bal <= 1'b0;
            do_clear_balance     <= 1'b0;
            chg_sub_pulse        <= 1'b0;
            chg_denom            <= 2'b00;
            change_start_pulse   <= 1'b0;
            chg_done_pulse       <= 1'b0;

            dispense_valid       <= 1'b0;
            dispense_id          <= sel_reg_id;
            change_pulse         <= 1'b0;
            change_type          <= 2'b00;

            status_code          <= 2'b01; // BUSY default
            err_code             <= ERR_NONE;

            // main_FSM outputs
            case (state)
                S_IDLE: begin
                    status_code <= 2'b00; 
                    if (coin_valid)
                        do_add_coin <= 1'b1;
                    if (sel_valid)
                        do_latch_sel <= 1'b1;
                end

                S_ACCEPT: begin
                    if (coin_valid)
                        do_add_coin <= 1'b1;
                    if (sel_valid)
                        do_latch_sel <= 1'b1;
                end

                S_CHECK: begin
                    if (soldout) begin
                        status_code <= 2'b10;
                        err_code    <= ERR_SOLDOUT;
                    end
                end

                S_VEND: begin
                    dispense_valid    <= 1'b1;
                    dispense_id       <= sel_reg_id;
                    do_dec_inv        <= 1'b1;
                    do_compute_change <= 1'b1;
                end

                S_MAKE_CHG: begin
                    if (rem_zero) begin
                        do_clear_balance <= 1'b1;
                        status_code      <= 2'b00;
                    end else if (!bank_enough) begin
                        status_code <= 2'b10;
                        err_code    <= ERR_NOCHANGE;
                    end else begin
                        change_start_pulse <= 1'b1;
                    end
                end

                S_RETURN: begin
                    if (!balance_zero) begin
                        do_load_rem_from_bal <= 1'b1;
                        change_start_pulse   <= 1'b1;
                    end else begin
                        status_code <= 2'b00;
                    end
                end

                S_WAIT_CHG: begin
                    status_code <= 2'b01; // BUSY
                end

                S_ERROR: begin
                    status_code <= 2'b10;
                end
            endcase

            // change_FSM outputs
            case (cstate)
                C_TRY25: begin
                    if (can25) begin
                        chg_sub_pulse <= 1'b1;
                        chg_denom     <= 2'b10;
                        change_pulse  <= 1'b1;
                        change_type   <= 2'b10;
                    end
                end

                C_TRY10: begin
                    if (can10) begin
                        chg_sub_pulse <= 1'b1;
                        chg_denom     <= 2'b01;
                        change_pulse  <= 1'b1;
                        change_type   <= 2'b01;
                    end
                end

                C_TRY5: begin
                    if (can5) begin
                        chg_sub_pulse <= 1'b1;
                        chg_denom     <= 2'b00;
                        change_pulse  <= 1'b1;
                        change_type   <= 2'b00;
                    end
                end

                C_DONE: begin
                    chg_done_pulse   <= 1'b1;
                    do_clear_balance <= 1'b1;
                    status_code      <= 2'b00;
                end
            endcase
        end
    end

endmodule