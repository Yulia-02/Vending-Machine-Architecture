`timescale 1ns/1ps

module vending_top #(
  parameter [5:0] INIT_PRICE0 = 6'd6,   // $30
  parameter [5:0] INIT_PRICE1 = 6'd8,   // $40
  parameter [5:0] INIT_PRICE2 = 6'd10,  // $50
  parameter [5:0] INIT_PRICE3 = 6'd12,  // $60
  parameter [3:0] INIT_INV    = 4'd8,   // product inventory 
  parameter [5:0] INIT_BANK   = 6'd10   // $50 
)(
  input  wire        clk,
  input  wire        rst_n,

  // External inputs
  input  wire        coin_valid,         // (1)
  input  wire [1:0]  coin_type,          // (2)
  input  wire        sel_valid,          // (1)
  input  wire [1:0]  sel_id,             // (2)
  input  wire        cancel,             // (1)

  // External outputs
  output reg         dispense_valid,     // (1) 1-cycle pulse in VEND
  output reg  [1:0]  dispense_id,        // (2)
  output reg         change_pulse,        // (1) 1-cycle pulse per returned coin
  output reg  [1:0]  change_type,         // (2)
  output reg  [1:0]  status_code,        // (2) 00=OK,01=BUSY,10=ERROR
  output reg  [1:0]  err_code            // (2) 00=none,01=soldout,10=nochange
);

  localparam [2:0]
    S_IDLE      = 3'd0,
    S_ACCEPT    = 3'd1,
    S_CHECK     = 3'd2,
    S_VEND      = 3'd3,
    S_MAKE_CHG  = 3'd4,
    S_WAIT_CHG  = 3'd5,
    S_RETURN    = 3'd6,
    S_ERROR     = 3'd7;

  localparam [2:0]
    C_IDLE = 3'd0,
    C_TRY25= 3'd1,
    C_TRY10= 3'd2,
    C_TRY5 = 3'd3,
    C_DONE = 3'd4;

  localparam [1:0]
    ERR_NONE     = 2'd0,
    ERR_SOLDOUT  = 2'd1,
    ERR_NOCHANGE = 2'd2;


  reg [2:0] state, next_state;
  reg [2:0] cstate, cnext_state;

  reg [5:0] balance;        // (6) in $5 units
  reg [5:0] change_bank;    // (6) in $5 units 
  reg [5:0] change_rem;     // (6) remaining change to return
  reg [1:0] sel_reg;        // (2) latched selection

  reg [5:0] price [0:3];    // (6) 
  reg [3:0] inv   [0:3];    // (4) 

  integer i;


  wire [5:0] price_sel = price[sel_reg];
  wire [3:0] inv_sel   = inv[sel_reg];

  wire soldout     = (inv_sel == 0);
  wire enough      = (balance >= price_sel);
  wire rem_zero    = (change_rem == 0);
  wire bank_enough = (change_bank >= change_rem);

  // Coin value decode 
  wire [5:0] coin_value =
      (coin_type==2'b00) ? 6'd1 :
      (coin_type==2'b01) ? 6'd2 :
      (coin_type==2'b10) ? 6'd5 : 6'd0;

  // Change can-subtract conditions 
  wire can25 = (change_rem >= 6'd5) && (change_bank >= 6'd5);
  wire can10 = (change_rem >= 6'd2) && (change_bank >= 6'd2);
  wire can5  = (change_rem >= 6'd1) && (change_bank >= 6'd1);

  reg do_add_coin;
  reg do_latch_sel;
  reg do_dec_inv;
  reg do_compute_change;      // change_rem = balance - price_sel
  reg do_load_rem_from_bal;   // change_rem = balance
  reg do_clear_balance;
  reg change_start_pulse;     // starts change FSM 
  reg chg_sub_pulse;          // 1-cycle subtract event
  reg [1:0] chg_denom;        // 10/01/00
  reg chg_done_pulse;         // 1-cycle done indicator from change FSM


  always @(negedge clk or negedge rst_n) begin
    if (!rst_n) state <= S_IDLE;
    else        state <= next_state;
  end

  always @(negedge clk or negedge rst_n) begin
    if (!rst_n) cstate <= C_IDLE;
    else        cstate <= cnext_state;
  end


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
      S_VEND: begin
        next_state = S_MAKE_CHG;
      end
      S_MAKE_CHG: begin
        if (rem_zero)          next_state = S_IDLE;
        else if (!bank_enough) next_state = S_ERROR;
        else                   next_state = S_WAIT_CHG;
      end
      S_WAIT_CHG: begin
        if (chg_done_pulse)  next_state = S_IDLE;
        else                 next_state = S_WAIT_CHG;
      end
      S_RETURN: begin
        if (balance == 0)    next_state = S_IDLE;
        else                 next_state = S_WAIT_CHG;
      end
      S_ERROR: begin
        if (cancel)          next_state = S_IDLE;
        else                 next_state = S_ERROR;
      end
      default: next_state = S_IDLE;
    endcase
  end

  
  always @(*) begin
    cnext_state = cstate;
    case (cstate)
      C_IDLE:   if (change_start_pulse) cnext_state = C_TRY25;
      C_TRY25:  if (can25)              cnext_state = C_TRY25;
                else                    cnext_state = C_TRY10;
      C_TRY10:  if (can10)              cnext_state = C_TRY10;
                else                    cnext_state = C_TRY5;
      C_TRY5:   if (can5)               cnext_state = C_TRY5;
                else                    cnext_state = C_DONE;
      C_DONE:   cnext_state = C_IDLE;
      default:  cnext_state = C_IDLE;
    endcase
  end

  
  always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
      do_add_coin          <= 1'b0;
      do_latch_sel         <= 1'b0;
      do_dec_inv           <= 1'b0;
      do_compute_change    <= 1'b0;
      do_load_rem_from_bal <= 1'b0;
      do_clear_balance     <= 1'b0;
      change_start_pulse   <= 1'b0;

      chg_sub_pulse        <= 1'b0;
      chg_denom            <= 2'b00;
      chg_done_pulse       <= 1'b0;

      dispense_valid       <= 1'b0;
      dispense_id          <= 2'b00;
      change_pulse         <= 1'b0;
      change_type          <= 2'b00;
      status_code          <= 2'b00;
      err_code             <= ERR_NONE;
    end else begin
      do_add_coin          <= 1'b0;
      do_latch_sel         <= 1'b0;
      do_dec_inv           <= 1'b0;
      do_compute_change    <= 1'b0;
      do_load_rem_from_bal <= 1'b0;
      do_clear_balance     <= 1'b0;
      change_start_pulse   <= 1'b0;

      chg_sub_pulse        <= 1'b0;
      chg_denom            <= 2'b00;
      chg_done_pulse       <= 1'b0;

      dispense_valid       <= 1'b0;
      dispense_id          <= sel_reg;
      change_pulse         <= 1'b0;
      change_type          <= 2'b00;

      status_code          <= 2'b01; // BUSY
      err_code             <= ERR_NONE;

      // Main FSM controls
      case (state)
        S_IDLE: begin
          status_code <= 2'b00;
          if (coin_valid)  do_add_coin  <= 1'b1;
          if (sel_valid)   do_latch_sel <= 1'b1;
        end
        S_ACCEPT: begin
          if (coin_valid)  do_add_coin  <= 1'b1;
          if (sel_valid)   do_latch_sel <= 1'b1;
        end
        S_CHECK: begin
          if (soldout) begin
            status_code <= 2'b10;
            err_code    <= ERR_SOLDOUT;
          end
        end
        S_VEND: begin
          dispense_valid    <= 1'b1;
          dispense_id       <= sel_reg;
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
          if (balance != 0) begin
            do_load_rem_from_bal <= 1'b1;
            change_start_pulse   <= 1'b1;
          end else begin
            status_code <= 2'b00;
          end
        end
        S_ERROR: begin
          status_code <= 2'b10;
        end
        default: ;
      endcase

      
      case (cstate)
        C_TRY25: if (can25) begin
          chg_sub_pulse <= 1'b1;
          chg_denom     <= 2'b10;
          change_pulse  <= 1'b1;
          change_type   <= 2'b10;
        end
        C_TRY10: if (can10) begin
          chg_sub_pulse <= 1'b1;
          chg_denom     <= 2'b01;
          change_pulse  <= 1'b1;
          change_type   <= 2'b01;
        end
        C_TRY5:  if (can5) begin
          chg_sub_pulse <= 1'b1;
          chg_denom     <= 2'b00;
          change_pulse  <= 1'b1;
          change_type   <= 2'b00;
        end
        C_DONE: begin
          chg_done_pulse <= 1'b1; 
          status_code    <= 2'b00;
          do_clear_balance <= 1'b1;
        end
        default: ;
      endcase
    end
  end


  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      balance     <= 6'd0;
      change_bank <= INIT_BANK;
      change_rem  <= 6'd0;
      sel_reg     <= 2'd0;

      price[0] <= INIT_PRICE0;
      price[1] <= INIT_PRICE1;
      price[2] <= INIT_PRICE2;
      price[3] <= INIT_PRICE3;

      for (i=0;i<4;i=i+1) inv[i] <= INIT_INV;
    end else begin
      if (do_add_coin) balance <= balance + coin_value;
      if (do_latch_sel) sel_reg <= sel_id;

      if (do_dec_inv) begin
        if (inv[sel_reg] != 0) inv[sel_reg] <= inv[sel_reg] - 1'b1;
      end

      if (do_compute_change) change_rem <= balance - price_sel;
      if (do_load_rem_from_bal) change_rem <= balance;

      if (chg_sub_pulse) begin
        case (chg_denom)
          2'b10: begin change_rem <= change_rem - 6'd5; change_bank <= change_bank - 6'd5; end
          2'b01: begin change_rem <= change_rem - 6'd2; change_bank <= change_bank - 6'd2; end
          2'b00: begin change_rem <= change_rem - 6'd1; change_bank <= change_bank - 6'd1; end
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
