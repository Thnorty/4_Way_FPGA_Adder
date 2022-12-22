`timescale 1ns / 1ps

module ripple_carry_adder(
    input [63:0] sayi1, sayi2,
    output [63:0] toplam
    );
    wire [61:0] carry;
    
    full_adder fa1(sayi1[0], sayi2[0], 1'b0, toplam[0], carry[0]);
    full_adder fa2(sayi1[1], sayi2[1], carry[0], toplam[1], carry[1]);
    full_adder fa3(sayi1[2], sayi2[2], carry[1], toplam[2], carry[2]);
    full_adder fa4(sayi1[3], sayi2[3], carry[2], toplam[3], carry[3]);
    full_adder fa5(sayi1[4], sayi2[4], carry[3], toplam[4], carry[4]);
    full_adder fa6(sayi1[5], sayi2[5], carry[4], toplam[5], carry[5]);
    full_adder fa7(sayi1[6], sayi2[6], carry[5], toplam[6], carry[6]);
    full_adder fa8(sayi1[7], sayi2[7], carry[6], toplam[7], carry[7]);
    full_adder fa9(sayi1[8], sayi2[8], carry[7], toplam[8], carry[8]);
    full_adder fa10(sayi1[9], sayi2[9], carry[8], toplam[9], carry[9]);
    full_adder fa11(sayi1[10], sayi2[10], carry[9], toplam[10], carry[10]);
    full_adder fa12(sayi1[11], sayi2[11], carry[10], toplam[11], carry[11]);
    full_adder fa13(sayi1[12], sayi2[12], carry[11], toplam[12], carry[12]);
    full_adder fa14(sayi1[13], sayi2[13], carry[12], toplam[13], carry[13]);
    full_adder fa15(sayi1[14], sayi2[14], carry[13], toplam[14], carry[14]);
    full_adder fa16(sayi1[15], sayi2[15], carry[14], toplam[15], carry[15]);
    full_adder fa17(sayi1[16], sayi2[16], carry[15], toplam[16], carry[16]);
    full_adder fa18(sayi1[17], sayi2[17], carry[16], toplam[17], carry[17]);
    full_adder fa19(sayi1[18], sayi2[18], carry[17], toplam[18], carry[18]);
    full_adder fa20(sayi1[19], sayi2[19], carry[18], toplam[19], carry[19]);
    full_adder fa21(sayi1[20], sayi2[20], carry[19], toplam[20], carry[20]);
    full_adder fa22(sayi1[21], sayi2[21], carry[20], toplam[21], carry[21]);
    full_adder fa23(sayi1[22], sayi2[22], carry[21], toplam[22], carry[22]);
    full_adder fa24(sayi1[23], sayi2[23], carry[22], toplam[23], carry[23]);
    full_adder fa25(sayi1[24], sayi2[24], carry[23], toplam[24], carry[24]);
    full_adder fa26(sayi1[25], sayi2[25], carry[24], toplam[25], carry[25]);
    full_adder fa27(sayi1[26], sayi2[26], carry[25], toplam[26], carry[26]);
    full_adder fa28(sayi1[27], sayi2[27], carry[26], toplam[27], carry[27]);
    full_adder fa29(sayi1[28], sayi2[28], carry[27], toplam[28], carry[28]);
    full_adder fa30(sayi1[29], sayi2[29], carry[28], toplam[29], carry[29]);
    full_adder fa31(sayi1[30], sayi2[30], carry[29], toplam[30], carry[30]);
    full_adder fa32(sayi1[31], sayi2[31], carry[30], toplam[31], carry[31]);
    full_adder fa33(sayi1[32], sayi2[32], carry[31], toplam[32], carry[32]);
    full_adder fa34(sayi1[33], sayi2[33], carry[32], toplam[33], carry[33]);
    full_adder fa35(sayi1[34], sayi2[34], carry[33], toplam[34], carry[34]);
    full_adder fa36(sayi1[35], sayi2[35], carry[34], toplam[35], carry[35]);
    full_adder fa37(sayi1[36], sayi2[36], carry[35], toplam[36], carry[36]);
    full_adder fa38(sayi1[37], sayi2[37], carry[36], toplam[37], carry[37]);
    full_adder fa39(sayi1[38], sayi2[38], carry[37], toplam[38], carry[38]);
    full_adder fa40(sayi1[39], sayi2[39], carry[38], toplam[39], carry[39]);
    full_adder fa41(sayi1[40], sayi2[40], carry[39], toplam[40], carry[40]);
    full_adder fa42(sayi1[41], sayi2[41], carry[40], toplam[41], carry[41]);
    full_adder fa43(sayi1[42], sayi2[42], carry[41], toplam[42], carry[42]);
    full_adder fa44(sayi1[43], sayi2[43], carry[42], toplam[43], carry[43]);
    full_adder fa45(sayi1[44], sayi2[44], carry[43], toplam[44], carry[44]);
    full_adder fa46(sayi1[45], sayi2[45], carry[44], toplam[45], carry[45]);
    full_adder fa47(sayi1[46], sayi2[46], carry[45], toplam[46], carry[46]);
    full_adder fa48(sayi1[47], sayi2[47], carry[46], toplam[47], carry[47]);
    full_adder fa49(sayi1[48], sayi2[48], carry[47], toplam[48], carry[48]);
    full_adder fa50(sayi1[49], sayi2[49], carry[48], toplam[49], carry[49]);
    full_adder fa51(sayi1[50], sayi2[50], carry[49], toplam[50], carry[50]);
    full_adder fa52(sayi1[51], sayi2[51], carry[50], toplam[51], carry[51]);
    full_adder fa53(sayi1[52], sayi2[52], carry[51], toplam[52], carry[52]);
    full_adder fa54(sayi1[53], sayi2[53], carry[52], toplam[53], carry[53]);
    full_adder fa55(sayi1[54], sayi2[54], carry[53], toplam[54], carry[54]);
    full_adder fa56(sayi1[55], sayi2[55], carry[54], toplam[55], carry[55]);
    full_adder fa57(sayi1[56], sayi2[56], carry[55], toplam[56], carry[56]);
    full_adder fa58(sayi1[57], sayi2[57], carry[56], toplam[57], carry[57]);
    full_adder fa59(sayi1[58], sayi2[58], carry[57], toplam[58], carry[58]);
    full_adder fa60(sayi1[59], sayi2[59], carry[58], toplam[59], carry[59]);
    full_adder fa61(sayi1[60], sayi2[60], carry[59], toplam[60], carry[60]);
    full_adder fa62(sayi1[61], sayi2[61], carry[60], toplam[61], carry[61]);
    full_adder fa63(sayi1[62], sayi2[62], carry[61], toplam[62], toplam[63]);

endmodule
