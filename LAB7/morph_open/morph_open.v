`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2024 17:38:13
// Design Name: 
// Module Name: morph_open
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


module morph_open #(
    parameter IMG_H = 83
)
(
    input clk,
    input mask,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    output de_out,
    output h_sync_out,
    output v_sync_out, 
    output [23:0] open_out
);

wire mask_t;
wire de_t;
wire h_sync_t;
wire v_sync_t;
wire [23:0] pixel_t;

erosion #(
    .IMG_H(IMG_H)
) erode (
    .clk(clk),
    .mask(mask),
    .de_in(de_in),
    .h_sync_in(h_sync_in),
    .v_sync_in(v_sync_in),
    .de_out(de_t),
    .h_sync_out(h_sync_t),
    .v_sync_out(v_sync_t),
    .erosion_out(pixel_t)
);

dilatation #(
    .IMG_H(IMG_H)
) dilatate (
    .clk(clk),
    .mask(pixel_t),
    .de_in(de_t),
    .h_sync_in(h_sync_t),
    .v_sync_in(v_sync_t),
    .de_out(de_out),
    .h_sync_out(h_sync_out),
    .v_sync_out(v_sync_out),
    .dilatation_out(open_out)
);

endmodule
