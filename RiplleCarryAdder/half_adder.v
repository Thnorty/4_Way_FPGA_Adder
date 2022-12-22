`timescale 1ns / 1ps

module half_adder(
    input a, b,
    output sum, carry
);

    xor xor1(sum, a, b);
    and and1(carry, a, b);
endmodule
