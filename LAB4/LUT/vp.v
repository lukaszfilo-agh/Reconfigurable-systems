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
    input [2:0] sw,
    input [23:0] pixel_in,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_out
    );

wire [7:0] R;
wire [7:0] G;
wire [7:0] B;

LUT LUT_R(
    .a(pixel_in[23:16]),
    .clk(clk),
    .qspo(R[7:0])
    );
        
LUT LUT_G(
    .a(pixel_in[15:8]),
    .clk(clk),
    .qspo(G[7:0])
    );
        
LUT LUT_B(
    .a(pixel_in[7:0]),
    .clk(clk),
    .qspo(B[7:0])
    ); 

reg r_de = 0;
reg r_hsync = 0;
reg r_vsync = 0;

always @(posedge clk)
begin
    r_de <= de_in;
    r_hsync <= h_sync_in;
    r_vsync <= v_sync_in;
end

assign de_out = r_de;
assign h_sync_out = r_hsync;
assign v_sync_out = r_vsync;

assign pixel_out = {R, G, B};
 
endmodule
