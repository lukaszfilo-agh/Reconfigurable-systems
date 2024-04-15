`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 13:10:32
// Design Name: 
// Module Name: matrix_mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module matrix_mul(
    input [12:0] A,
    input [12:0] B,
    input clk,
    output [26:0] Y,
    output [26:0] Z
);

reg signed [12:0] m11 = 13'b1111111111110;
reg signed [12:0] m12 = 13'b0000000100101;
reg signed [12:0] m21 = 13'b0000000110010;
reg signed [12:0] m22 = 13'b1111101001100;

wire signed [25:0] A_times_m11;
wire signed [25:0] B_times_m12;
wire signed [25:0] A_times_m21;
wire signed [25:0] B_times_m22;

wire signed [26:0] Y_wire;
wire signed [26:0] Z_wire;

mult_gen_0 m11A (
    .A(A),
    .B(m11),
    .P(A_times_m11),
    .CLK(clk)
);

mult_gen_0 m12B (
    .A(m12),
    .B(B),
    .P(B_times_m12),
    .CLK(clk)
);

mult_gen_0 m21A (
    .A(A),
    .B(m21),
    .P(A_times_m21),
    .CLK(clk)
);

mult_gen_0 m22B (
    .A(m22),
    .B(B),
    .P(B_times_m22),
    .CLK(clk)
);

c_addsub_0 addY (
    .A(A_times_m11),
    .B(B_times_m12),
    .S(Y_wire),
    .CLK(clk)
);

c_addsub_0 addZ (
    .A(A_times_m21),
    .B(B_times_m22),
    .S(Z_wire),
    .CLK(clk)
);

assign Y = Y_wire;
assign Z = Z_wire;

endmodule
