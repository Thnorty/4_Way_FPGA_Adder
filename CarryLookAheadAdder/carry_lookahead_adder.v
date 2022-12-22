`timescale 1ns / 1ps

module carry_lookahead_adder(
    input [63:0] sayi1, sayi2,
    output [63:0] toplam
    );
    
    wire [63:0] C;
    wire [63:0] P, G, sum;

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin
            full_adder fa(sayi1[i], sayi2[i], C[i], sum[i], );
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < 63; j = j + 1) begin
            and a1(G[j], sayi1[j], sayi2[j]);
            or o1(P[j], sayi1[j], sayi2[j]);
            wire P_and_C;
            and a2(P_and_C, P[j], C[j]);
            or o2(C[j+1], G[j], P_and_C);
        end
    endgenerate

    assign C[0] = 1'b0;
    assign toplam = sum;
endmodule
