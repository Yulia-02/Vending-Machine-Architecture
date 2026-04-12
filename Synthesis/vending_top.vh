/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Sun Apr 12 01:10:45 2026
/////////////////////////////////////////////////////////////


module vending_top ( clka, clkb, rst_n, coin_valid, coin_type, sel_valid, 
        sel_id, cancel, dispense_valid, dispense_id, change_pulse, change_type, 
        status_code, err_code );
  input [1:0] coin_type;
  input [1:0] sel_id;
  output [1:0] dispense_id;
  output [1:0] change_type;
  output [1:0] status_code;
  output [1:0] err_code;
  input clka, clkb, rst_n, coin_valid, sel_valid, cancel;
  output dispense_valid, change_pulse;
  wire   soldout, enough, rem_zero, bank_enough, balance_zero, can25, can10,
         can5, do_add_coin, do_latch_sel, do_dec_inv, do_compute_change,
         do_load_rem_from_bal, do_clear_balance, chg_sub_pulse, \u_fsm/n101 ,
         \u_fsm/n100 , \u_fsm/n99 , \u_fsm/n98 , \u_fsm/n97 , \u_fsm/n96 ,
         \u_fsm/n95 , \u_fsm/n94 , \u_fsm/n93 , \u_fsm/n92 , \u_fsm/n91 ,
         \u_fsm/n90 , \u_fsm/n89 , \u_fsm/n88 , \u_fsm/n87 , \u_fsm/n86 ,
         \u_fsm/n85 , \u_fsm/n84 , \u_fsm/n83 , \u_fsm/n82 , \u_fsm/n81 ,
         \u_fsm/n80 , \u_fsm/n79 , \u_fsm/n78 , \u_fsm/n77 , \u_fsm/n76 ,
         \u_fsm/n75 , \u_fsm/n74 , \u_fsm/n73 , \u_fsm/n72 , \u_fsm/n71 ,
         \u_fsm/n70 , \u_fsm/n69 , \u_fsm/n68 , \u_fsm/n67 , \u_fsm/n66 ,
         \u_fsm/n65 , \u_fsm/n64 , \u_fsm/n63 , \u_fsm/n62 , \u_fsm/n61 ,
         \u_fsm/n60 , \u_fsm/n59 , \u_fsm/n58 , \u_fsm/n57 , \u_fsm/n56 ,
         \u_fsm/n55 , \u_fsm/n54 , \u_fsm/n53 , \u_fsm/n52 , \u_fsm/n51 ,
         \u_fsm/n50 , \u_fsm/n49 , \u_fsm/n48 , \u_fsm/n47 , \u_fsm/n46 ,
         \u_fsm/n45 , \u_fsm/n44 , \u_fsm/n43 , \u_fsm/n42 , \u_fsm/n41 ,
         \u_fsm/n40 , \u_fsm/n39 , \u_fsm/n38 , \u_fsm/n37 , \u_fsm/n36 ,
         \u_fsm/n35 , \u_fsm/n34 , \u_fsm/N212 , \u_fsm/N211 , \u_fsm/N210 ,
         \u_fsm/N207 , \u_fsm/N206 , \u_fsm/N205 , \u_fsm/N204 , \u_fsm/N203 ,
         \u_fsm/N202 , \u_fsm/N201 , \u_fsm/N200 , \u_fsm/N199 , \u_fsm/N198 ,
         \u_fsm/chg_done_pulse , \u_fsm/change_start_pulse , \u_datapath/n248 ,
         \u_datapath/n247 , \u_datapath/n246 , \u_datapath/n245 ,
         \u_datapath/n244 , \u_datapath/n243 , \u_datapath/n242 ,
         \u_datapath/n241 , \u_datapath/n240 , \u_datapath/n239 ,
         \u_datapath/n238 , \u_datapath/n237 , \u_datapath/n236 ,
         \u_datapath/n235 , \u_datapath/n234 , \u_datapath/n233 ,
         \u_datapath/n232 , \u_datapath/n231 , \u_datapath/n230 ,
         \u_datapath/n229 , \u_datapath/n228 , \u_datapath/n227 ,
         \u_datapath/n226 , \u_datapath/n225 , \u_datapath/n224 ,
         \u_datapath/n223 , \u_datapath/n222 , \u_datapath/n221 ,
         \u_datapath/n220 , \u_datapath/n219 , \u_datapath/n218 ,
         \u_datapath/n217 , \u_datapath/n216 , \u_datapath/n215 ,
         \u_datapath/n214 , \u_datapath/n213 , \u_datapath/n212 ,
         \u_datapath/n211 , \u_datapath/n210 , \u_datapath/n209 ,
         \u_datapath/n208 , \u_datapath/n207 , \u_datapath/n206 ,
         \u_datapath/n205 , \u_datapath/n204 , \u_datapath/n203 ,
         \u_datapath/n202 , \u_datapath/n201 , \u_datapath/n200 ,
         \u_datapath/n199 , \u_datapath/n198 , \u_datapath/n197 ,
         \u_datapath/n196 , \u_datapath/n195 , \u_datapath/n194 ,
         \u_datapath/n193 , \u_datapath/n192 , \u_datapath/n191 ,
         \u_datapath/n190 , \u_datapath/n189 , \u_datapath/n188 ,
         \u_datapath/n187 , \u_datapath/n186 , \u_datapath/n185 ,
         \u_datapath/n184 , \u_datapath/n183 , \u_datapath/n182 ,
         \u_datapath/n181 , \u_datapath/n180 , \u_datapath/n179 ,
         \u_datapath/n178 , \u_datapath/n177 , \u_datapath/n176 ,
         \u_datapath/n175 , \u_datapath/n173 , \u_datapath/n172 ,
         \u_datapath/n171 , \u_datapath/n170 , \u_datapath/n169 ,
         \u_datapath/n168 , \u_datapath/n167 , \u_datapath/n166 ,
         \u_datapath/n165 , \u_datapath/n164 , \u_datapath/n163 ,
         \u_datapath/n162 , \u_datapath/n161 , \u_datapath/n160 ,
         \u_datapath/n159 , \u_datapath/n158 , \u_datapath/n157 ,
         \u_datapath/n156 , \u_datapath/n155 , \u_datapath/n154 ,
         \u_datapath/n153 , \u_datapath/n152 , \u_datapath/n151 ,
         \u_datapath/n150 , \u_datapath/n149 , \u_datapath/n148 ,
         \u_datapath/n147 , \u_datapath/n146 , \u_datapath/n145 ,
         \u_datapath/n144 , \u_datapath/n143 , \u_datapath/n142 ,
         \u_datapath/n141 , \u_datapath/n140 , \u_datapath/n139 ,
         \u_datapath/n138 , \u_datapath/n137 , \u_datapath/n134 ,
         \u_datapath/n133 , \u_datapath/n132 , \u_datapath/n131 ,
         \u_datapath/n130 , \u_datapath/n129 , \u_datapath/n128 ,
         \u_datapath/n127 , \u_datapath/n126 , \u_datapath/n125 ,
         \u_datapath/n124 , \u_datapath/n123 , \u_datapath/n122 ,
         \u_datapath/n121 , \u_datapath/n120 , \u_datapath/n119 ,
         \u_datapath/n118 , \u_datapath/n117 , \u_datapath/n116 ,
         \u_datapath/n115 , \u_datapath/n114 , \u_datapath/n113 ,
         \u_datapath/n112 , \u_datapath/n111 , \u_datapath/n103 ,
         \u_datapath/n100 , \u_datapath/n99 , \u_datapath/n98 ,
         \u_datapath/n97 , \u_datapath/N109 , \u_datapath/N108 ,
         \u_datapath/N107 , \u_datapath/N105 , \u_datapath/N103 ,
         \u_datapath/N102 , \u_datapath/N101 , \u_datapath/N99 ,
         \u_datapath/N97 , \u_datapath/N96 , \u_datapath/N95 ,
         \u_datapath/N94 , \u_datapath/N92 , \u_datapath/N91 ,
         \u_datapath/N90 , \u_datapath/N89 , \u_datapath/N88 ,
         \u_datapath/N86 , \u_datapath/N83 , \u_datapath/N81 ,
         \u_datapath/N55 , \u_datapath/N54 , \u_datapath/N53 ,
         \u_datapath/N52 , \u_datapath/N51 , \u_datapath/N50 ,
         \u_datapath/N35 , \u_datapath/N34 , \u_datapath/N33 ,
         \u_datapath/N32 , \u_datapath/N31 , \u_datapath/N30 ,
         \u_datapath/N25 , \u_datapath/N24 , \u_datapath/inv[0][3] ,
         \u_datapath/inv[0][2] , \u_datapath/inv[0][1] ,
         \u_datapath/inv[0][0] , \u_datapath/inv[1][3] ,
         \u_datapath/inv[1][2] , \u_datapath/inv[1][1] ,
         \u_datapath/inv[1][0] , \u_datapath/inv[2][3] ,
         \u_datapath/inv[2][2] , \u_datapath/inv[2][1] ,
         \u_datapath/inv[2][0] , \u_datapath/inv[3][3] ,
         \u_datapath/inv[3][2] , \u_datapath/inv[3][1] ,
         \u_datapath/inv[3][0] , \u_datapath/price_sel[1] ,
         \u_datapath/change_rem_out[1] , \u_datapath/change_rem_out[2] ,
         \u_datapath/change_rem_out[3] , \u_datapath/change_rem_out[4] ,
         \u_datapath/change_rem_out[5] , \u_datapath/balance_out[1] ,
         \u_datapath/balance_out[2] , \u_datapath/balance_out[3] ,
         \u_datapath/balance_out[4] , \u_datapath/balance_out[5] ,
         \u_datapath/sub_111/carry[2] , \u_datapath/sub_111/carry[4] ,
         \u_datapath/sub_111/carry[5] , \u_datapath/sub_112/carry[2] ,
         \u_datapath/sub_112/carry[4] , \u_datapath/sub_112/carry[5] , n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156;
  wire   [1:0] sel_reg_out;
  wire   [1:0] chg_denom;
  wire   [2:0] \u_fsm/cstate ;
  wire   [2:0] \u_fsm/state ;
  wire   [5:0] \u_datapath/change_bank ;
  wire   [2:0] \u_datapath/coin_value ;
  wire   [5:1] \u_datapath/add_94/carry ;
  wire   [6:0] \u_datapath/sub_103/carry ;
  wire   [6:0] \u_datapath/sub_115/carry ;
  wire   [6:0] \u_datapath/sub_116/carry ;

  NOR2X1 \u_fsm/U116  ( .A(\u_fsm/state [1]), .B(\u_fsm/state [2]), .Y(
        \u_fsm/n51 ) );
  NAND2X1 \u_fsm/U115  ( .A(\u_fsm/n51 ), .B(n23), .Y(\u_fsm/n98 ) );
  NOR2X1 \u_fsm/U114  ( .A(n47), .B(\u_fsm/n98 ), .Y(\u_fsm/N198 ) );
  NOR2X1 \u_fsm/U113  ( .A(n50), .B(\u_fsm/n98 ), .Y(\u_fsm/N199 ) );
  NOR2X1 \u_fsm/U112  ( .A(\u_fsm/state [0]), .B(balance_zero), .Y(\u_fsm/n97 ) );
  NAND2X1 \u_fsm/U111  ( .A(\u_fsm/n41 ), .B(\u_fsm/state [2]), .Y(\u_fsm/n63 ) );
  NOR2X1 \u_fsm/U110  ( .A(\u_fsm/n63 ), .B(n25), .Y(\u_fsm/N200 ) );
  NAND3X1 \u_fsm/U109  ( .A(n65), .B(n63), .C(\u_fsm/state [2]), .Y(
        \u_fsm/n95 ) );
  OR2X1 \u_fsm/U108  ( .A(\u_fsm/n95 ), .B(n26), .Y(\u_fsm/n96 ) );
  NAND3X1 \u_fsm/U107  ( .A(n73), .B(n72), .C(\u_fsm/cstate [2]), .Y(
        \u_fsm/n83 ) );
  NOR2X1 \u_fsm/U106  ( .A(\u_fsm/n83 ), .B(n25), .Y(\u_fsm/N203 ) );
  OAI21X1 \u_fsm/U105  ( .A(n95), .B(\u_fsm/n96 ), .C(n32), .Y(\u_fsm/N201 )
         );
  NOR2X1 \u_fsm/U104  ( .A(\u_fsm/n95 ), .B(rem_zero), .Y(\u_fsm/n85 ) );
  NAND2X1 \u_fsm/U103  ( .A(\u_fsm/n85 ), .B(n23), .Y(\u_fsm/n94 ) );
  OAI21X1 \u_fsm/U102  ( .A(n92), .B(\u_fsm/n94 ), .C(n31), .Y(\u_fsm/N202 )
         );
  NOR2X1 \u_fsm/U101  ( .A(n63), .B(n65), .Y(\u_fsm/n50 ) );
  OR2X1 \u_fsm/U100  ( .A(n24), .B(\u_fsm/state [2]), .Y(\u_fsm/n93 ) );
  NOR2X1 \u_fsm/U99  ( .A(n61), .B(\u_fsm/n93 ), .Y(\u_fsm/N204 ) );
  NAND3X1 \u_fsm/U98  ( .A(\u_fsm/cstate [1]), .B(n68), .C(\u_fsm/cstate [0]), 
        .Y(\u_fsm/n67 ) );
  NAND2X1 \u_fsm/U97  ( .A(can5), .B(n66), .Y(\u_fsm/n71 ) );
  NOR2X1 \u_fsm/U96  ( .A(\u_fsm/cstate [1]), .B(\u_fsm/cstate [2]), .Y(
        \u_fsm/n80 ) );
  NOR2X1 \u_fsm/U95  ( .A(n73), .B(n70), .Y(\u_fsm/n72 ) );
  NAND3X1 \u_fsm/U94  ( .A(\u_fsm/n72 ), .B(n23), .C(can25), .Y(\u_fsm/n92 )
         );
  NAND3X1 \u_fsm/U93  ( .A(n73), .B(n68), .C(\u_fsm/cstate [1]), .Y(
        \u_fsm/n66 ) );
  NAND3X1 \u_fsm/U92  ( .A(n67), .B(n23), .C(can10), .Y(\u_fsm/n91 ) );
  NOR2X1 \u_fsm/U91  ( .A(n40), .B(n41), .Y(\u_fsm/n90 ) );
  OAI21X1 \u_fsm/U90  ( .A(n24), .B(\u_fsm/n71 ), .C(\u_fsm/n90 ), .Y(
        \u_fsm/N207 ) );
  OAI21X1 \u_fsm/U89  ( .A(n63), .B(soldout), .C(n65), .Y(\u_fsm/n89 ) );
  OAI21X1 \u_fsm/U88  ( .A(\u_fsm/state [2]), .B(n62), .C(\u_fsm/n63 ), .Y(
        \u_fsm/n87 ) );
  OAI22X1 \u_fsm/U87  ( .A(\u_fsm/state [1]), .B(n65), .C(n60), .D(n92), .Y(
        \u_fsm/n88 ) );
  OAI21X1 \u_fsm/U86  ( .A(\u_fsm/n87 ), .B(\u_fsm/n88 ), .C(\u_fsm/n83 ), .Y(
        \u_fsm/n86 ) );
  NOR2X1 \u_fsm/U85  ( .A(n26), .B(\u_fsm/n86 ), .Y(\u_fsm/N210 ) );
  NAND3X1 \u_fsm/U84  ( .A(n23), .B(n92), .C(\u_fsm/n85 ), .Y(\u_fsm/n84 ) );
  OR2X1 \u_fsm/U83  ( .A(\u_fsm/state [0]), .B(\u_fsm/state [2]), .Y(
        \u_fsm/n38 ) );
  NAND2X1 \u_fsm/U82  ( .A(soldout), .B(\u_fsm/state [1]), .Y(\u_fsm/n48 ) );
  NOR3X1 \u_fsm/U81  ( .A(n24), .B(\u_fsm/n38 ), .C(\u_fsm/n48 ), .Y(
        \u_fsm/N212 ) );
  NOR2X1 \u_fsm/U80  ( .A(n42), .B(\u_fsm/N212 ), .Y(\u_fsm/n81 ) );
  NAND3X1 \u_fsm/U79  ( .A(\u_fsm/n50 ), .B(n23), .C(\u_fsm/state [2]), .Y(
        \u_fsm/n82 ) );
  AOI21X1 \u_fsm/U78  ( .A(\u_fsm/n81 ), .B(\u_fsm/n82 ), .C(n71), .Y(
        \u_fsm/N211 ) );
  OR2X1 \u_fsm/U77  ( .A(\u_fsm/cstate [0]), .B(\u_fsm/change_start_pulse ), 
        .Y(\u_fsm/n74 ) );
  NAND2X1 \u_fsm/U76  ( .A(n73), .B(n68), .Y(\u_fsm/n79 ) );
  OAI21X1 \u_fsm/U75  ( .A(can10), .B(\u_fsm/n79 ), .C(\u_fsm/n71 ), .Y(
        \u_fsm/n78 ) );
  OAI21X1 \u_fsm/U74  ( .A(\u_fsm/n77 ), .B(\u_fsm/n78 ), .C(n95), .Y(
        \u_fsm/n76 ) );
  OAI21X1 \u_fsm/U73  ( .A(\u_fsm/cstate [0]), .B(n70), .C(\u_fsm/n76 ), .Y(
        \u_fsm/n75 ) );
  OAI21X1 \u_fsm/U72  ( .A(n70), .B(\u_fsm/n74 ), .C(\u_fsm/n75 ), .Y(
        \u_fsm/n73 ) );
  NOR2X1 \u_fsm/U71  ( .A(n26), .B(\u_fsm/n73 ), .Y(\u_fsm/n101 ) );
  NOR2X1 \u_fsm/U70  ( .A(can25), .B(n69), .Y(\u_fsm/n69 ) );
  NAND2X1 \u_fsm/U69  ( .A(\u_fsm/n71 ), .B(\u_fsm/n66 ), .Y(\u_fsm/n70 ) );
  OAI21X1 \u_fsm/U68  ( .A(\u_fsm/n69 ), .B(\u_fsm/n70 ), .C(n95), .Y(
        \u_fsm/n68 ) );
  NOR2X1 \u_fsm/U67  ( .A(n26), .B(\u_fsm/n68 ), .Y(\u_fsm/n100 ) );
  NAND3X1 \u_fsm/U66  ( .A(n69), .B(\u_fsm/n66 ), .C(\u_fsm/n67 ), .Y(
        \u_fsm/n65 ) );
  AOI22X1 \u_fsm/U65  ( .A(rem_zero), .B(\u_fsm/n65 ), .C(n66), .D(n96), .Y(
        \u_fsm/n64 ) );
  NOR2X1 \u_fsm/U64  ( .A(\u_fsm/n64 ), .B(n25), .Y(\u_fsm/n99 ) );
  OAI21X1 \u_fsm/U63  ( .A(cancel), .B(n61), .C(\u_fsm/n63 ), .Y(\u_fsm/n53 )
         );
  NOR2X1 \u_fsm/U62  ( .A(\u_fsm/state [1]), .B(coin_valid), .Y(\u_fsm/n37 )
         );
  OAI22X1 \u_fsm/U61  ( .A(n65), .B(n52), .C(\u_fsm/state [0]), .D(n48), .Y(
        \u_fsm/n61 ) );
  NAND2X1 \u_fsm/U60  ( .A(\u_fsm/n48 ), .B(n61), .Y(\u_fsm/n62 ) );
  AOI21X1 \u_fsm/U59  ( .A(\u_fsm/n61 ), .B(n50), .C(\u_fsm/n62 ), .Y(
        \u_fsm/n57 ) );
  OR2X1 \u_fsm/U58  ( .A(\u_fsm/state [1]), .B(\u_fsm/chg_done_pulse ), .Y(
        \u_fsm/n59 ) );
  NAND2X1 \u_fsm/U57  ( .A(\u_fsm/state [2]), .B(\u_fsm/state [0]), .Y(
        \u_fsm/n60 ) );
  OAI21X1 \u_fsm/U56  ( .A(\u_fsm/n59 ), .B(\u_fsm/n60 ), .C(n60), .Y(
        \u_fsm/n58 ) );
  OAI21X1 \u_fsm/U55  ( .A(\u_fsm/state [2]), .B(\u_fsm/n57 ), .C(n59), .Y(
        \u_fsm/n54 ) );
  NAND2X1 \u_fsm/U54  ( .A(n50), .B(n52), .Y(\u_fsm/n39 ) );
  OR2X1 \u_fsm/U53  ( .A(\u_fsm/n39 ), .B(n48), .Y(\u_fsm/n56 ) );
  OAI21X1 \u_fsm/U52  ( .A(\u_fsm/n38 ), .B(\u_fsm/n56 ), .C(n23), .Y(
        \u_fsm/n55 ) );
  OAI21X1 \u_fsm/U51  ( .A(\u_fsm/n53 ), .B(\u_fsm/n54 ), .C(n46), .Y(
        \u_fsm/n52 ) );
  NAND2X1 \u_fsm/U50  ( .A(\u_fsm/state [0]), .B(\u_fsm/n39 ), .Y(\u_fsm/n49 )
         );
  NAND3X1 \u_fsm/U49  ( .A(\u_fsm/n50 ), .B(n52), .C(\u_fsm/state [2]), .Y(
        \u_fsm/n42 ) );
  OAI21X1 \u_fsm/U48  ( .A(n64), .B(\u_fsm/n49 ), .C(\u_fsm/n42 ), .Y(
        \u_fsm/n44 ) );
  NAND2X1 \u_fsm/U47  ( .A(n48), .B(\u_fsm/n48 ), .Y(\u_fsm/n47 ) );
  AOI21X1 \u_fsm/U46  ( .A(enough), .B(\u_fsm/state [1]), .C(\u_fsm/n47 ), .Y(
        \u_fsm/n46 ) );
  OAI22X1 \u_fsm/U45  ( .A(bank_enough), .B(n60), .C(\u_fsm/n46 ), .D(
        \u_fsm/n38 ), .Y(\u_fsm/n45 ) );
  OAI21X1 \u_fsm/U44  ( .A(\u_fsm/n44 ), .B(\u_fsm/n45 ), .C(n46), .Y(
        \u_fsm/n43 ) );
  NOR2X1 \u_fsm/U43  ( .A(n51), .B(\u_fsm/n41 ), .Y(\u_fsm/n40 ) );
  OAI21X1 \u_fsm/U42  ( .A(\u_fsm/n39 ), .B(n64), .C(\u_fsm/n40 ), .Y(
        \u_fsm/n35 ) );
  OAI21X1 \u_fsm/U41  ( .A(\u_fsm/n37 ), .B(\u_fsm/n38 ), .C(n59), .Y(
        \u_fsm/n36 ) );
  OAI21X1 \u_fsm/U40  ( .A(\u_fsm/n35 ), .B(\u_fsm/n36 ), .C(n46), .Y(
        \u_fsm/n34 ) );
  AND2X2 \u_fsm/U6  ( .A(\u_fsm/n97 ), .B(\u_fsm/state [1]), .Y(\u_fsm/n41 )
         );
  AND2X2 \u_fsm/U5  ( .A(sel_reg_out[0]), .B(n23), .Y(\u_fsm/N205 ) );
  AND2X2 \u_fsm/U4  ( .A(sel_reg_out[1]), .B(n23), .Y(\u_fsm/N206 ) );
  AND2X2 \u_fsm/U3  ( .A(\u_fsm/n80 ), .B(can25), .Y(\u_fsm/n77 ) );
  DFFNEGX1 \u_fsm/do_compute_change_reg  ( .D(\u_fsm/N204 ), .CLK(clka), .Q(
        do_compute_change) );
  DFFNEGX1 \u_fsm/do_dec_inv_reg  ( .D(\u_fsm/N204 ), .CLK(clka), .Q(
        do_dec_inv) );
  DFFNEGX1 \u_fsm/do_latch_sel_reg  ( .D(\u_fsm/N199 ), .CLK(clka), .Q(
        do_latch_sel) );
  DFFNEGX1 \u_fsm/do_add_coin_reg  ( .D(\u_fsm/N198 ), .CLK(clka), .Q(
        do_add_coin) );
  DFFNEGX1 \u_fsm/err_code_reg[0]  ( .D(\u_fsm/N212 ), .CLK(clka), .Q(
        err_code[0]) );
  DFFNEGX1 \u_fsm/err_code_reg[1]  ( .D(n42), .CLK(clka), .Q(err_code[1]) );
  DFFNEGX1 \u_fsm/chg_sub_pulse_reg  ( .D(\u_fsm/N207 ), .CLK(clka), .Q(
        chg_sub_pulse) );
  DFFNEGX1 \u_fsm/chg_denom_reg[0]  ( .D(n41), .CLK(clka), .Q(chg_denom[0]) );
  DFFNEGX1 \u_fsm/chg_denom_reg[1]  ( .D(n40), .CLK(clka), .Q(chg_denom[1]) );
  DFFNEGX1 \u_fsm/do_clear_balance_reg  ( .D(\u_fsm/N201 ), .CLK(clka), .Q(
        do_clear_balance) );
  DFFNEGX1 \u_fsm/change_type_reg[0]  ( .D(n41), .CLK(clka), .Q(change_type[0]) );
  DFFNEGX1 \u_fsm/change_pulse_reg  ( .D(\u_fsm/N207 ), .CLK(clka), .Q(
        change_pulse) );
  DFFNEGX1 \u_fsm/status_code_reg[1]  ( .D(\u_fsm/N211 ), .CLK(clka), .Q(
        status_code[1]) );
  DFFNEGX1 \u_fsm/do_load_rem_from_bal_reg  ( .D(\u_fsm/N200 ), .CLK(clka), 
        .Q(do_load_rem_from_bal) );
  DFFNEGX1 \u_fsm/status_code_reg[0]  ( .D(\u_fsm/N210 ), .CLK(clka), .Q(
        status_code[0]) );
  DFFNEGX1 \u_fsm/dispense_valid_reg  ( .D(\u_fsm/N204 ), .CLK(clka), .Q(
        dispense_valid) );
  DFFNEGX1 \u_fsm/state_reg[1]  ( .D(n44), .CLK(clka), .Q(\u_fsm/state [1]) );
  DFFNEGX1 \u_fsm/state_reg[2]  ( .D(n43), .CLK(clka), .Q(\u_fsm/state [2]) );
  DFFNEGX1 \u_fsm/state_reg[0]  ( .D(n45), .CLK(clka), .Q(\u_fsm/state [0]) );
  DFFNEGX1 \u_fsm/chg_done_pulse_reg  ( .D(\u_fsm/N203 ), .CLK(clka), .Q(
        \u_fsm/chg_done_pulse ) );
  DFFNEGX1 \u_fsm/cstate_reg[2]  ( .D(\u_fsm/n99 ), .CLK(clka), .Q(
        \u_fsm/cstate [2]) );
  DFFNEGX1 \u_fsm/change_type_reg[1]  ( .D(n40), .CLK(clka), .Q(change_type[1]) );
  DFFNEGX1 \u_fsm/cstate_reg[1]  ( .D(\u_fsm/n100 ), .CLK(clka), .Q(
        \u_fsm/cstate [1]) );
  DFFNEGX1 \u_fsm/cstate_reg[0]  ( .D(\u_fsm/n101 ), .CLK(clka), .Q(
        \u_fsm/cstate [0]) );
  DFFNEGX1 \u_fsm/change_start_pulse_reg  ( .D(\u_fsm/N202 ), .CLK(clka), .Q(
        \u_fsm/change_start_pulse ) );
  DFFNEGX1 \u_fsm/dispense_id_reg[0]  ( .D(\u_fsm/N205 ), .CLK(clka), .Q(
        dispense_id[0]) );
  DFFNEGX1 \u_fsm/dispense_id_reg[1]  ( .D(\u_fsm/N206 ), .CLK(clka), .Q(
        dispense_id[1]) );
  NOR2X1 \u_datapath/U274  ( .A(\u_datapath/change_rem_out[5] ), .B(
        \u_datapath/change_rem_out[4] ), .Y(\u_datapath/n211 ) );
  NOR2X1 \u_datapath/U273  ( .A(\u_datapath/change_rem_out[2] ), .B(
        \u_datapath/change_rem_out[1] ), .Y(\u_datapath/n212 ) );
  NAND3X1 \u_datapath/U272  ( .A(\u_datapath/n211 ), .B(n101), .C(
        \u_datapath/n212 ), .Y(\u_datapath/n207 ) );
  NOR2X1 \u_datapath/U271  ( .A(\u_datapath/change_bank [5]), .B(
        \u_datapath/change_bank [4]), .Y(\u_datapath/n209 ) );
  NOR2X1 \u_datapath/U270  ( .A(\u_datapath/change_bank [2]), .B(
        \u_datapath/change_bank [1]), .Y(\u_datapath/n210 ) );
  NAND3X1 \u_datapath/U269  ( .A(\u_datapath/n209 ), .B(n121), .C(
        \u_datapath/n210 ), .Y(\u_datapath/n208 ) );
  NOR2X1 \u_datapath/U268  ( .A(\u_datapath/n207 ), .B(\u_datapath/N86 ), .Y(
        rem_zero) );
  AOI21X1 \u_datapath/U267  ( .A(n120), .B(n126), .C(rem_zero), .Y(can5) );
  NOR2X1 \u_datapath/U266  ( .A(coin_type[1]), .B(n49), .Y(
        \u_datapath/coin_value [1]) );
  NAND3X1 \u_datapath/U265  ( .A(n114), .B(n113), .C(n115), .Y(
        \u_datapath/n205 ) );
  NAND3X1 \u_datapath/U264  ( .A(n117), .B(n116), .C(n118), .Y(
        \u_datapath/n206 ) );
  NOR2X1 \u_datapath/U263  ( .A(\u_datapath/n205 ), .B(\u_datapath/n206 ), .Y(
        balance_zero) );
  NOR2X1 \u_datapath/U262  ( .A(n112), .B(sel_reg_out[0]), .Y(\u_datapath/n99 ) );
  NOR2X1 \u_datapath/U261  ( .A(n112), .B(n108), .Y(\u_datapath/n100 ) );
  AOI22X1 \u_datapath/U260  ( .A(\u_datapath/inv[2][3] ), .B(\u_datapath/n99 ), 
        .C(\u_datapath/inv[3][3] ), .D(\u_datapath/n100 ), .Y(
        \u_datapath/n203 ) );
  NOR2X1 \u_datapath/U259  ( .A(sel_reg_out[0]), .B(sel_reg_out[1]), .Y(
        \u_datapath/n97 ) );
  NOR2X1 \u_datapath/U258  ( .A(n108), .B(sel_reg_out[1]), .Y(\u_datapath/n98 ) );
  AOI22X1 \u_datapath/U257  ( .A(\u_datapath/inv[0][3] ), .B(\u_datapath/n97 ), 
        .C(\u_datapath/inv[1][3] ), .D(\u_datapath/n98 ), .Y(\u_datapath/n204 ) );
  NAND2X1 \u_datapath/U256  ( .A(\u_datapath/n203 ), .B(\u_datapath/n204 ), 
        .Y(\u_datapath/n127 ) );
  AOI22X1 \u_datapath/U255  ( .A(\u_datapath/inv[2][0] ), .B(\u_datapath/n99 ), 
        .C(\u_datapath/inv[3][0] ), .D(\u_datapath/n100 ), .Y(
        \u_datapath/n201 ) );
  AOI22X1 \u_datapath/U254  ( .A(\u_datapath/inv[0][0] ), .B(\u_datapath/n97 ), 
        .C(\u_datapath/inv[1][0] ), .D(\u_datapath/n98 ), .Y(\u_datapath/n202 ) );
  AOI22X1 \u_datapath/U253  ( .A(\u_datapath/inv[2][1] ), .B(\u_datapath/n99 ), 
        .C(\u_datapath/inv[3][1] ), .D(\u_datapath/n100 ), .Y(
        \u_datapath/n199 ) );
  AOI22X1 \u_datapath/U252  ( .A(\u_datapath/inv[0][1] ), .B(\u_datapath/n97 ), 
        .C(\u_datapath/inv[1][1] ), .D(\u_datapath/n98 ), .Y(\u_datapath/n200 ) );
  NAND2X1 \u_datapath/U251  ( .A(\u_datapath/n122 ), .B(\u_datapath/n123 ), 
        .Y(\u_datapath/n118 ) );
  AOI22X1 \u_datapath/U250  ( .A(\u_datapath/inv[2][2] ), .B(\u_datapath/n99 ), 
        .C(\u_datapath/inv[3][2] ), .D(\u_datapath/n100 ), .Y(
        \u_datapath/n197 ) );
  AOI22X1 \u_datapath/U249  ( .A(\u_datapath/inv[0][2] ), .B(\u_datapath/n97 ), 
        .C(\u_datapath/inv[1][2] ), .D(\u_datapath/n98 ), .Y(\u_datapath/n198 ) );
  NAND2X1 \u_datapath/U248  ( .A(\u_datapath/n197 ), .B(\u_datapath/n198 ), 
        .Y(\u_datapath/n119 ) );
  NOR3X1 \u_datapath/U247  ( .A(\u_datapath/n127 ), .B(\u_datapath/n118 ), .C(
        \u_datapath/n119 ), .Y(soldout) );
  NOR2X1 \u_datapath/U246  ( .A(n57), .B(chg_denom[0]), .Y(\u_datapath/n185 )
         );
  NAND2X1 \u_datapath/U244  ( .A(n54), .B(n3), .Y(\u_datapath/n196 ) );
  OAI21X1 \u_datapath/U243  ( .A(n1), .B(\u_datapath/n196 ), .C(chg_sub_pulse), 
        .Y(\u_datapath/n195 ) );
  NOR2X1 \u_datapath/U241  ( .A(n4), .B(n25), .Y(\u_datapath/n176 ) );
  AOI22X1 \u_datapath/U240  ( .A(n126), .B(n22), .C(\u_datapath/N92 ), .D(n1), 
        .Y(\u_datapath/n194 ) );
  OAI21X1 \u_datapath/U239  ( .A(n54), .B(\u_datapath/N92 ), .C(
        \u_datapath/n194 ), .Y(\u_datapath/n193 ) );
  NAND2X1 \u_datapath/U238  ( .A(\u_datapath/n176 ), .B(\u_datapath/n193 ), 
        .Y(\u_datapath/n192 ) );
  OAI21X1 \u_datapath/U237  ( .A(n21), .B(n126), .C(\u_datapath/n192 ), .Y(
        \u_datapath/n248 ) );
  OAI21X1 \u_datapath/U236  ( .A(n3), .B(n123), .C(n23), .Y(\u_datapath/n190 )
         );
  AOI22X1 \u_datapath/U235  ( .A(n124), .B(n1), .C(\u_datapath/N81 ), .D(
        \u_datapath/n185 ), .Y(\u_datapath/n191 ) );
  OAI21X1 \u_datapath/U234  ( .A(\u_datapath/n190 ), .B(n55), .C(n21), .Y(
        \u_datapath/n189 ) );
  OAI21X1 \u_datapath/U233  ( .A(n21), .B(n124), .C(\u_datapath/n189 ), .Y(
        \u_datapath/n247 ) );
  AOI22X1 \u_datapath/U232  ( .A(n122), .B(n22), .C(\u_datapath/N94 ), .D(n1), 
        .Y(\u_datapath/n188 ) );
  OAI21X1 \u_datapath/U231  ( .A(n54), .B(n18), .C(\u_datapath/n188 ), .Y(
        \u_datapath/n187 ) );
  NAND2X1 \u_datapath/U230  ( .A(\u_datapath/n176 ), .B(\u_datapath/n187 ), 
        .Y(\u_datapath/n186 ) );
  OAI21X1 \u_datapath/U229  ( .A(n21), .B(n20), .C(\u_datapath/n186 ), .Y(
        \u_datapath/n246 ) );
  OAI21X1 \u_datapath/U228  ( .A(n3), .B(n119), .C(n23), .Y(\u_datapath/n183 )
         );
  AOI22X1 \u_datapath/U227  ( .A(\u_datapath/N95 ), .B(n1), .C(
        \u_datapath/N83 ), .D(\u_datapath/n185 ), .Y(\u_datapath/n184 ) );
  OAI21X1 \u_datapath/U226  ( .A(\u_datapath/n183 ), .B(n56), .C(n21), .Y(
        \u_datapath/n182 ) );
  OAI21X1 \u_datapath/U225  ( .A(n21), .B(n121), .C(\u_datapath/n182 ), .Y(
        \u_datapath/n245 ) );
  AOI22X1 \u_datapath/U224  ( .A(\u_datapath/N108 ), .B(n22), .C(
        \u_datapath/N96 ), .D(n1), .Y(\u_datapath/n181 ) );
  OAI21X1 \u_datapath/U223  ( .A(n54), .B(n15), .C(\u_datapath/n181 ), .Y(
        \u_datapath/n180 ) );
  NAND2X1 \u_datapath/U222  ( .A(\u_datapath/n176 ), .B(\u_datapath/n180 ), 
        .Y(\u_datapath/n179 ) );
  OAI21X1 \u_datapath/U221  ( .A(n21), .B(n19), .C(\u_datapath/n179 ), .Y(
        \u_datapath/n244 ) );
  AOI22X1 \u_datapath/U220  ( .A(\u_datapath/N109 ), .B(n22), .C(
        \u_datapath/N97 ), .D(n1), .Y(\u_datapath/n178 ) );
  OAI21X1 \u_datapath/U219  ( .A(n54), .B(n17), .C(\u_datapath/n178 ), .Y(
        \u_datapath/n177 ) );
  NAND2X1 \u_datapath/U218  ( .A(\u_datapath/n176 ), .B(\u_datapath/n177 ), 
        .Y(\u_datapath/n175 ) );
  OAI21X1 \u_datapath/U217  ( .A(n21), .B(n125), .C(\u_datapath/n175 ), .Y(
        \u_datapath/n243 ) );
  NAND2X1 \u_datapath/U216  ( .A(do_add_coin), .B(coin_valid), .Y(
        \u_datapath/n173 ) );
  NAND3X1 \u_datapath/U215  ( .A(rst_n), .B(n58), .C(\u_datapath/n173 ), .Y(
        \u_datapath/n165 ) );
  NAND3X1 \u_datapath/U214  ( .A(rst_n), .B(n58), .C(\u_datapath/n165 ), .Y(
        \u_datapath/n172 ) );
  NAND2X1 \u_datapath/U213  ( .A(\u_datapath/N30 ), .B(n35), .Y(
        \u_datapath/n171 ) );
  OAI21X1 \u_datapath/U212  ( .A(n118), .B(\u_datapath/n165 ), .C(
        \u_datapath/n171 ), .Y(\u_datapath/n242 ) );
  NAND2X1 \u_datapath/U211  ( .A(\u_datapath/N31 ), .B(n35), .Y(
        \u_datapath/n170 ) );
  OAI21X1 \u_datapath/U210  ( .A(n117), .B(\u_datapath/n165 ), .C(
        \u_datapath/n170 ), .Y(\u_datapath/n241 ) );
  NAND2X1 \u_datapath/U209  ( .A(\u_datapath/N32 ), .B(n35), .Y(
        \u_datapath/n169 ) );
  OAI21X1 \u_datapath/U208  ( .A(n116), .B(\u_datapath/n165 ), .C(
        \u_datapath/n169 ), .Y(\u_datapath/n240 ) );
  NAND2X1 \u_datapath/U207  ( .A(\u_datapath/N33 ), .B(n35), .Y(
        \u_datapath/n168 ) );
  OAI21X1 \u_datapath/U206  ( .A(n115), .B(\u_datapath/n165 ), .C(
        \u_datapath/n168 ), .Y(\u_datapath/n239 ) );
  NAND2X1 \u_datapath/U205  ( .A(\u_datapath/N34 ), .B(n35), .Y(
        \u_datapath/n167 ) );
  OAI21X1 \u_datapath/U204  ( .A(n114), .B(\u_datapath/n165 ), .C(
        \u_datapath/n167 ), .Y(\u_datapath/n238 ) );
  NAND2X1 \u_datapath/U203  ( .A(\u_datapath/N35 ), .B(n35), .Y(
        \u_datapath/n166 ) );
  OAI21X1 \u_datapath/U202  ( .A(n113), .B(\u_datapath/n165 ), .C(
        \u_datapath/n166 ), .Y(\u_datapath/n237 ) );
  OR2X1 \u_datapath/U201  ( .A(do_latch_sel), .B(n26), .Y(\u_datapath/n162 )
         );
  NAND3X1 \u_datapath/U200  ( .A(\u_datapath/n162 ), .B(rst_n), .C(sel_id[1]), 
        .Y(\u_datapath/n164 ) );
  OAI21X1 \u_datapath/U199  ( .A(n112), .B(\u_datapath/n162 ), .C(
        \u_datapath/n164 ), .Y(\u_datapath/n236 ) );
  NAND3X1 \u_datapath/U198  ( .A(\u_datapath/n162 ), .B(rst_n), .C(sel_id[0]), 
        .Y(\u_datapath/n163 ) );
  OAI21X1 \u_datapath/U197  ( .A(n108), .B(\u_datapath/n162 ), .C(
        \u_datapath/n163 ), .Y(\u_datapath/n235 ) );
  NOR2X1 \u_datapath/U196  ( .A(do_load_rem_from_bal), .B(do_compute_change), 
        .Y(\u_datapath/n161 ) );
  NAND3X1 \u_datapath/U195  ( .A(n4), .B(n58), .C(\u_datapath/n161 ), .Y(
        \u_datapath/n159 ) );
  NAND3X1 \u_datapath/U194  ( .A(rst_n), .B(n58), .C(\u_datapath/n159 ), .Y(
        \u_datapath/n157 ) );
  NOR2X1 \u_datapath/U193  ( .A(\u_datapath/n157 ), .B(n53), .Y(
        \u_datapath/n132 ) );
  AOI22X1 \u_datapath/U192  ( .A(n99), .B(n22), .C(\u_datapath/N86 ), .D(n1), 
        .Y(\u_datapath/n160 ) );
  OAI21X1 \u_datapath/U191  ( .A(n54), .B(\u_datapath/N86 ), .C(
        \u_datapath/n160 ), .Y(\u_datapath/n158 ) );
  AOI22X1 \u_datapath/U190  ( .A(\u_datapath/n132 ), .B(\u_datapath/n158 ), 
        .C(\u_datapath/N86 ), .D(n33), .Y(\u_datapath/n153 ) );
  NAND2X1 \u_datapath/U189  ( .A(chg_denom[1]), .B(chg_denom[0]), .Y(
        \u_datapath/n156 ) );
  AOI21X1 \u_datapath/U188  ( .A(\u_datapath/n156 ), .B(chg_sub_pulse), .C(
        \u_datapath/n157 ), .Y(\u_datapath/n155 ) );
  NOR2X1 \u_datapath/U187  ( .A(n34), .B(do_load_rem_from_bal), .Y(
        \u_datapath/n130 ) );
  AOI22X1 \u_datapath/U186  ( .A(\u_datapath/N50 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/N50 ), .D(\u_datapath/n131 ), .Y(\u_datapath/n154 ) );
  NAND2X1 \u_datapath/U185  ( .A(\u_datapath/n153 ), .B(\u_datapath/n154 ), 
        .Y(\u_datapath/n234 ) );
  AOI22X1 \u_datapath/U184  ( .A(\u_datapath/N99 ), .B(n22), .C(n97), .D(n1), 
        .Y(\u_datapath/n152 ) );
  OAI21X1 \u_datapath/U183  ( .A(n54), .B(n12), .C(\u_datapath/n152 ), .Y(
        \u_datapath/n151 ) );
  AOI22X1 \u_datapath/U182  ( .A(\u_datapath/n132 ), .B(\u_datapath/n151 ), 
        .C(\u_datapath/change_rem_out[1] ), .D(n33), .Y(\u_datapath/n149 ) );
  AOI22X1 \u_datapath/U181  ( .A(\u_datapath/N51 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/balance_out[1] ), .D(\u_datapath/n131 ), .Y(
        \u_datapath/n150 ) );
  NAND2X1 \u_datapath/U180  ( .A(\u_datapath/n149 ), .B(\u_datapath/n150 ), 
        .Y(\u_datapath/n233 ) );
  AOI22X1 \u_datapath/U179  ( .A(n91), .B(n22), .C(\u_datapath/N88 ), .D(n1), 
        .Y(\u_datapath/n148 ) );
  OAI21X1 \u_datapath/U178  ( .A(n54), .B(n13), .C(\u_datapath/n148 ), .Y(
        \u_datapath/n147 ) );
  AOI22X1 \u_datapath/U177  ( .A(\u_datapath/n132 ), .B(\u_datapath/n147 ), 
        .C(\u_datapath/change_rem_out[2] ), .D(n33), .Y(\u_datapath/n145 ) );
  AOI22X1 \u_datapath/U176  ( .A(\u_datapath/N52 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/balance_out[2] ), .D(\u_datapath/n131 ), .Y(
        \u_datapath/n146 ) );
  NAND2X1 \u_datapath/U175  ( .A(\u_datapath/n145 ), .B(\u_datapath/n146 ), 
        .Y(\u_datapath/n232 ) );
  AOI22X1 \u_datapath/U174  ( .A(\u_datapath/N101 ), .B(n22), .C(
        \u_datapath/N89 ), .D(n1), .Y(\u_datapath/n144 ) );
  OAI21X1 \u_datapath/U173  ( .A(n54), .B(n14), .C(\u_datapath/n144 ), .Y(
        \u_datapath/n143 ) );
  AOI22X1 \u_datapath/U172  ( .A(\u_datapath/n132 ), .B(\u_datapath/n143 ), 
        .C(\u_datapath/change_rem_out[3] ), .D(n33), .Y(\u_datapath/n141 ) );
  AOI22X1 \u_datapath/U171  ( .A(\u_datapath/N53 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/balance_out[3] ), .D(\u_datapath/n131 ), .Y(
        \u_datapath/n142 ) );
  NAND2X1 \u_datapath/U170  ( .A(\u_datapath/n141 ), .B(\u_datapath/n142 ), 
        .Y(\u_datapath/n231 ) );
  AOI22X1 \u_datapath/U169  ( .A(\u_datapath/N102 ), .B(n22), .C(
        \u_datapath/N90 ), .D(n1), .Y(\u_datapath/n140 ) );
  OAI21X1 \u_datapath/U168  ( .A(n54), .B(n11), .C(\u_datapath/n140 ), .Y(
        \u_datapath/n139 ) );
  AOI22X1 \u_datapath/U167  ( .A(\u_datapath/n132 ), .B(\u_datapath/n139 ), 
        .C(\u_datapath/change_rem_out[4] ), .D(n33), .Y(\u_datapath/n137 ) );
  AOI22X1 \u_datapath/U166  ( .A(\u_datapath/N54 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/balance_out[4] ), .D(\u_datapath/n131 ), .Y(
        \u_datapath/n138 ) );
  NAND2X1 \u_datapath/U165  ( .A(\u_datapath/n137 ), .B(\u_datapath/n138 ), 
        .Y(\u_datapath/n230 ) );
  AOI22X1 \u_datapath/U164  ( .A(\u_datapath/N103 ), .B(n22), .C(
        \u_datapath/N91 ), .D(n1), .Y(\u_datapath/n134 ) );
  OAI21X1 \u_datapath/U163  ( .A(n54), .B(n16), .C(\u_datapath/n134 ), .Y(
        \u_datapath/n133 ) );
  AOI22X1 \u_datapath/U162  ( .A(\u_datapath/n132 ), .B(\u_datapath/n133 ), 
        .C(\u_datapath/change_rem_out[5] ), .D(n33), .Y(\u_datapath/n128 ) );
  AOI22X1 \u_datapath/U161  ( .A(\u_datapath/N55 ), .B(\u_datapath/n130 ), .C(
        \u_datapath/balance_out[5] ), .D(\u_datapath/n131 ), .Y(
        \u_datapath/n129 ) );
  NAND2X1 \u_datapath/U160  ( .A(\u_datapath/n128 ), .B(\u_datapath/n129 ), 
        .Y(\u_datapath/n229 ) );
  OAI21X1 \u_datapath/U159  ( .A(\u_datapath/n118 ), .B(\u_datapath/n119 ), 
        .C(\u_datapath/n127 ), .Y(\u_datapath/n126 ) );
  NAND2X1 \u_datapath/U158  ( .A(do_dec_inv), .B(n75), .Y(\u_datapath/n125 )
         );
  OAI21X1 \u_datapath/U157  ( .A(n111), .B(\u_datapath/n125 ), .C(n23), .Y(
        \u_datapath/n116 ) );
  OAI22X1 \u_datapath/U156  ( .A(\u_datapath/n111 ), .B(n36), .C(n74), .D(
        \u_datapath/n116 ), .Y(\u_datapath/n228 ) );
  OAI21X1 \u_datapath/U155  ( .A(n106), .B(\u_datapath/n125 ), .C(n23), .Y(
        \u_datapath/n114 ) );
  NAND2X1 \u_datapath/U154  ( .A(\u_datapath/n122 ), .B(rst_n), .Y(
        \u_datapath/n124 ) );
  OAI22X1 \u_datapath/U153  ( .A(n86), .B(\u_datapath/n114 ), .C(n37), .D(
        \u_datapath/n124 ), .Y(\u_datapath/n227 ) );
  OAI22X1 \u_datapath/U152  ( .A(n89), .B(\u_datapath/n116 ), .C(n36), .D(
        \u_datapath/n124 ), .Y(\u_datapath/n226 ) );
  OAI21X1 \u_datapath/U151  ( .A(n107), .B(\u_datapath/n125 ), .C(n23), .Y(
        \u_datapath/n113 ) );
  OAI22X1 \u_datapath/U150  ( .A(n87), .B(\u_datapath/n113 ), .C(n38), .D(
        \u_datapath/n124 ), .Y(\u_datapath/n225 ) );
  OAI21X1 \u_datapath/U149  ( .A(n110), .B(\u_datapath/n125 ), .C(n23), .Y(
        \u_datapath/n112 ) );
  OAI22X1 \u_datapath/U148  ( .A(n88), .B(\u_datapath/n112 ), .C(n39), .D(
        \u_datapath/n124 ), .Y(\u_datapath/n224 ) );
  OAI21X1 \u_datapath/U147  ( .A(\u_datapath/n122 ), .B(\u_datapath/n123 ), 
        .C(\u_datapath/n118 ), .Y(\u_datapath/n121 ) );
  NAND2X1 \u_datapath/U146  ( .A(\u_datapath/n121 ), .B(rst_n), .Y(
        \u_datapath/n120 ) );
  OAI22X1 \u_datapath/U145  ( .A(n82), .B(\u_datapath/n114 ), .C(n37), .D(
        \u_datapath/n120 ), .Y(\u_datapath/n223 ) );
  OAI22X1 \u_datapath/U144  ( .A(n85), .B(\u_datapath/n116 ), .C(n36), .D(
        \u_datapath/n120 ), .Y(\u_datapath/n222 ) );
  OAI22X1 \u_datapath/U143  ( .A(n83), .B(\u_datapath/n113 ), .C(n38), .D(
        \u_datapath/n120 ), .Y(\u_datapath/n221 ) );
  OAI22X1 \u_datapath/U142  ( .A(n84), .B(\u_datapath/n112 ), .C(n39), .D(
        \u_datapath/n120 ), .Y(\u_datapath/n220 ) );
  XNOR2X1 \u_datapath/U141  ( .A(\u_datapath/n118 ), .B(\u_datapath/n119 ), 
        .Y(\u_datapath/n117 ) );
  NAND2X1 \u_datapath/U140  ( .A(\u_datapath/n117 ), .B(rst_n), .Y(
        \u_datapath/n115 ) );
  OAI22X1 \u_datapath/U139  ( .A(n37), .B(\u_datapath/n115 ), .C(n78), .D(
        \u_datapath/n114 ), .Y(\u_datapath/n219 ) );
  OAI22X1 \u_datapath/U138  ( .A(n36), .B(\u_datapath/n115 ), .C(n81), .D(
        \u_datapath/n116 ), .Y(\u_datapath/n218 ) );
  OAI22X1 \u_datapath/U137  ( .A(n38), .B(\u_datapath/n115 ), .C(n79), .D(
        \u_datapath/n113 ), .Y(\u_datapath/n217 ) );
  OAI22X1 \u_datapath/U136  ( .A(n39), .B(\u_datapath/n115 ), .C(n80), .D(
        \u_datapath/n112 ), .Y(\u_datapath/n216 ) );
  OAI22X1 \u_datapath/U135  ( .A(\u_datapath/n111 ), .B(n37), .C(n76), .D(
        \u_datapath/n114 ), .Y(\u_datapath/n215 ) );
  OAI22X1 \u_datapath/U134  ( .A(\u_datapath/n111 ), .B(n38), .C(n90), .D(
        \u_datapath/n113 ), .Y(\u_datapath/n214 ) );
  OAI22X1 \u_datapath/U133  ( .A(\u_datapath/n111 ), .B(n39), .C(n77), .D(
        \u_datapath/n112 ), .Y(\u_datapath/n213 ) );
  NAND2X1 \u_datapath/U127  ( .A(n110), .B(n111), .Y(\u_datapath/price_sel[1] ) );
  AND2X2 \u_datapath/U48  ( .A(\u_datapath/n207 ), .B(\u_datapath/n208 ), .Y(
        can10) );
  AND2X2 \u_datapath/U47  ( .A(\u_datapath/N25 ), .B(\u_datapath/N24 ), .Y(
        can25) );
  AND2X2 \u_datapath/U46  ( .A(n49), .B(coin_type[1]), .Y(
        \u_datapath/coin_value [2]) );
  AND2X2 \u_datapath/U45  ( .A(\u_datapath/n201 ), .B(\u_datapath/n202 ), .Y(
        \u_datapath/n122 ) );
  AND2X2 \u_datapath/U44  ( .A(\u_datapath/n199 ), .B(\u_datapath/n200 ), .Y(
        \u_datapath/n123 ) );
  AND2X2 \u_datapath/U42  ( .A(do_load_rem_from_bal), .B(\u_datapath/n155 ), 
        .Y(\u_datapath/n131 ) );
  AND2X2 \u_datapath/U41  ( .A(\u_datapath/n126 ), .B(n23), .Y(
        \u_datapath/n111 ) );
  DFFNEGX1 \u_datapath/inv_reg[0][3]  ( .D(\u_datapath/n228 ), .CLK(n29), .Q(
        \u_datapath/inv[0][3] ) );
  DFFNEGX1 \u_datapath/inv_reg[3][3]  ( .D(\u_datapath/n215 ), .CLK(n28), .Q(
        \u_datapath/inv[3][3] ) );
  DFFNEGX1 \u_datapath/inv_reg[2][3]  ( .D(\u_datapath/n213 ), .CLK(n28), .Q(
        \u_datapath/inv[2][3] ) );
  DFFNEGX1 \u_datapath/inv_reg[3][2]  ( .D(\u_datapath/n219 ), .CLK(clkb), .Q(
        \u_datapath/inv[3][2] ) );
  DFFNEGX1 \u_datapath/inv_reg[1][2]  ( .D(\u_datapath/n217 ), .CLK(clkb), .Q(
        \u_datapath/inv[1][2] ) );
  DFFNEGX1 \u_datapath/inv_reg[2][2]  ( .D(\u_datapath/n216 ), .CLK(clkb), .Q(
        \u_datapath/inv[2][2] ) );
  DFFNEGX1 \u_datapath/inv_reg[0][2]  ( .D(\u_datapath/n218 ), .CLK(clkb), .Q(
        \u_datapath/inv[0][2] ) );
  DFFNEGX1 \u_datapath/inv_reg[3][1]  ( .D(\u_datapath/n223 ), .CLK(clkb), .Q(
        \u_datapath/inv[3][1] ) );
  DFFNEGX1 \u_datapath/inv_reg[1][1]  ( .D(\u_datapath/n221 ), .CLK(clkb), .Q(
        \u_datapath/inv[1][1] ) );
  DFFNEGX1 \u_datapath/inv_reg[2][1]  ( .D(\u_datapath/n220 ), .CLK(clkb), .Q(
        \u_datapath/inv[2][1] ) );
  DFFNEGX1 \u_datapath/inv_reg[0][1]  ( .D(\u_datapath/n222 ), .CLK(n29), .Q(
        \u_datapath/inv[0][1] ) );
  DFFNEGX1 \u_datapath/inv_reg[3][0]  ( .D(\u_datapath/n227 ), .CLK(n29), .Q(
        \u_datapath/inv[3][0] ) );
  DFFNEGX1 \u_datapath/inv_reg[1][0]  ( .D(\u_datapath/n225 ), .CLK(n29), .Q(
        \u_datapath/inv[1][0] ) );
  DFFNEGX1 \u_datapath/inv_reg[2][0]  ( .D(\u_datapath/n224 ), .CLK(n29), .Q(
        \u_datapath/inv[2][0] ) );
  DFFNEGX1 \u_datapath/inv_reg[0][0]  ( .D(\u_datapath/n226 ), .CLK(n29), .Q(
        \u_datapath/inv[0][0] ) );
  DFFNEGX1 \u_datapath/inv_reg[1][3]  ( .D(\u_datapath/n214 ), .CLK(n29), .Q(
        \u_datapath/inv[1][3] ) );
  DFFNEGX1 \u_datapath/change_rem_reg[2]  ( .D(\u_datapath/n232 ), .CLK(n29), 
        .Q(\u_datapath/change_rem_out[2] ) );
  DFFNEGX1 \u_datapath/change_rem_reg[1]  ( .D(\u_datapath/n233 ), .CLK(n29), 
        .Q(\u_datapath/change_rem_out[1] ) );
  DFFNEGX1 \u_datapath/change_rem_reg[0]  ( .D(\u_datapath/n234 ), .CLK(n29), 
        .Q(\u_datapath/N86 ) );
  DFFNEGX1 \u_datapath/change_rem_reg[3]  ( .D(\u_datapath/n231 ), .CLK(n29), 
        .Q(\u_datapath/change_rem_out[3] ) );
  DFFNEGX1 \u_datapath/change_rem_reg[4]  ( .D(\u_datapath/n230 ), .CLK(n29), 
        .Q(\u_datapath/change_rem_out[4] ) );
  DFFNEGX1 \u_datapath/change_rem_reg[5]  ( .D(\u_datapath/n229 ), .CLK(n29), 
        .Q(\u_datapath/change_rem_out[5] ) );
  DFFNEGX1 \u_datapath/sel_reg_reg[0]  ( .D(\u_datapath/n235 ), .CLK(n29), .Q(
        sel_reg_out[0]) );
  DFFNEGX1 \u_datapath/sel_reg_reg[1]  ( .D(\u_datapath/n236 ), .CLK(n28), .Q(
        sel_reg_out[1]) );
  DFFNEGX1 \u_datapath/balance_reg[5]  ( .D(\u_datapath/n237 ), .CLK(n28), .Q(
        \u_datapath/balance_out[5] ) );
  DFFNEGX1 \u_datapath/balance_reg[4]  ( .D(\u_datapath/n238 ), .CLK(n28), .Q(
        \u_datapath/balance_out[4] ) );
  DFFNEGX1 \u_datapath/balance_reg[3]  ( .D(\u_datapath/n239 ), .CLK(n28), .Q(
        \u_datapath/balance_out[3] ) );
  DFFNEGX1 \u_datapath/balance_reg[2]  ( .D(\u_datapath/n240 ), .CLK(n28), .Q(
        \u_datapath/balance_out[2] ) );
  DFFNEGX1 \u_datapath/balance_reg[1]  ( .D(\u_datapath/n241 ), .CLK(n28), .Q(
        \u_datapath/balance_out[1] ) );
  DFFNEGX1 \u_datapath/balance_reg[0]  ( .D(\u_datapath/n242 ), .CLK(n28), .Q(
        \u_datapath/N50 ) );
  DFFNEGX1 \u_datapath/change_bank_reg[3]  ( .D(\u_datapath/n245 ), .CLK(n28), 
        .Q(\u_datapath/change_bank [3]) );
  DFFNEGX1 \u_datapath/change_bank_reg[2]  ( .D(\u_datapath/n246 ), .CLK(n28), 
        .Q(\u_datapath/change_bank [2]) );
  DFFNEGX1 \u_datapath/change_bank_reg[1]  ( .D(\u_datapath/n247 ), .CLK(n28), 
        .Q(\u_datapath/change_bank [1]) );
  DFFNEGX1 \u_datapath/change_bank_reg[4]  ( .D(\u_datapath/n244 ), .CLK(n28), 
        .Q(\u_datapath/change_bank [4]) );
  DFFNEGX1 \u_datapath/change_bank_reg[5]  ( .D(\u_datapath/n243 ), .CLK(n28), 
        .Q(\u_datapath/change_bank [5]) );
  DFFNEGX1 \u_datapath/change_bank_reg[0]  ( .D(\u_datapath/n248 ), .CLK(n28), 
        .Q(\u_datapath/N92 ) );
  FAX1 \u_datapath/add_94/U1_1  ( .A(\u_datapath/balance_out[1] ), .B(
        \u_datapath/coin_value [1]), .C(n9), .YC(\u_datapath/add_94/carry [2]), 
        .YS(\u_datapath/N31 ) );
  FAX1 \u_datapath/add_94/U1_2  ( .A(\u_datapath/balance_out[2] ), .B(
        \u_datapath/coin_value [2]), .C(\u_datapath/add_94/carry [2]), .YC(
        \u_datapath/add_94/carry [3]), .YS(\u_datapath/N32 ) );
  FAX1 \u_datapath/sub_103/U2_2  ( .A(\u_datapath/balance_out[2] ), .B(n2), 
        .C(\u_datapath/sub_103/carry [2]), .YC(\u_datapath/sub_103/carry [3]), 
        .YS(\u_datapath/N52 ) );
  FAX1 \u_datapath/sub_103/U2_3  ( .A(\u_datapath/balance_out[3] ), .B(n5), 
        .C(\u_datapath/sub_103/carry [3]), .YC(\u_datapath/sub_103/carry [4]), 
        .YS(\u_datapath/N53 ) );
  AND2X2 U1 ( .A(chg_denom[0]), .B(n57), .Y(n1) );
  AND2X2 U2 ( .A(n106), .B(n111), .Y(n2) );
  OR2X2 U3 ( .A(chg_denom[0]), .B(chg_denom[1]), .Y(n3) );
  AND2X2 U4 ( .A(\u_datapath/n195 ), .B(n23), .Y(n4) );
  AND2X2 U5 ( .A(\u_datapath/n103 ), .B(n107), .Y(n5) );
  AND2X2 U6 ( .A(\u_datapath/sub_111/carry[2] ), .B(
        \u_datapath/change_rem_out[2] ), .Y(n6) );
  AND2X2 U7 ( .A(\u_datapath/add_94/carry [3]), .B(\u_datapath/balance_out[3] ), .Y(n7) );
  AND2X2 U8 ( .A(\u_datapath/sub_112/carry[2] ), .B(
        \u_datapath/change_bank [2]), .Y(n8) );
  AND2X2 U9 ( .A(n49), .B(\u_datapath/N50 ), .Y(n9) );
  AND2X2 U10 ( .A(n7), .B(\u_datapath/balance_out[4] ), .Y(n10) );
  XOR2X1 U11 ( .A(\u_datapath/sub_111/carry[4] ), .B(
        \u_datapath/change_rem_out[4] ), .Y(n11) );
  XOR2X1 U12 ( .A(\u_datapath/N86 ), .B(\u_datapath/change_rem_out[1] ), .Y(
        n12) );
  XNOR2X1 U13 ( .A(\u_datapath/sub_111/carry[2] ), .B(
        \u_datapath/change_rem_out[2] ), .Y(n13) );
  XOR2X1 U14 ( .A(n6), .B(\u_datapath/change_rem_out[3] ), .Y(n14) );
  XOR2X1 U15 ( .A(\u_datapath/sub_112/carry[4] ), .B(
        \u_datapath/change_bank [4]), .Y(n15) );
  XOR2X1 U16 ( .A(\u_datapath/change_rem_out[5] ), .B(
        \u_datapath/sub_111/carry[5] ), .Y(n16) );
  XOR2X1 U17 ( .A(\u_datapath/change_bank [5]), .B(
        \u_datapath/sub_112/carry[5] ), .Y(n17) );
  XNOR2X1 U18 ( .A(\u_datapath/sub_112/carry[2] ), .B(
        \u_datapath/change_bank [2]), .Y(n18) );
  INVX2 U19 ( .A(n24), .Y(n23) );
  BUFX2 U20 ( .A(n27), .Y(n25) );
  BUFX2 U21 ( .A(n27), .Y(n24) );
  BUFX2 U22 ( .A(n27), .Y(n26) );
  INVX2 U23 ( .A(\u_datapath/n185 ), .Y(n54) );
  INVX2 U24 ( .A(n30), .Y(n28) );
  INVX2 U25 ( .A(n30), .Y(n29) );
  INVX2 U26 ( .A(rst_n), .Y(n27) );
  INVX2 U27 ( .A(clkb), .Y(n30) );
  INVX2 U28 ( .A(n3), .Y(n22) );
  INVX2 U29 ( .A(\u_datapath/change_bank [4]), .Y(n19) );
  INVX2 U30 ( .A(\u_datapath/change_bank [2]), .Y(n20) );
  INVX2 U31 ( .A(n4), .Y(n21) );
  OR2X1 U32 ( .A(\u_datapath/balance_out[4] ), .B(
        \u_datapath/sub_103/carry [4]), .Y(\u_datapath/sub_103/carry [5]) );
  XNOR2X1 U33 ( .A(\u_datapath/sub_103/carry [4]), .B(
        \u_datapath/balance_out[4] ), .Y(\u_datapath/N54 ) );
  XNOR2X1 U34 ( .A(\u_datapath/balance_out[5] ), .B(
        \u_datapath/sub_103/carry [5]), .Y(\u_datapath/N55 ) );
  OR2X1 U35 ( .A(\u_datapath/balance_out[1] ), .B(n109), .Y(
        \u_datapath/sub_103/carry [2]) );
  XNOR2X1 U36 ( .A(n109), .B(\u_datapath/balance_out[1] ), .Y(\u_datapath/N51 ) );
  OR2X1 U37 ( .A(\u_datapath/change_rem_out[1] ), .B(\u_datapath/N86 ), .Y(
        \u_datapath/sub_111/carry[2] ) );
  OR2X1 U38 ( .A(\u_datapath/change_rem_out[3] ), .B(n6), .Y(
        \u_datapath/sub_111/carry[4] ) );
  OR2X1 U39 ( .A(\u_datapath/change_rem_out[4] ), .B(
        \u_datapath/sub_111/carry[4] ), .Y(\u_datapath/sub_111/carry[5] ) );
  OR2X1 U40 ( .A(\u_datapath/change_bank [1]), .B(\u_datapath/N92 ), .Y(
        \u_datapath/sub_112/carry[2] ) );
  XNOR2X1 U41 ( .A(\u_datapath/N92 ), .B(\u_datapath/change_bank [1]), .Y(
        \u_datapath/N81 ) );
  OR2X1 U42 ( .A(\u_datapath/change_bank [3]), .B(n8), .Y(
        \u_datapath/sub_112/carry[4] ) );
  XNOR2X1 U43 ( .A(n8), .B(\u_datapath/change_bank [3]), .Y(\u_datapath/N83 )
         );
  OR2X1 U44 ( .A(\u_datapath/change_bank [4]), .B(
        \u_datapath/sub_112/carry[4] ), .Y(\u_datapath/sub_112/carry[5] ) );
  OR2X1 U45 ( .A(\u_datapath/change_rem_out[2] ), .B(
        \u_datapath/change_rem_out[1] ), .Y(\u_datapath/sub_115/carry [3]) );
  XNOR2X1 U46 ( .A(\u_datapath/change_rem_out[1] ), .B(
        \u_datapath/change_rem_out[2] ), .Y(\u_datapath/N88 ) );
  OR2X1 U47 ( .A(\u_datapath/change_rem_out[3] ), .B(
        \u_datapath/sub_115/carry [3]), .Y(\u_datapath/sub_115/carry [4]) );
  XNOR2X1 U48 ( .A(\u_datapath/sub_115/carry [3]), .B(
        \u_datapath/change_rem_out[3] ), .Y(\u_datapath/N89 ) );
  OR2X1 U49 ( .A(\u_datapath/change_rem_out[4] ), .B(
        \u_datapath/sub_115/carry [4]), .Y(\u_datapath/sub_115/carry [5]) );
  XNOR2X1 U50 ( .A(\u_datapath/sub_115/carry [4]), .B(
        \u_datapath/change_rem_out[4] ), .Y(\u_datapath/N90 ) );
  XNOR2X1 U51 ( .A(\u_datapath/change_rem_out[5] ), .B(
        \u_datapath/sub_115/carry [5]), .Y(\u_datapath/N91 ) );
  OR2X1 U52 ( .A(\u_datapath/change_bank [2]), .B(\u_datapath/change_bank [1]), 
        .Y(\u_datapath/sub_116/carry [3]) );
  XNOR2X1 U53 ( .A(\u_datapath/change_bank [1]), .B(
        \u_datapath/change_bank [2]), .Y(\u_datapath/N94 ) );
  OR2X1 U54 ( .A(\u_datapath/change_bank [3]), .B(
        \u_datapath/sub_116/carry [3]), .Y(\u_datapath/sub_116/carry [4]) );
  XNOR2X1 U55 ( .A(\u_datapath/sub_116/carry [3]), .B(
        \u_datapath/change_bank [3]), .Y(\u_datapath/N95 ) );
  OR2X1 U56 ( .A(\u_datapath/change_bank [4]), .B(
        \u_datapath/sub_116/carry [4]), .Y(\u_datapath/sub_116/carry [5]) );
  XNOR2X1 U57 ( .A(\u_datapath/sub_116/carry [4]), .B(
        \u_datapath/change_bank [4]), .Y(\u_datapath/N96 ) );
  XNOR2X1 U58 ( .A(\u_datapath/change_bank [5]), .B(
        \u_datapath/sub_116/carry [5]), .Y(\u_datapath/N97 ) );
  XOR2X1 U59 ( .A(n49), .B(\u_datapath/N50 ), .Y(\u_datapath/N30 ) );
  XOR2X1 U60 ( .A(\u_datapath/add_94/carry [3]), .B(
        \u_datapath/balance_out[3] ), .Y(\u_datapath/N33 ) );
  XOR2X1 U61 ( .A(n7), .B(\u_datapath/balance_out[4] ), .Y(\u_datapath/N34 )
         );
  XOR2X1 U62 ( .A(\u_datapath/balance_out[5] ), .B(n10), .Y(\u_datapath/N35 )
         );
  INVX2 U63 ( .A(\u_fsm/N200 ), .Y(n31) );
  INVX2 U64 ( .A(\u_fsm/N203 ), .Y(n32) );
  INVX2 U65 ( .A(\u_datapath/n159 ), .Y(n33) );
  INVX2 U66 ( .A(\u_datapath/n155 ), .Y(n34) );
  INVX2 U67 ( .A(\u_datapath/n172 ), .Y(n35) );
  INVX2 U68 ( .A(\u_datapath/n116 ), .Y(n36) );
  INVX2 U69 ( .A(\u_datapath/n114 ), .Y(n37) );
  INVX2 U70 ( .A(\u_datapath/n113 ), .Y(n38) );
  INVX2 U71 ( .A(\u_datapath/n112 ), .Y(n39) );
  INVX2 U72 ( .A(\u_fsm/n92 ), .Y(n40) );
  INVX2 U73 ( .A(\u_fsm/n91 ), .Y(n41) );
  INVX2 U74 ( .A(\u_fsm/n84 ), .Y(n42) );
  INVX2 U75 ( .A(\u_fsm/n52 ), .Y(n43) );
  INVX2 U76 ( .A(\u_fsm/n43 ), .Y(n44) );
  INVX2 U77 ( .A(\u_fsm/n34 ), .Y(n45) );
  INVX2 U78 ( .A(\u_fsm/n55 ), .Y(n46) );
  INVX2 U79 ( .A(coin_valid), .Y(n47) );
  INVX2 U80 ( .A(\u_fsm/n37 ), .Y(n48) );
  INVX2 U81 ( .A(coin_type[0]), .Y(n49) );
  INVX2 U82 ( .A(sel_valid), .Y(n50) );
  INVX2 U83 ( .A(\u_fsm/n42 ), .Y(n51) );
  INVX2 U84 ( .A(cancel), .Y(n52) );
  INVX2 U85 ( .A(chg_sub_pulse), .Y(n53) );
  INVX2 U86 ( .A(\u_datapath/n191 ), .Y(n55) );
  INVX2 U87 ( .A(\u_datapath/n184 ), .Y(n56) );
  INVX2 U88 ( .A(chg_denom[1]), .Y(n57) );
  INVX2 U89 ( .A(do_clear_balance), .Y(n58) );
  INVX2 U90 ( .A(\u_fsm/n58 ), .Y(n59) );
  INVX2 U91 ( .A(\u_fsm/n85 ), .Y(n60) );
  INVX2 U92 ( .A(\u_fsm/n50 ), .Y(n61) );
  INVX2 U93 ( .A(\u_fsm/n89 ), .Y(n62) );
  INVX2 U94 ( .A(\u_fsm/state [1]), .Y(n63) );
  INVX2 U95 ( .A(\u_fsm/n51 ), .Y(n64) );
  INVX2 U96 ( .A(\u_fsm/state [0]), .Y(n65) );
  INVX2 U97 ( .A(\u_fsm/n67 ), .Y(n66) );
  INVX2 U98 ( .A(\u_fsm/n66 ), .Y(n67) );
  INVX2 U99 ( .A(\u_fsm/cstate [2]), .Y(n68) );
  INVX2 U100 ( .A(\u_fsm/n72 ), .Y(n69) );
  INVX2 U101 ( .A(\u_fsm/n80 ), .Y(n70) );
  INVX2 U102 ( .A(\u_fsm/n83 ), .Y(n71) );
  INVX2 U103 ( .A(\u_fsm/cstate [1]), .Y(n72) );
  INVX2 U104 ( .A(\u_fsm/cstate [0]), .Y(n73) );
  INVX2 U105 ( .A(\u_datapath/inv[0][3] ), .Y(n74) );
  INVX2 U106 ( .A(soldout), .Y(n75) );
  INVX2 U107 ( .A(\u_datapath/inv[3][3] ), .Y(n76) );
  INVX2 U108 ( .A(\u_datapath/inv[2][3] ), .Y(n77) );
  INVX2 U109 ( .A(\u_datapath/inv[3][2] ), .Y(n78) );
  INVX2 U110 ( .A(\u_datapath/inv[1][2] ), .Y(n79) );
  INVX2 U111 ( .A(\u_datapath/inv[2][2] ), .Y(n80) );
  INVX2 U112 ( .A(\u_datapath/inv[0][2] ), .Y(n81) );
  INVX2 U113 ( .A(\u_datapath/inv[3][1] ), .Y(n82) );
  INVX2 U114 ( .A(\u_datapath/inv[1][1] ), .Y(n83) );
  INVX2 U115 ( .A(\u_datapath/inv[2][1] ), .Y(n84) );
  INVX2 U116 ( .A(\u_datapath/inv[0][1] ), .Y(n85) );
  INVX2 U117 ( .A(\u_datapath/inv[3][0] ), .Y(n86) );
  INVX2 U118 ( .A(\u_datapath/inv[1][0] ), .Y(n87) );
  INVX2 U119 ( .A(\u_datapath/inv[2][0] ), .Y(n88) );
  INVX2 U120 ( .A(\u_datapath/inv[0][0] ), .Y(n89) );
  INVX2 U121 ( .A(\u_datapath/inv[1][3] ), .Y(n90) );
  INVX2 U122 ( .A(n133), .Y(n91) );
  INVX2 U123 ( .A(bank_enough), .Y(n92) );
  INVX2 U124 ( .A(n147), .Y(n93) );
  INVX2 U125 ( .A(\u_datapath/change_rem_out[2] ), .Y(n94) );
  INVX2 U126 ( .A(rem_zero), .Y(n95) );
  INVX2 U127 ( .A(can5), .Y(n96) );
  INVX2 U128 ( .A(\u_datapath/change_rem_out[1] ), .Y(n97) );
  INVX2 U129 ( .A(n142), .Y(n98) );
  INVX2 U130 ( .A(\u_datapath/N86 ), .Y(n99) );
  INVX2 U131 ( .A(n143), .Y(n100) );
  INVX2 U132 ( .A(\u_datapath/change_rem_out[3] ), .Y(n101) );
  INVX2 U133 ( .A(\u_datapath/change_rem_out[4] ), .Y(n102) );
  INVX2 U134 ( .A(n151), .Y(n103) );
  INVX2 U135 ( .A(\u_datapath/change_rem_out[5] ), .Y(n104) );
  INVX2 U136 ( .A(n152), .Y(n105) );
  INVX2 U137 ( .A(\u_datapath/n100 ), .Y(n106) );
  INVX2 U138 ( .A(\u_datapath/n98 ), .Y(n107) );
  INVX2 U139 ( .A(sel_reg_out[0]), .Y(n108) );
  INVX2 U140 ( .A(\u_datapath/price_sel[1] ), .Y(n109) );
  INVX2 U141 ( .A(\u_datapath/n99 ), .Y(n110) );
  INVX2 U142 ( .A(\u_datapath/n97 ), .Y(n111) );
  INVX2 U143 ( .A(sel_reg_out[1]), .Y(n112) );
  INVX2 U144 ( .A(\u_datapath/balance_out[5] ), .Y(n113) );
  INVX2 U145 ( .A(\u_datapath/balance_out[4] ), .Y(n114) );
  INVX2 U146 ( .A(\u_datapath/balance_out[3] ), .Y(n115) );
  INVX2 U147 ( .A(\u_datapath/balance_out[2] ), .Y(n116) );
  INVX2 U148 ( .A(\u_datapath/balance_out[1] ), .Y(n117) );
  INVX2 U149 ( .A(\u_datapath/N50 ), .Y(n118) );
  INVX2 U150 ( .A(\u_datapath/N107 ), .Y(n119) );
  INVX2 U151 ( .A(\u_datapath/n208 ), .Y(n120) );
  INVX2 U152 ( .A(\u_datapath/change_bank [3]), .Y(n121) );
  INVX2 U153 ( .A(n128), .Y(n122) );
  INVX2 U154 ( .A(\u_datapath/N105 ), .Y(n123) );
  INVX2 U155 ( .A(\u_datapath/change_bank [1]), .Y(n124) );
  INVX2 U156 ( .A(\u_datapath/change_bank [5]), .Y(n125) );
  INVX2 U157 ( .A(\u_datapath/N92 ), .Y(n126) );
  NAND2X1 U158 ( .A(n124), .B(n126), .Y(n127) );
  OAI21X1 U159 ( .A(n126), .B(n124), .C(n127), .Y(\u_datapath/N105 ) );
  NOR2X1 U160 ( .A(n127), .B(\u_datapath/change_bank [2]), .Y(n129) );
  AOI21X1 U161 ( .A(n127), .B(\u_datapath/change_bank [2]), .C(n129), .Y(n128)
         );
  NAND2X1 U162 ( .A(n129), .B(n121), .Y(n130) );
  OAI21X1 U163 ( .A(n129), .B(n121), .C(n130), .Y(\u_datapath/N107 ) );
  XNOR2X1 U164 ( .A(\u_datapath/change_bank [4]), .B(n130), .Y(
        \u_datapath/N108 ) );
  NOR2X1 U165 ( .A(\u_datapath/change_bank [4]), .B(n130), .Y(n131) );
  XOR2X1 U166 ( .A(\u_datapath/change_bank [5]), .B(n131), .Y(
        \u_datapath/N109 ) );
  NAND2X1 U167 ( .A(n97), .B(n99), .Y(n132) );
  OAI21X1 U168 ( .A(n99), .B(n97), .C(n132), .Y(\u_datapath/N99 ) );
  NOR2X1 U169 ( .A(n132), .B(\u_datapath/change_rem_out[2] ), .Y(n134) );
  AOI21X1 U170 ( .A(n132), .B(\u_datapath/change_rem_out[2] ), .C(n134), .Y(
        n133) );
  NAND2X1 U171 ( .A(n134), .B(n101), .Y(n135) );
  OAI21X1 U172 ( .A(n134), .B(n101), .C(n135), .Y(\u_datapath/N101 ) );
  XNOR2X1 U173 ( .A(\u_datapath/change_rem_out[4] ), .B(n135), .Y(
        \u_datapath/N102 ) );
  NOR2X1 U174 ( .A(\u_datapath/change_rem_out[4] ), .B(n135), .Y(n136) );
  XOR2X1 U175 ( .A(\u_datapath/change_rem_out[5] ), .B(n136), .Y(
        \u_datapath/N103 ) );
  OAI21X1 U176 ( .A(\u_datapath/N92 ), .B(\u_datapath/change_bank [1]), .C(
        \u_datapath/change_bank [2]), .Y(n138) );
  NOR2X1 U177 ( .A(\u_datapath/change_bank [5]), .B(
        \u_datapath/change_bank [4]), .Y(n137) );
  NAND3X1 U178 ( .A(n138), .B(n121), .C(n137), .Y(\u_datapath/N25 ) );
  OAI21X1 U179 ( .A(\u_datapath/N86 ), .B(\u_datapath/change_rem_out[1] ), .C(
        \u_datapath/change_rem_out[2] ), .Y(n140) );
  NOR2X1 U180 ( .A(\u_datapath/change_rem_out[5] ), .B(
        \u_datapath/change_rem_out[4] ), .Y(n139) );
  NAND3X1 U181 ( .A(n140), .B(n101), .C(n139), .Y(\u_datapath/N24 ) );
  NOR2X1 U182 ( .A(n104), .B(\u_datapath/change_bank [5]), .Y(n151) );
  AOI22X1 U183 ( .A(\u_datapath/change_bank [4]), .B(n102), .C(
        \u_datapath/change_bank [5]), .D(n104), .Y(n150) );
  OAI21X1 U184 ( .A(\u_datapath/change_bank [4]), .B(n102), .C(n103), .Y(n149)
         );
  NAND2X1 U185 ( .A(\u_datapath/change_rem_out[3] ), .B(n121), .Y(n143) );
  NAND3X1 U186 ( .A(n143), .B(n94), .C(\u_datapath/change_bank [2]), .Y(n141)
         );
  OAI21X1 U187 ( .A(\u_datapath/change_rem_out[3] ), .B(n121), .C(n141), .Y(
        n147) );
  AOI22X1 U188 ( .A(n124), .B(\u_datapath/change_rem_out[1] ), .C(n126), .D(
        \u_datapath/N86 ), .Y(n142) );
  OAI21X1 U189 ( .A(\u_datapath/change_rem_out[1] ), .B(n124), .C(n98), .Y(
        n146) );
  NOR2X1 U190 ( .A(\u_datapath/change_bank [2]), .B(n94), .Y(n144) );
  OAI21X1 U191 ( .A(n100), .B(n144), .C(n93), .Y(n145) );
  OAI21X1 U192 ( .A(n147), .B(n146), .C(n145), .Y(n148) );
  OAI22X1 U193 ( .A(n151), .B(n150), .C(n149), .D(n148), .Y(bank_enough) );
  OAI22X1 U194 ( .A(n5), .B(\u_datapath/balance_out[3] ), .C(n2), .D(
        \u_datapath/balance_out[2] ), .Y(n152) );
  AOI21X1 U195 ( .A(\u_datapath/balance_out[2] ), .B(n2), .C(
        \u_datapath/balance_out[1] ), .Y(n153) );
  NAND2X1 U196 ( .A(n153), .B(\u_datapath/price_sel[1] ), .Y(n154) );
  AOI22X1 U197 ( .A(\u_datapath/balance_out[3] ), .B(n5), .C(n105), .D(n154), 
        .Y(n156) );
  NOR2X1 U198 ( .A(\u_datapath/balance_out[5] ), .B(
        \u_datapath/balance_out[4] ), .Y(n155) );
  NAND2X1 U199 ( .A(n156), .B(n155), .Y(enough) );
  NOR2X1 U200 ( .A(\u_datapath/n99 ), .B(\u_datapath/n100 ), .Y(
        \u_datapath/n103 ) );
endmodule

