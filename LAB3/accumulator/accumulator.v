`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 14:46:15
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
    input clk,
    input rst,
    input ce,
    input [12:0] A,
    output [19:0] Y
);
    
wire [19:0] out;
wire [19:0] in_sumator;

c_addsub_0 add(
    .A({7'b0,A}), 
    .B(in_sumator), 
    .CLK(clk),
    .CE(ce), 
    .SCLR(rst),
    .S(out)
);

delay_line #(
    .N(20),
    .DELAY(0)
    ) delay1 (
    .clk(clk),
    .idata(out),
    .odata(in_sumator)
);

assign Y = out;
 
endmodule
