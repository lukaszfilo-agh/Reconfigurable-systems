`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 09:32:23
// Design Name: 
// Module Name: accumulator
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


module accumulator(
    input rst,
    input clk,
    input ce,
    input [10:0] A,
    output [30:0] Y
);

wire [30:0] result_w;
wire [30:0] add_out;


accumulator_add adder (
    .A(A),
    .B(result_w),
    .S(add_out)
);

latency_reg latency (
    .rst(rst),
    .clk(clk),
    .ce(ce),
    .in(add_out),
    .out(result_w)
);

assign Y = result_w;

endmodule
