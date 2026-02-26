/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Wed Feb 25 18:49:21 2026
/////////////////////////////////////////////////////////////


module vending_top ( clk, rst_n, coin_valid, coin_type, sel_valid, sel_id, 
        cancel, dispense_valid, dispense_id, change_pulse, change_type, 
        status_code, err_code );
  input [1:0] coin_type;
  input [1:0] sel_id;
  output [1:0] dispense_id;
  output [1:0] change_type;
  output [1:0] status_code;
  output [1:0] err_code;
  input clk, rst_n, coin_valid, sel_valid, cancel;
  output dispense_valid, change_pulse;
  wire   \inv[0][3] , \inv[0][2] , \inv[0][1] , \inv[0][0] , \inv[1][3] ,
         \inv[1][2] , \inv[1][1] , \inv[1][0] , \inv[2][3] , \inv[2][2] ,
         \inv[2][1] , \inv[2][0] , \inv[3][3] , \inv[3][2] , \inv[3][1] ,
         \inv[3][0] , enough, bank_enough, N58, N59, chg_done_pulse,
         change_start_pulse, do_add_coin, do_latch_sel, do_dec_inv,
         do_compute_change, do_load_rem_from_bal, do_clear_balance,
         chg_sub_pulse, N171, N174, N175, N176, N199, N200, N202, N203, N204,
         N207, N208, N209, N210, N211, N212, N232, N233, N234, N235, N236,
         N237, N268, N270, N271, N272, N273, N274, N276, N277, N278, N279,
         N281, N283, N284, N285, N287, N289, N290, N291, n30, n31, n32, n33,
         n36, n37, n40, n43, n46, n47, n48, n50, n54, n55, n57, n59, n60, n62,
         n64, n65, n67, n69, n70, n72, n73, n74, n75, n76, n77, n79, n80, n82,
         n83, n84, n86, n87, n88, n89, n91, n92, n93, n94, n96, n97, n98, n99,
         n101, n103, n104, n106, n107, n108, n109, n110, n111, n116, n117,
         n118, n119, n120, n121, n123, n124, n126, n128, n130, n132, n134,
         n136, n137, n138, n139, n140, n142, n144, n145, n146, n147, n150,
         n151, n152, n154, n155, n156, n159, n160, n163, n166, n167, n168,
         n170, n172, n174, n175, n176, n178, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n191, n192, n193, n194, n195, n196, n197,
         n198, n200, n201, n202, n203, n204, n205, n206, n207, n209, n210,
         n211, n213, n214, n215, n217, n218, n219, n220, n221, n223, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n241, n242, n246, n247, n250, n251, n252, n254,
         n255, n256, n257, n258, n259, n261, n262, n296, n298, n301, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334,
         n335, n336, n337, n339, n341, n342, n343, n344, n345, n346, n347,
         n349, n350, n354, \sub_315_S2/carry[2] , \sub_315_S2/carry[4] ,
         \sub_315_S2/carry[5] , \sub_315/carry[2] , \sub_315/carry[4] ,
         \sub_315/carry[5] , n355, n356, n357, n358, n359, n360, n361, n362,
         n363, n364, n365, n366, n367, n368, n369, n370, n371, n372, n373,
         n374, n375, n376, n377, n378, n379, n380, n381, n382, n383, n384,
         n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, n395,
         n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406,
         n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417,
         n418, n419, n420, n421, n422, n423, n424, n425, n426, n427, n428,
         n429, n430, n431, n432, n433, n434, n435, n436, n437, n438, n439,
         n440, n441, n442, n443, n444, n445, n446, n447, n448, n449, n450,
         n451, n452, n453, n454, n455, n456, n457, n458, n459, n460, n461,
         n462, n463, n464, n465, n466, n467, n468, n469, n470, n471, n472,
         n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483,
         n484, n485, n486, n487, n488, n489, n490, n491, n492, n493, n494,
         n495, n496, n497, n498;
  wire   [1:0] sel_reg;
  wire   [5:0] price_sel;
  wire   [5:0] balance;
  wire   [5:0] change_rem;
  wire   [5:0] change_bank;
  wire   [2:0] coin_value;
  wire   [2:0] state;
  wire   [2:0] cstate;
  wire   [1:0] chg_denom;
  wire   [6:0] \sub_316_S2/carry ;
  wire   [6:0] \sub_316/carry ;
  wire   [6:0] \sub_310_S2/carry ;
  wire   [5:1] \add_303_S2/carry ;

  DFFSR \inv_reg[3][0]  ( .D(n391), .CLK(clk), .R(n376), .S(1'b1), .Q(
        \inv[3][0] ) );
  DFFSR \inv_reg[3][2]  ( .D(n405), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[3][2] ) );
  DFFSR \sel_reg_reg[0]  ( .D(n298), .CLK(clk), .R(n375), .S(1'b1), .Q(
        sel_reg[0]) );
  DFFSR \sel_reg_reg[1]  ( .D(n296), .CLK(clk), .R(n375), .S(1'b1), .Q(
        sel_reg[1]) );
  DFFSR \inv_reg[1][0]  ( .D(n395), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[1][0] ) );
  DFFSR \inv_reg[1][2]  ( .D(n393), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[1][2] ) );
  DFFSR \inv_reg[2][0]  ( .D(n399), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[2][0] ) );
  DFFSR \inv_reg[2][2]  ( .D(n397), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[2][2] ) );
  DFFSR \inv_reg[0][0]  ( .D(n402), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[0][0] ) );
  DFFSR \inv_reg[0][2]  ( .D(n401), .CLK(clk), .R(n375), .S(1'b1), .Q(
        \inv[0][2] ) );
  DFFSR \inv_reg[3][1]  ( .D(n406), .CLK(n379), .R(n375), .S(1'b1), .Q(
        \inv[3][1] ) );
  DFFSR \inv_reg[1][1]  ( .D(n394), .CLK(n379), .R(n375), .S(1'b1), .Q(
        \inv[1][1] ) );
  DFFSR \inv_reg[2][1]  ( .D(n398), .CLK(n379), .R(n376), .S(1'b1), .Q(
        \inv[2][1] ) );
  DFFSR \inv_reg[0][1]  ( .D(n403), .CLK(n379), .R(n376), .S(1'b1), .Q(
        \inv[0][1] ) );
  DFFSR \inv_reg[3][3]  ( .D(n325), .CLK(n379), .R(1'b1), .S(rst_n), .Q(
        \inv[3][3] ) );
  DFFSR \inv_reg[1][3]  ( .D(n323), .CLK(n379), .R(1'b1), .S(n376), .Q(
        \inv[1][3] ) );
  DFFSR \inv_reg[2][3]  ( .D(n324), .CLK(n379), .R(1'b1), .S(rst_n), .Q(
        \inv[2][3] ) );
  DFFSR \inv_reg[0][3]  ( .D(n354), .CLK(n379), .R(1'b1), .S(rst_n), .Q(
        \inv[0][3] ) );
  DFFSR \change_rem_reg[5]  ( .D(n349), .CLK(n379), .R(n376), .S(1'b1), .Q(
        change_rem[5]) );
  DFFSR \change_bank_reg[4]  ( .D(n326), .CLK(n379), .R(n376), .S(1'b1), .Q(
        change_bank[4]) );
  DFFSR \change_bank_reg[5]  ( .D(n336), .CLK(n379), .R(n376), .S(1'b1), .Q(
        change_bank[5]) );
  DFFSR \change_bank_reg[3]  ( .D(n327), .CLK(n379), .R(1'b1), .S(n376), .Q(
        change_bank[3]) );
  DFFSR \change_bank_reg[0]  ( .D(n330), .CLK(n379), .R(n376), .S(1'b1), .Q(
        N274) );
  DFFSR \change_bank_reg[1]  ( .D(n329), .CLK(n378), .R(1'b1), .S(n375), .Q(
        change_bank[1]) );
  DFFSR \change_bank_reg[2]  ( .D(n328), .CLK(n378), .R(n376), .S(1'b1), .Q(
        change_bank[2]) );
  DFFSR \change_rem_reg[0]  ( .D(n335), .CLK(n378), .R(n376), .S(1'b1), .Q(
        N268) );
  DFFSR \balance_reg[0]  ( .D(n346), .CLK(n378), .R(n376), .S(1'b1), .Q(N232)
         );
  DFFSR \balance_reg[1]  ( .D(n345), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        balance[1]) );
  DFFSR \balance_reg[2]  ( .D(n344), .CLK(n378), .R(n376), .S(1'b1), .Q(
        balance[2]) );
  DFFSR \balance_reg[3]  ( .D(n343), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        balance[3]) );
  DFFSR \balance_reg[4]  ( .D(n342), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        balance[4]) );
  DFFSR \balance_reg[5]  ( .D(n341), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        balance[5]) );
  DFFSR \change_rem_reg[4]  ( .D(n334), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        change_rem[4]) );
  DFFSR \change_rem_reg[3]  ( .D(n333), .CLK(n378), .R(rst_n), .S(1'b1), .Q(
        change_rem[3]) );
  DFFSR \change_rem_reg[2]  ( .D(n332), .CLK(n378), .R(n376), .S(1'b1), .Q(
        change_rem[2]) );
  DFFSR \change_rem_reg[1]  ( .D(n331), .CLK(n378), .R(n375), .S(1'b1), .Q(
        change_rem[1]) );
  NAND3X1 U4 ( .A(n30), .B(n31), .C(n32), .Y(price_sel[3]) );
  NAND2X1 U6 ( .A(n31), .B(n33), .Y(price_sel[1]) );
  OAI22X1 U8 ( .A(n396), .B(n419), .C(n36), .D(n37), .Y(n323) );
  OAI22X1 U24 ( .A(n400), .B(n420), .C(n37), .D(n40), .Y(n324) );
  OAI22X1 U26 ( .A(n407), .B(n418), .C(n37), .D(n43), .Y(n325) );
  OAI21X1 U28 ( .A(n458), .B(n374), .C(n46), .Y(n326) );
  NAND2X1 U29 ( .A(n458), .B(n47), .Y(n46) );
  OAI21X1 U30 ( .A(n48), .B(n367), .C(n50), .Y(n47) );
  AOI22X1 U31 ( .A(N278), .B(n460), .C(N290), .D(n372), .Y(n50) );
  OAI21X1 U34 ( .A(n458), .B(n435), .C(n54), .Y(n327) );
  NAND2X1 U35 ( .A(n458), .B(n55), .Y(n54) );
  OAI21X1 U36 ( .A(n48), .B(n366), .C(n57), .Y(n55) );
  AOI22X1 U37 ( .A(N277), .B(n460), .C(N289), .D(n372), .Y(n57) );
  OAI21X1 U39 ( .A(n458), .B(n373), .C(n59), .Y(n328) );
  NAND2X1 U40 ( .A(n458), .B(n60), .Y(n59) );
  OAI21X1 U41 ( .A(n48), .B(n369), .C(n62), .Y(n60) );
  AOI22X1 U42 ( .A(N276), .B(n460), .C(n437), .D(n372), .Y(n62) );
  OAI21X1 U45 ( .A(n458), .B(n439), .C(n64), .Y(n329) );
  NAND2X1 U46 ( .A(n458), .B(n65), .Y(n64) );
  OAI21X1 U47 ( .A(n48), .B(n365), .C(n67), .Y(n65) );
  AOI22X1 U48 ( .A(n439), .B(n460), .C(N287), .D(n372), .Y(n67) );
  OAI21X1 U51 ( .A(n458), .B(n438), .C(n69), .Y(n330) );
  NAND2X1 U52 ( .A(n458), .B(n70), .Y(n69) );
  OAI21X1 U53 ( .A(n48), .B(N274), .C(n72), .Y(n70) );
  AOI22X1 U54 ( .A(N274), .B(n460), .C(n438), .D(n372), .Y(n72) );
  NAND2X1 U57 ( .A(n73), .B(n74), .Y(n331) );
  AOI22X1 U58 ( .A(n75), .B(n76), .C(balance[1]), .D(n77), .Y(n74) );
  OAI21X1 U59 ( .A(n48), .B(n362), .C(n79), .Y(n76) );
  AOI22X1 U60 ( .A(n452), .B(n460), .C(N281), .D(n372), .Y(n79) );
  AOI22X1 U62 ( .A(N233), .B(n80), .C(change_rem[1]), .D(n455), .Y(n73) );
  NAND2X1 U63 ( .A(n82), .B(n83), .Y(n332) );
  AOI22X1 U64 ( .A(n75), .B(n84), .C(balance[2]), .D(n77), .Y(n83) );
  OAI21X1 U65 ( .A(n48), .B(n363), .C(n86), .Y(n84) );
  AOI22X1 U66 ( .A(N270), .B(n460), .C(n440), .D(n372), .Y(n86) );
  AOI22X1 U68 ( .A(N234), .B(n80), .C(change_rem[2]), .D(n455), .Y(n82) );
  NAND2X1 U69 ( .A(n87), .B(n88), .Y(n333) );
  AOI22X1 U70 ( .A(n75), .B(n89), .C(balance[3]), .D(n77), .Y(n88) );
  OAI21X1 U71 ( .A(n48), .B(n364), .C(n91), .Y(n89) );
  AOI22X1 U72 ( .A(N271), .B(n460), .C(N283), .D(n372), .Y(n91) );
  AOI22X1 U74 ( .A(N235), .B(n80), .C(change_rem[3]), .D(n455), .Y(n87) );
  NAND2X1 U75 ( .A(n92), .B(n93), .Y(n334) );
  AOI22X1 U76 ( .A(n75), .B(n94), .C(balance[4]), .D(n77), .Y(n93) );
  OAI21X1 U77 ( .A(n48), .B(n361), .C(n96), .Y(n94) );
  AOI22X1 U78 ( .A(N272), .B(n460), .C(N284), .D(n372), .Y(n96) );
  AOI22X1 U80 ( .A(N236), .B(n80), .C(change_rem[4]), .D(n455), .Y(n92) );
  NAND2X1 U81 ( .A(n97), .B(n98), .Y(n335) );
  AOI22X1 U82 ( .A(n75), .B(n99), .C(N232), .D(n77), .Y(n98) );
  OAI21X1 U83 ( .A(n48), .B(N268), .C(n101), .Y(n99) );
  AOI22X1 U84 ( .A(N268), .B(n460), .C(n441), .D(n372), .Y(n101) );
  AOI22X1 U86 ( .A(N232), .B(n80), .C(N268), .D(n455), .Y(n97) );
  OAI21X1 U87 ( .A(n458), .B(n432), .C(n103), .Y(n336) );
  NAND2X1 U88 ( .A(n458), .B(n104), .Y(n103) );
  OAI21X1 U89 ( .A(n48), .B(n370), .C(n106), .Y(n104) );
  AOI22X1 U90 ( .A(N279), .B(n460), .C(N291), .D(n372), .Y(n106) );
  OAI21X1 U94 ( .A(n108), .B(n109), .C(n110), .Y(n337) );
  OAI21X1 U95 ( .A(change_start_pulse), .B(n111), .C(n467), .Y(n109) );
  NAND2X1 U96 ( .A(n457), .B(n461), .Y(n111) );
  AOI22X1 U97 ( .A(n425), .B(n461), .C(n116), .D(n457), .Y(n108) );
  OAI21X1 U98 ( .A(n425), .B(n117), .C(n118), .Y(n339) );
  NAND3X1 U99 ( .A(n119), .B(n467), .C(cstate[1]), .Y(n118) );
  OAI21X1 U101 ( .A(n121), .B(n448), .C(n123), .Y(n341) );
  NAND2X1 U102 ( .A(N212), .B(n124), .Y(n123) );
  OAI21X1 U103 ( .A(n447), .B(n121), .C(n126), .Y(n342) );
  NAND2X1 U104 ( .A(N211), .B(n124), .Y(n126) );
  OAI21X1 U105 ( .A(n446), .B(n121), .C(n128), .Y(n343) );
  NAND2X1 U106 ( .A(N210), .B(n124), .Y(n128) );
  OAI21X1 U107 ( .A(n445), .B(n121), .C(n130), .Y(n344) );
  NAND2X1 U108 ( .A(N209), .B(n124), .Y(n130) );
  OAI21X1 U109 ( .A(n444), .B(n121), .C(n132), .Y(n345) );
  NAND2X1 U110 ( .A(N208), .B(n124), .Y(n132) );
  OAI21X1 U111 ( .A(n443), .B(n121), .C(n134), .Y(n346) );
  NAND2X1 U112 ( .A(N207), .B(n124), .Y(n134) );
  OR2X1 U114 ( .A(do_add_coin), .B(do_clear_balance), .Y(n121) );
  NOR2X1 U115 ( .A(n119), .B(n136), .Y(n347) );
  NAND2X1 U116 ( .A(cstate[1]), .B(n467), .Y(n136) );
  NAND2X1 U117 ( .A(cstate[0]), .B(n137), .Y(n119) );
  NAND2X1 U118 ( .A(n138), .B(n139), .Y(n349) );
  AOI22X1 U119 ( .A(n75), .B(n140), .C(balance[5]), .D(n77), .Y(n139) );
  NOR2X1 U120 ( .A(n454), .B(n142), .Y(n77) );
  OAI21X1 U122 ( .A(n48), .B(n368), .C(n144), .Y(n140) );
  AOI22X1 U123 ( .A(N273), .B(n460), .C(N285), .D(n372), .Y(n144) );
  AOI22X1 U127 ( .A(N237), .B(n80), .C(change_rem[5]), .D(n455), .Y(n138) );
  NOR2X1 U129 ( .A(n142), .B(do_load_rem_from_bal), .Y(n80) );
  NAND3X1 U130 ( .A(n146), .B(n468), .C(n147), .Y(n142) );
  OAI21X1 U131 ( .A(n459), .B(n462), .C(chg_sub_pulse), .Y(n147) );
  NAND3X1 U132 ( .A(n107), .B(n468), .C(n150), .Y(n146) );
  NOR2X1 U133 ( .A(do_load_rem_from_bal), .B(do_compute_change), .Y(n150) );
  OAI21X1 U135 ( .A(n372), .B(n151), .C(chg_sub_pulse), .Y(n107) );
  NAND2X1 U136 ( .A(n48), .B(n145), .Y(n151) );
  NAND2X1 U137 ( .A(chg_denom[0]), .B(n462), .Y(n145) );
  NAND2X1 U139 ( .A(chg_denom[1]), .B(n459), .Y(n48) );
  NAND2X1 U142 ( .A(n152), .B(n386), .Y(n350) );
  OAI21X1 U144 ( .A(n155), .B(n156), .C(n429), .Y(n154) );
  AOI21X1 U145 ( .A(n465), .B(n159), .C(n160), .Y(n152) );
  OAI22X1 U146 ( .A(n381), .B(state[2]), .C(n464), .D(n163), .Y(n159) );
  OAI22X1 U147 ( .A(n404), .B(n421), .C(n37), .D(n166), .Y(n354) );
  NAND2X1 U148 ( .A(n167), .B(n168), .Y(n37) );
  OAI21X1 U150 ( .A(do_latch_sel), .B(n417), .C(n170), .Y(n296) );
  NAND2X1 U151 ( .A(sel_id[1]), .B(do_latch_sel), .Y(n170) );
  OAI21X1 U152 ( .A(do_latch_sel), .B(n414), .C(n172), .Y(n298) );
  NAND2X1 U153 ( .A(sel_id[0]), .B(do_latch_sel), .Y(n172) );
  AOI21X1 U154 ( .A(n389), .B(n174), .C(n175), .Y(n301) );
  AOI21X1 U155 ( .A(n176), .B(n453), .C(n160), .Y(n174) );
  NOR2X1 U156 ( .A(n178), .B(cancel), .Y(n160) );
  OAI21X1 U157 ( .A(n155), .B(n390), .C(n180), .Y(n176) );
  AOI21X1 U158 ( .A(n181), .B(enough), .C(n381), .Y(n180) );
  NOR2X1 U160 ( .A(state[0]), .B(n464), .Y(n181) );
  OAI21X1 U162 ( .A(n184), .B(n465), .C(n185), .Y(n183) );
  OAI21X1 U164 ( .A(n187), .B(n188), .C(n383), .Y(n186) );
  NOR2X1 U166 ( .A(n182), .B(n156), .Y(n175) );
  NAND3X1 U167 ( .A(n387), .B(n453), .C(n390), .Y(n156) );
  OAI21X1 U168 ( .A(n464), .B(n191), .C(n429), .Y(n188) );
  OAI21X1 U170 ( .A(n155), .B(n193), .C(n194), .Y(n192) );
  OR2X1 U171 ( .A(chg_done_pulse), .B(n453), .Y(n193) );
  OAI21X1 U172 ( .A(n453), .B(n390), .C(state[0]), .Y(n191) );
  OAI21X1 U173 ( .A(state[2]), .B(n195), .C(n196), .Y(n187) );
  AOI22X1 U174 ( .A(n197), .B(n387), .C(n198), .D(state[1]), .Y(n195) );
  OAI21X1 U176 ( .A(n465), .B(n390), .C(n182), .Y(n197) );
  NAND2X1 U177 ( .A(n464), .B(n384), .Y(n182) );
  NAND3X1 U181 ( .A(n464), .B(n453), .C(sel_valid), .Y(n184) );
  AOI22X1 U184 ( .A(n43), .B(\inv[3][0] ), .C(n202), .D(n407), .Y(n201) );
  AOI22X1 U186 ( .A(n43), .B(\inv[3][1] ), .C(n204), .D(n407), .Y(n203) );
  AOI22X1 U188 ( .A(n43), .B(\inv[3][2] ), .C(n206), .D(n407), .Y(n205) );
  NAND2X1 U190 ( .A(n207), .B(n416), .Y(n43) );
  AOI22X1 U192 ( .A(n166), .B(\inv[0][1] ), .C(n204), .D(n404), .Y(n209) );
  AOI22X1 U194 ( .A(n166), .B(\inv[0][0] ), .C(n202), .D(n404), .Y(n210) );
  AOI22X1 U196 ( .A(n166), .B(\inv[0][2] ), .C(n206), .D(n404), .Y(n211) );
  NAND2X1 U198 ( .A(n207), .B(n413), .Y(n166) );
  AOI22X1 U200 ( .A(n40), .B(\inv[2][0] ), .C(n202), .D(n400), .Y(n213) );
  AOI22X1 U202 ( .A(n40), .B(\inv[2][1] ), .C(n204), .D(n400), .Y(n214) );
  AOI22X1 U204 ( .A(n40), .B(\inv[2][2] ), .C(n206), .D(n400), .Y(n215) );
  NAND2X1 U206 ( .A(n207), .B(n409), .Y(n40) );
  AOI22X1 U208 ( .A(n36), .B(\inv[1][0] ), .C(n202), .D(n396), .Y(n217) );
  AOI22X1 U210 ( .A(n36), .B(\inv[1][1] ), .C(n204), .D(n396), .Y(n218) );
  OAI21X1 U211 ( .A(n202), .B(n219), .C(n220), .Y(n204) );
  AOI22X1 U213 ( .A(n36), .B(\inv[1][2] ), .C(n206), .D(n396), .Y(n221) );
  OAI21X1 U215 ( .A(n408), .B(n223), .C(n167), .Y(n206) );
  NAND2X1 U216 ( .A(n207), .B(n415), .Y(n36) );
  NOR2X1 U217 ( .A(n466), .B(n198), .Y(n207) );
  NOR2X1 U222 ( .A(coin_type[1]), .B(n385), .Y(coin_value[1]) );
  OAI21X1 U224 ( .A(n226), .B(n227), .C(n228), .Y(N204) );
  NAND2X1 U225 ( .A(n229), .B(state[2]), .Y(n227) );
  NAND2X1 U226 ( .A(n465), .B(n464), .Y(n226) );
  AOI21X1 U227 ( .A(n185), .B(n178), .C(n456), .Y(N203) );
  NAND3X1 U228 ( .A(state[1]), .B(state[0]), .C(state[2]), .Y(n178) );
  NOR2X1 U229 ( .A(N174), .B(n392), .Y(n185) );
  NAND3X1 U231 ( .A(n198), .B(state[1]), .C(n231), .Y(n230) );
  NOR2X1 U232 ( .A(state[2]), .B(state[0]), .Y(n231) );
  AOI21X1 U233 ( .A(n232), .B(n233), .C(n456), .Y(N202) );
  NAND3X1 U235 ( .A(n457), .B(n461), .C(cstate[2]), .Y(n228) );
  OAI21X1 U236 ( .A(n234), .B(state[0]), .C(n453), .Y(n233) );
  NOR2X1 U237 ( .A(n198), .B(n464), .Y(n234) );
  NOR2X1 U238 ( .A(n168), .B(n167), .Y(n198) );
  NAND2X1 U239 ( .A(n408), .B(n223), .Y(n167) );
  AOI22X1 U241 ( .A(\inv[1][2] ), .B(n415), .C(\inv[0][2] ), .D(n413), .Y(n236) );
  AOI22X1 U242 ( .A(\inv[3][2] ), .B(n416), .C(\inv[2][2] ), .D(n409), .Y(n235) );
  NAND2X1 U244 ( .A(n202), .B(n219), .Y(n220) );
  AOI22X1 U246 ( .A(\inv[1][1] ), .B(n415), .C(\inv[0][1] ), .D(n413), .Y(n238) );
  AOI22X1 U247 ( .A(\inv[3][1] ), .B(n416), .C(\inv[2][1] ), .D(n409), .Y(n237) );
  AOI22X1 U249 ( .A(\inv[0][0] ), .B(n413), .C(\inv[3][0] ), .D(n416), .Y(n240) );
  AOI22X1 U250 ( .A(\inv[2][0] ), .B(n409), .C(\inv[1][0] ), .D(n415), .Y(n239) );
  NAND2X1 U251 ( .A(n241), .B(n242), .Y(n168) );
  AOI22X1 U252 ( .A(\inv[1][3] ), .B(n415), .C(\inv[0][3] ), .D(n413), .Y(n242) );
  NAND2X1 U254 ( .A(n414), .B(n417), .Y(n33) );
  NAND2X1 U256 ( .A(sel_reg[0]), .B(n417), .Y(n32) );
  AOI22X1 U258 ( .A(\inv[3][3] ), .B(n416), .C(\inv[2][3] ), .D(n409), .Y(n241) );
  NAND2X1 U260 ( .A(sel_reg[1]), .B(n414), .Y(n31) );
  NAND2X1 U263 ( .A(sel_reg[0]), .B(sel_reg[1]), .Y(n30) );
  NOR2X1 U264 ( .A(N176), .B(n463), .Y(n232) );
  NAND2X1 U266 ( .A(state[0]), .B(n464), .Y(n155) );
  NAND3X1 U267 ( .A(n426), .B(n200), .C(n110), .Y(N200) );
  NAND3X1 U268 ( .A(cstate[0]), .B(n427), .C(n246), .Y(n110) );
  NOR2X1 U269 ( .A(cstate[2]), .B(n461), .Y(n246) );
  OAI21X1 U271 ( .A(N274), .B(n247), .C(n428), .Y(n137) );
  NAND3X1 U273 ( .A(n457), .B(n467), .C(n431), .Y(n200) );
  NAND3X1 U275 ( .A(n250), .B(n247), .C(cstate[1]), .Y(n116) );
  NAND3X1 U276 ( .A(n251), .B(n435), .C(n252), .Y(n247) );
  NOR2X1 U277 ( .A(change_bank[2]), .B(change_bank[1]), .Y(n252) );
  NOR2X1 U279 ( .A(change_bank[5]), .B(change_bank[4]), .Y(n251) );
  NOR2X1 U282 ( .A(n117), .B(n120), .Y(N199) );
  NAND2X1 U283 ( .A(N59), .B(N58), .Y(n120) );
  NAND3X1 U284 ( .A(n461), .B(n467), .C(cstate[0]), .Y(n117) );
  OAI21X1 U287 ( .A(n194), .B(n422), .C(n196), .Y(N176) );
  NAND3X1 U288 ( .A(state[2]), .B(state[1]), .C(n254), .Y(n196) );
  NOR2X1 U289 ( .A(state[0]), .B(n163), .Y(n254) );
  NOR2X1 U290 ( .A(n255), .B(n256), .Y(n163) );
  NAND3X1 U291 ( .A(n444), .B(n445), .C(n443), .Y(n256) );
  NAND3X1 U295 ( .A(n447), .B(n448), .C(n446), .Y(n255) );
  NOR2X1 U300 ( .A(n464), .B(n257), .Y(N175) );
  NAND2X1 U301 ( .A(state[0]), .B(n453), .Y(n257) );
  NOR2X1 U302 ( .A(n194), .B(bank_enough), .Y(N174) );
  NAND3X1 U303 ( .A(n465), .B(n464), .C(n258), .Y(n194) );
  NOR2X1 U304 ( .A(n229), .B(n453), .Y(n258) );
  NOR2X1 U305 ( .A(n250), .B(N268), .Y(n229) );
  NAND3X1 U306 ( .A(n259), .B(n450), .C(n261), .Y(n250) );
  NOR2X1 U307 ( .A(change_rem[2]), .B(change_rem[1]), .Y(n261) );
  NOR2X1 U309 ( .A(change_rem[5]), .B(change_rem[4]), .Y(n259) );
  NOR2X1 U311 ( .A(n384), .B(n262), .Y(N171) );
  NAND2X1 U312 ( .A(n464), .B(n453), .Y(n262) );
  FAX1 \sub_310_S2/U2_2  ( .A(balance[2]), .B(n355), .C(\sub_310_S2/carry [2]), 
        .YC(\sub_310_S2/carry [3]), .YS(N234) );
  FAX1 \sub_310_S2/U2_3  ( .A(balance[3]), .B(n412), .C(\sub_310_S2/carry [3]), 
        .YC(\sub_310_S2/carry [4]), .YS(N235) );
  FAX1 \add_303_S2/U1_1  ( .A(balance[1]), .B(coin_value[1]), .C(n358), .YC(
        \add_303_S2/carry [2]), .YS(N208) );
  FAX1 \add_303_S2/U1_2  ( .A(balance[2]), .B(coin_value[2]), .C(
        \add_303_S2/carry [2]), .YC(\add_303_S2/carry [3]), .YS(N209) );
  AND2X2 U113 ( .A(n121), .B(n468), .Y(n124) );
  AND2X2 U126 ( .A(chg_sub_pulse), .B(n468), .Y(n75) );
  AND2X2 U221 ( .A(n385), .B(coin_type[1]), .Y(coin_value[2]) );
  AND2X2 U240 ( .A(n235), .B(n236), .Y(n223) );
  AND2X2 U245 ( .A(n237), .B(n238), .Y(n219) );
  AND2X2 U248 ( .A(n239), .B(n240), .Y(n202) );
  INVX1 U358 ( .A(change_bank[4]), .Y(n374) );
  AND2X2 U359 ( .A(n30), .B(n33), .Y(n355) );
  AND2X2 U360 ( .A(\sub_315/carry[2] ), .B(change_rem[2]), .Y(n356) );
  AND2X2 U361 ( .A(\add_303_S2/carry [3]), .B(balance[3]), .Y(n357) );
  AND2X2 U362 ( .A(n385), .B(N232), .Y(n358) );
  AND2X2 U363 ( .A(n357), .B(balance[4]), .Y(n359) );
  AND2X2 U364 ( .A(\sub_315_S2/carry[2] ), .B(change_bank[2]), .Y(n360) );
  XOR2X1 U365 ( .A(\sub_315/carry[4] ), .B(change_rem[4]), .Y(n361) );
  XOR2X1 U366 ( .A(N268), .B(change_rem[1]), .Y(n362) );
  XNOR2X1 U367 ( .A(\sub_315/carry[2] ), .B(change_rem[2]), .Y(n363) );
  XOR2X1 U368 ( .A(n356), .B(change_rem[3]), .Y(n364) );
  XOR2X1 U369 ( .A(N274), .B(change_bank[1]), .Y(n365) );
  XOR2X1 U370 ( .A(n360), .B(change_bank[3]), .Y(n366) );
  XOR2X1 U371 ( .A(\sub_315_S2/carry[4] ), .B(change_bank[4]), .Y(n367) );
  XOR2X1 U372 ( .A(change_rem[5]), .B(\sub_315/carry[5] ), .Y(n368) );
  XNOR2X1 U373 ( .A(\sub_315_S2/carry[2] ), .B(change_bank[2]), .Y(n369) );
  XOR2X1 U374 ( .A(change_bank[5]), .B(\sub_315_S2/carry[5] ), .Y(n370) );
  INVX2 U375 ( .A(n145), .Y(n460) );
  INVX2 U376 ( .A(n107), .Y(n458) );
  INVX2 U377 ( .A(n377), .Y(n375) );
  INVX2 U378 ( .A(rst_n), .Y(n377) );
  INVX2 U379 ( .A(n377), .Y(n376) );
  INVX2 U380 ( .A(n371), .Y(n372) );
  INVX2 U381 ( .A(n380), .Y(n378) );
  INVX2 U382 ( .A(clk), .Y(n380) );
  INVX2 U383 ( .A(n380), .Y(n379) );
  OR2X1 U384 ( .A(chg_denom[1]), .B(chg_denom[0]), .Y(n371) );
  INVX2 U385 ( .A(change_bank[2]), .Y(n373) );
  INVX2 U386 ( .A(state[1]), .Y(n464) );
  INVX2 U387 ( .A(state[2]), .Y(n453) );
  OR2X1 U388 ( .A(change_bank[2]), .B(change_bank[1]), .Y(
        \sub_316_S2/carry [3]) );
  XNOR2X1 U389 ( .A(change_bank[1]), .B(change_bank[2]), .Y(N276) );
  OR2X1 U390 ( .A(change_bank[3]), .B(\sub_316_S2/carry [3]), .Y(
        \sub_316_S2/carry [4]) );
  XNOR2X1 U391 ( .A(\sub_316_S2/carry [3]), .B(change_bank[3]), .Y(N277) );
  OR2X1 U392 ( .A(change_bank[4]), .B(\sub_316_S2/carry [4]), .Y(
        \sub_316_S2/carry [5]) );
  XNOR2X1 U393 ( .A(\sub_316_S2/carry [4]), .B(change_bank[4]), .Y(N278) );
  XNOR2X1 U394 ( .A(change_bank[5]), .B(\sub_316_S2/carry [5]), .Y(N279) );
  OR2X1 U395 ( .A(change_rem[2]), .B(change_rem[1]), .Y(\sub_316/carry [3]) );
  XNOR2X1 U396 ( .A(change_rem[1]), .B(change_rem[2]), .Y(N270) );
  OR2X1 U397 ( .A(change_rem[3]), .B(\sub_316/carry [3]), .Y(
        \sub_316/carry [4]) );
  XNOR2X1 U398 ( .A(\sub_316/carry [3]), .B(change_rem[3]), .Y(N271) );
  OR2X1 U399 ( .A(change_rem[4]), .B(\sub_316/carry [4]), .Y(
        \sub_316/carry [5]) );
  XNOR2X1 U400 ( .A(\sub_316/carry [4]), .B(change_rem[4]), .Y(N272) );
  XNOR2X1 U401 ( .A(change_rem[5]), .B(\sub_316/carry [5]), .Y(N273) );
  OR2X1 U402 ( .A(change_bank[1]), .B(N274), .Y(\sub_315_S2/carry[2] ) );
  OR2X1 U403 ( .A(change_bank[3]), .B(n360), .Y(\sub_315_S2/carry[4] ) );
  OR2X1 U404 ( .A(change_bank[4]), .B(\sub_315_S2/carry[4] ), .Y(
        \sub_315_S2/carry[5] ) );
  OR2X1 U405 ( .A(change_rem[1]), .B(N268), .Y(\sub_315/carry[2] ) );
  OR2X1 U406 ( .A(change_rem[3]), .B(n356), .Y(\sub_315/carry[4] ) );
  OR2X1 U407 ( .A(change_rem[4]), .B(\sub_315/carry[4] ), .Y(
        \sub_315/carry[5] ) );
  OR2X1 U408 ( .A(balance[4]), .B(\sub_310_S2/carry [4]), .Y(
        \sub_310_S2/carry [5]) );
  XNOR2X1 U409 ( .A(\sub_310_S2/carry [4]), .B(balance[4]), .Y(N236) );
  XNOR2X1 U410 ( .A(balance[5]), .B(\sub_310_S2/carry [5]), .Y(N237) );
  OR2X1 U411 ( .A(balance[1]), .B(n410), .Y(\sub_310_S2/carry [2]) );
  XNOR2X1 U412 ( .A(n410), .B(balance[1]), .Y(N233) );
  XOR2X1 U413 ( .A(n385), .B(N232), .Y(N207) );
  XOR2X1 U414 ( .A(\add_303_S2/carry [3]), .B(balance[3]), .Y(N210) );
  XOR2X1 U415 ( .A(n357), .B(balance[4]), .Y(N211) );
  XOR2X1 U416 ( .A(balance[5]), .B(n359), .Y(N212) );
  INVX2 U417 ( .A(n182), .Y(n381) );
  INVX2 U418 ( .A(n186), .Y(n382) );
  INVX2 U419 ( .A(n175), .Y(n383) );
  INVX2 U420 ( .A(coin_valid), .Y(n384) );
  INVX2 U421 ( .A(coin_type[0]), .Y(n385) );
  INVX2 U422 ( .A(n154), .Y(n386) );
  INVX2 U423 ( .A(sel_valid), .Y(n387) );
  INVX2 U424 ( .A(n184), .Y(n388) );
  INVX2 U425 ( .A(n183), .Y(n389) );
  INVX2 U426 ( .A(cancel), .Y(n390) );
  INVX2 U427 ( .A(n201), .Y(n391) );
  INVX2 U428 ( .A(n230), .Y(n392) );
  INVX2 U429 ( .A(n221), .Y(n393) );
  INVX2 U430 ( .A(n218), .Y(n394) );
  INVX2 U431 ( .A(n217), .Y(n395) );
  INVX2 U432 ( .A(n36), .Y(n396) );
  INVX2 U433 ( .A(n215), .Y(n397) );
  INVX2 U434 ( .A(n214), .Y(n398) );
  INVX2 U435 ( .A(n213), .Y(n399) );
  INVX2 U436 ( .A(n40), .Y(n400) );
  INVX2 U437 ( .A(n211), .Y(n401) );
  INVX2 U438 ( .A(n210), .Y(n402) );
  INVX2 U439 ( .A(n209), .Y(n403) );
  INVX2 U440 ( .A(n166), .Y(n404) );
  INVX2 U441 ( .A(n205), .Y(n405) );
  INVX2 U442 ( .A(n203), .Y(n406) );
  INVX2 U443 ( .A(n43), .Y(n407) );
  INVX2 U444 ( .A(n220), .Y(n408) );
  INVX2 U445 ( .A(n31), .Y(n409) );
  INVX2 U446 ( .A(price_sel[1]), .Y(n410) );
  INVX2 U447 ( .A(n469), .Y(n411) );
  INVX2 U448 ( .A(price_sel[3]), .Y(n412) );
  INVX2 U449 ( .A(n33), .Y(n413) );
  INVX2 U450 ( .A(sel_reg[0]), .Y(n414) );
  INVX2 U451 ( .A(n32), .Y(n415) );
  INVX2 U452 ( .A(n30), .Y(n416) );
  INVX2 U453 ( .A(sel_reg[1]), .Y(n417) );
  INVX2 U454 ( .A(\inv[3][3] ), .Y(n418) );
  INVX2 U455 ( .A(\inv[1][3] ), .Y(n419) );
  INVX2 U456 ( .A(\inv[2][3] ), .Y(n420) );
  INVX2 U457 ( .A(\inv[0][3] ), .Y(n421) );
  INVX2 U458 ( .A(bank_enough), .Y(n422) );
  INVX2 U459 ( .A(n484), .Y(n423) );
  INVX2 U460 ( .A(change_rem[5]), .Y(n424) );
  INVX2 U461 ( .A(n120), .Y(n425) );
  INVX2 U462 ( .A(N199), .Y(n426) );
  INVX2 U463 ( .A(n137), .Y(n427) );
  INVX2 U464 ( .A(n229), .Y(n428) );
  INVX2 U465 ( .A(n192), .Y(n429) );
  INVX2 U466 ( .A(n200), .Y(n430) );
  INVX2 U467 ( .A(n116), .Y(n431) );
  INVX2 U468 ( .A(change_bank[5]), .Y(n432) );
  INVX2 U469 ( .A(n480), .Y(n433) );
  INVX2 U470 ( .A(n476), .Y(n434) );
  INVX2 U471 ( .A(change_bank[3]), .Y(n435) );
  INVX2 U472 ( .A(n475), .Y(n436) );
  INVX2 U473 ( .A(n495), .Y(n437) );
  INVX2 U474 ( .A(N274), .Y(n438) );
  INVX2 U475 ( .A(change_bank[1]), .Y(n439) );
  INVX2 U476 ( .A(n490), .Y(n440) );
  INVX2 U477 ( .A(N268), .Y(n441) );
  INVX2 U478 ( .A(n196), .Y(n442) );
  INVX2 U479 ( .A(N232), .Y(n443) );
  INVX2 U480 ( .A(balance[1]), .Y(n444) );
  INVX2 U481 ( .A(balance[2]), .Y(n445) );
  INVX2 U482 ( .A(balance[3]), .Y(n446) );
  INVX2 U483 ( .A(balance[4]), .Y(n447) );
  INVX2 U484 ( .A(balance[5]), .Y(n448) );
  INVX2 U485 ( .A(change_rem[4]), .Y(n449) );
  INVX2 U486 ( .A(change_rem[3]), .Y(n450) );
  INVX2 U487 ( .A(change_rem[2]), .Y(n451) );
  INVX2 U488 ( .A(change_rem[1]), .Y(n452) );
  INVX2 U489 ( .A(do_load_rem_from_bal), .Y(n454) );
  INVX2 U490 ( .A(n146), .Y(n455) );
  INVX2 U491 ( .A(n228), .Y(n456) );
  INVX2 U492 ( .A(cstate[0]), .Y(n457) );
  INVX2 U493 ( .A(chg_denom[0]), .Y(n459) );
  INVX2 U494 ( .A(cstate[1]), .Y(n461) );
  INVX2 U495 ( .A(chg_denom[1]), .Y(n462) );
  INVX2 U496 ( .A(n155), .Y(n463) );
  INVX2 U497 ( .A(state[0]), .Y(n465) );
  INVX2 U498 ( .A(do_dec_inv), .Y(n466) );
  INVX2 U499 ( .A(cstate[2]), .Y(n467) );
  INVX2 U500 ( .A(do_clear_balance), .Y(n468) );
  OAI22X1 U501 ( .A(n412), .B(balance[3]), .C(n355), .D(balance[2]), .Y(n469)
         );
  AOI21X1 U502 ( .A(balance[2]), .B(n355), .C(balance[1]), .Y(n470) );
  NAND2X1 U503 ( .A(n470), .B(price_sel[1]), .Y(n471) );
  AOI22X1 U504 ( .A(balance[3]), .B(n412), .C(n411), .D(n471), .Y(n473) );
  NOR2X1 U505 ( .A(balance[5]), .B(balance[4]), .Y(n472) );
  NAND2X1 U506 ( .A(n473), .B(n472), .Y(enough) );
  NOR2X1 U507 ( .A(n424), .B(change_bank[5]), .Y(n484) );
  AOI22X1 U508 ( .A(change_bank[4]), .B(n449), .C(change_bank[5]), .D(n424), 
        .Y(n483) );
  OAI21X1 U509 ( .A(change_bank[4]), .B(n449), .C(n423), .Y(n482) );
  NAND2X1 U510 ( .A(change_rem[3]), .B(n435), .Y(n476) );
  NAND3X1 U511 ( .A(n476), .B(n451), .C(change_bank[2]), .Y(n474) );
  OAI21X1 U512 ( .A(change_rem[3]), .B(n435), .C(n474), .Y(n480) );
  AOI22X1 U513 ( .A(n439), .B(change_rem[1]), .C(n438), .D(N268), .Y(n475) );
  OAI21X1 U514 ( .A(change_rem[1]), .B(n439), .C(n436), .Y(n479) );
  NOR2X1 U515 ( .A(change_bank[2]), .B(n451), .Y(n477) );
  OAI21X1 U516 ( .A(n434), .B(n477), .C(n433), .Y(n478) );
  OAI21X1 U517 ( .A(n480), .B(n479), .C(n478), .Y(n481) );
  OAI22X1 U518 ( .A(n484), .B(n483), .C(n482), .D(n481), .Y(bank_enough) );
  OAI21X1 U519 ( .A(N268), .B(change_rem[1]), .C(change_rem[2]), .Y(n486) );
  NOR2X1 U520 ( .A(change_rem[5]), .B(change_rem[4]), .Y(n485) );
  NAND3X1 U521 ( .A(n486), .B(n450), .C(n485), .Y(N58) );
  OAI21X1 U522 ( .A(N274), .B(change_bank[1]), .C(change_bank[2]), .Y(n488) );
  NOR2X1 U523 ( .A(change_bank[5]), .B(change_bank[4]), .Y(n487) );
  NAND3X1 U524 ( .A(n488), .B(n435), .C(n487), .Y(N59) );
  NAND2X1 U525 ( .A(n452), .B(n441), .Y(n489) );
  OAI21X1 U526 ( .A(n441), .B(n452), .C(n489), .Y(N281) );
  NOR2X1 U527 ( .A(n489), .B(change_rem[2]), .Y(n491) );
  AOI21X1 U528 ( .A(n489), .B(change_rem[2]), .C(n491), .Y(n490) );
  NAND2X1 U529 ( .A(n491), .B(n450), .Y(n492) );
  OAI21X1 U530 ( .A(n491), .B(n450), .C(n492), .Y(N283) );
  XNOR2X1 U531 ( .A(change_rem[4]), .B(n492), .Y(N284) );
  NOR2X1 U532 ( .A(change_rem[4]), .B(n492), .Y(n493) );
  XOR2X1 U533 ( .A(change_rem[5]), .B(n493), .Y(N285) );
  NAND2X1 U534 ( .A(n439), .B(n438), .Y(n494) );
  OAI21X1 U535 ( .A(n438), .B(n439), .C(n494), .Y(N287) );
  NOR2X1 U536 ( .A(n494), .B(change_bank[2]), .Y(n496) );
  AOI21X1 U537 ( .A(n494), .B(change_bank[2]), .C(n496), .Y(n495) );
  NAND2X1 U538 ( .A(n496), .B(n435), .Y(n497) );
  OAI21X1 U539 ( .A(n496), .B(n435), .C(n497), .Y(N289) );
  XNOR2X1 U540 ( .A(change_bank[4]), .B(n497), .Y(N290) );
  NOR2X1 U541 ( .A(change_bank[4]), .B(n497), .Y(n498) );
  XOR2X1 U542 ( .A(change_bank[5]), .B(n498), .Y(N291) );
  \**SEQGEN**  \cstate_reg[2]  ( .clear(n377), .preset(1'b0), .next_state(n347), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(cstate[2]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \cstate_reg[0]  ( .clear(n377), .preset(1'b0), .next_state(n337), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(cstate[0]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  chg_done_pulse_reg ( .clear(n377), .preset(1'b0), .next_state(
        n456), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        chg_done_pulse), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \state_reg[0]  ( .clear(n377), .preset(1'b0), .next_state(n350), 
        .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(state[0]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \state_reg[1]  ( .clear(n377), .preset(1'b0), .next_state(n301), 
        .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(state[1]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \state_reg[2]  ( .clear(n377), .preset(1'b0), .next_state(n382), 
        .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(state[2]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  do_add_coin_reg ( .clear(n377), .preset(1'b0), .next_state(N171), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(do_add_coin), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  dispense_valid_reg ( .clear(n377), .preset(1'b0), .next_state(
        N175), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        dispense_valid), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  do_dec_inv_reg ( .clear(n377), .preset(1'b0), .next_state(N175), 
        .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(do_dec_inv), 
        .QN(), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  do_compute_change_reg ( .clear(n377), .preset(1'b0), 
        .next_state(N175), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(do_compute_change), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  do_latch_sel_reg ( .clear(n377), .preset(1'b0), .next_state(
        n388), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        do_latch_sel), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \dispense_id_reg[0]  ( .clear(n377), .preset(1'b0), 
        .next_state(sel_reg[0]), .clocked_on(n380), .data_in(1'b0), .enable(
        1'b0), .Q(dispense_id[0]), .QN(), .synch_clear(1'b0), .synch_preset(
        1'b0), .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \cstate_reg[1]  ( .clear(n377), .preset(1'b0), .next_state(n339), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(cstate[1]), .QN(), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \change_type_reg[1]  ( .clear(n377), .preset(1'b0), 
        .next_state(N199), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(change_type[1]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \chg_denom_reg[1]  ( .clear(n377), .preset(1'b0), .next_state(
        N199), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        chg_denom[1]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  change_pulse_reg ( .clear(n377), .preset(1'b0), .next_state(
        N200), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        change_pulse), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  chg_sub_pulse_reg ( .clear(n377), .preset(1'b0), .next_state(
        N200), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        chg_sub_pulse), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \chg_denom_reg[0]  ( .clear(n377), .preset(1'b0), .next_state(
        n430), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        chg_denom[0]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  do_clear_balance_reg ( .clear(n377), .preset(1'b0), 
        .next_state(N204), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(do_clear_balance), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  do_load_rem_from_bal_reg ( .clear(n377), .preset(1'b0), 
        .next_state(n442), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(do_load_rem_from_bal), .QN(), .synch_clear(1'b0), .synch_preset(
        1'b0), .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  change_start_pulse_reg ( .clear(n377), .preset(1'b0), 
        .next_state(N176), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(change_start_pulse), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \dispense_id_reg[1]  ( .clear(n377), .preset(1'b0), 
        .next_state(sel_reg[1]), .clocked_on(n380), .data_in(1'b0), .enable(
        1'b0), .Q(dispense_id[1]), .QN(), .synch_clear(1'b0), .synch_preset(
        1'b0), .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \change_type_reg[0]  ( .clear(n377), .preset(1'b0), 
        .next_state(n430), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(change_type[0]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \status_code_reg[0]  ( .clear(n377), .preset(1'b0), 
        .next_state(N202), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(status_code[0]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \err_code_reg[1]  ( .clear(n377), .preset(1'b0), .next_state(
        N174), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        err_code[1]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \status_code_reg[1]  ( .clear(n377), .preset(1'b0), 
        .next_state(N203), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), 
        .Q(status_code[1]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \err_code_reg[0]  ( .clear(n377), .preset(1'b0), .next_state(
        n392), .clocked_on(n380), .data_in(1'b0), .enable(1'b0), .Q(
        err_code[0]), .QN(), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
endmodule

