`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 18:22:16
// Design Name: 
// Module Name: arythm
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


module arythm(
    input clk,
    input ce,
    input [11:0] A,
    input [11:0] B,
    input [11:0] C,
    output [24:0] out
    );
    
wire signed [11:0] wire_A;
wire signed [11:0] wire_B;
wire signed [11:0] wire_C;
wire signed [12:0] result_add;
wire signed [24:0] wire_out;
    
    
c_addsub_0 add ( //latency = 2
    .A(wire_A),
    .B(wire_B),
    .CLK(clk),
    .CE(ce),
    .S(result_add));
    
delay_line #(
    .N(12),
    .DELAY(2)
) delay (
    .idata(C),
    .clk(clk),
    .odata(wire_C)
);

mult_gen_0 mul (
    .CLK(clk),
    .A(result_add),
    .B(wire_C),
    .CE(ce),
    .P(wire_out));
    
assign wire_A = A;
assign wire_B = B;
assign out = wire_out;

endmodule
