`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 20:19:21
// Design Name: 
// Module Name: YCbCr_threshold
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


module YCbCr_threshold(
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input [23:0] pixel_in,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_out
);

wire [23:0] pixel;
wire [7:0] Y;
wire [7:0] Cb;
wire [7:0] Cr;

assign pixel = pixel_in;
assign Y = pixel[23:16];
assign Cb = pixel[15:8];
assign Cr = pixel[7:0];

localparam Ta = 30;
localparam Tb = 140;
localparam Tc = 146;
localparam Td = 200;

wire [7:0] bin;
assign bin = (Cb > Ta && Cb < Tb && Cr > Tc && Cr < Td ) ? 8'd255 : 0;

assign de_out = de_in;
assign h_sync_out = h_sync_in;
assign v_sync_out = v_sync_in;
assign pixel_out = ({bin,bin,bin});

endmodule
