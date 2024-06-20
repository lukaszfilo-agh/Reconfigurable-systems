`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 16:23:22
// Design Name: 
// Module Name: find_max
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


module find_max(
    input [9:0] a,
    input [9:0] b,
    input [9:0] c,
    output [9:0] out,
    output [1:0] index
);

wire signed [9:0] ab;
wire signed [9:0] bc;
wire [1:0] idx_ab;
wire [1:0] idx_bc;


assign ab = a>=b ? a : b;
assign bc = b>=c ? b : c;

assign out = ab>=bc ? ab : bc;

assign idx_ab = a>=b ? 0 : 1;
assign idx_bc = b>=c ? 1 : 2;

assign index = ab>=bc ? idx_ab : idx_bc;


endmodule
