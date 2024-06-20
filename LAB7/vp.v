`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 13:15:55
// Design Name: 
// Module Name: vp
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


module vp(
    input clk,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input [3:0] sw,
    input [23:0] pixel_in,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_out
    );

wire [23:0]rgb_mux[15:0];
wire de_mux[15:0];
wire h_sync_mux[15:0];
wire v_sync_mux[15:0];

wire [10:0] x;
wire [10:0] y;

assign rgb_mux[0] = pixel_in;
assign de_mux[0] = de_in;
assign h_sync_mux[0] = h_sync_in;
assign v_sync_mux[0] = v_sync_in;

RGB2YCbCr_module YCbCr(
    .clk(clk),
    .de_in(de_in),
    .Hsync_in(h_sync_in),
    .Vsync_in(v_sync_in),
    .pixel_RGB(pixel_in),
    .de_out(de_mux[1]),
    .Hsync_out(h_sync_mux[1]),
    .Vsync_out(v_sync_mux[1]),
    .pixel_YCbCr(rgb_mux[1])
);

YCbCr_threshold_module YCbCr_threshold (
    .de_in(de_mux[1]),
    .h_sync_in(h_sync_mux[1]),
    .v_sync_in(v_sync_mux[1]),
    .pixel_in(rgb_mux[1]),
    .de_out(de_mux[2]),
    .h_sync_out(h_sync_mux[2]),
    .v_sync_out(v_sync_mux[2]),
    .pixel_out(rgb_mux[2])
);

centroid_0 center(
    .clk(clk),
    .ce(1'b1),
    .rst(1'b0),
    .de(de_mux[2]),
    .hsync(h_sync_mux[2]),
    .vsync(v_sync_mux[2]),
    .mask(rgb_mux[2]),
    .x(x),
    .y(y)
);

vis_cross cross (
    .x(x),
    .y(y),
    .clk(clk),
    .de_in(de_mux[2]),
    .h_sync_in(h_sync_mux[2]),
    .v_sync_in(v_sync_mux[2]),
    .pixel_in(rgb_mux[2]),
    .de_out(de_mux[3]),
    .h_sync_out(h_sync_mux[3]),
    .v_sync_out(v_sync_mux[3]),
    .pixel_out(rgb_mux[3])
);

vis_circle circle (
    .x(x),
    .y(y),
    .clk(clk),
    .de_in(de_mux[2]),
    .h_sync_in(h_sync_mux[2]),
    .v_sync_in(v_sync_mux[2]),
    .pixel_in(rgb_mux[2]),
    .de_out(de_mux[4]),
    .h_sync_out(h_sync_mux[4]),
    .v_sync_out(v_sync_mux[4]),
    .pixel_out(rgb_mux[4])
);

rgb2hsv_module rgb2hsv (
    .clk(clk),
    .de_in(de_in),
    .h_sync_in(h_sync_in),
    .v_sync_in(v_sync_in),
    .pixel_RGB(pixel_in),
    .de_out(de_mux[5]),
    .h_sync_out(h_sync_mux[5]),
    .v_sync_out(v_sync_mux[5]),
    .pixel_HSV(rgb_mux[5])
);

median5x5_module medfilt (
    .clk(clk),
    .de_in(de_mux[2]),
    .h_sync_in(h_sync_mux[2]),
    .v_sync_in(v_sync_mux[2]),
    .mask(rgb_mux[2]),
    .de_out(de_mux[6]),
    .h_sync_out(h_sync_mux[6]),
    .v_sync_out(v_sync_mux[6]),
    .median_out(rgb_mux[6]) 
);

morph_open_module open (
    .clk(clk),
    .de_in(de_mux[2]),
    .h_sync_in(h_sync_mux[2]),
    .v_sync_in(v_sync_mux[2]),
    .mask(rgb_mux[2]),
    .de_out(de_mux[7]),
    .h_sync_out(h_sync_mux[7]),
    .v_sync_out(v_sync_mux[7]),
    .open_out(rgb_mux[7])
);

mean3x3_module mean (
    .clk(clk),
    .de_in(de_mux[1]),
    .h_sync_in(h_sync_mux[1]),
    .v_sync_in(v_sync_mux[1]),
    .Y(rgb_mux[1][23:16]),
    .de_out(de_mux[8]),
    .h_sync_out(h_sync_mux[8]),
    .v_sync_out(v_sync_mux[8]),
    .mean_out(rgb_mux[8])
);

// assign to main out
assign pixel_out = rgb_mux[sw];
assign de_out = de_mux[sw];
assign h_sync_out = h_sync_mux[sw];
assign v_sync_out = v_sync_mux[sw];

endmodule
