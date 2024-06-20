`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 10:58:35
// Design Name: 
// Module Name: alu
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


module alu(
    input clk,
    input [7:0] rx,
    input [7:0] ry,
    output [7:0] and_out,
    output [7:0] add_out,
    output [7:0] zero_out
);

assign and_out = rx & ry;
assign add_out = rx + ry;
assign zero_out = (rx == 8'b0 ? 8'b11111111 : 8'b00000000);

endmodule
