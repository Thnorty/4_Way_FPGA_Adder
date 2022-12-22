`timescale 1ns / 1ps

module parallel_prefix_adder(
    input [63:0] sayi1, sayi2,
    output [63:0] toplam
    );

    reg [62:0] g;
    reg [62:0] p;
    reg firstDigit;

    reg [7:0] i;

    always @(sayi1, sayi2) begin
        for (i = 0; i < 64; i = i + 1) begin
            if (i == 0) begin
                g[i] = sayi1[i] & sayi2[i];
                p[i] = sayi1[i] | sayi2[i];
            end
            else begin
                g[i] = sayi1[i] & sayi2[i] | g[i-1] & (sayi1[i] | sayi2[i]);
                p[i] = sayi1[i] | sayi2[i] | p[i-1] & (sayi1[i] & sayi2[i]);
            end
        end
        if (sayi1[0] == sayi2[0]) begin
            firstDigit = 1'b0;
        end
        else begin
            firstDigit = 1'b1;
        end
    end

    assign toplam = {g[62:0], firstDigit};

endmodule
