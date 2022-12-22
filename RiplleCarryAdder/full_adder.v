`timescale 1ns / 1ps

module full_adder(
    input a, b, c,
    output sum, carry
);

    wire carry1, carry2, sum1;

    half_adder ha1(a, b, sum1, carry1);
    half_adder ha2(sum1, c, sum, carry2);
    or or1(carry, carry1, carry2);
endmodule
