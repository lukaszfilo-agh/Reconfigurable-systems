`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 14:15:10
// Design Name: 
// Module Name: tb_rgb2hsv
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


module tb_rgb2hsv(
);

reg clk = 0;
wire [23:0] pixel_in;
//assign pixel_in = 24'b101101011010110000110111; //R=181, G=172, B=55
//assign pixel_in = 24'b101101010011011110101100; //R=181, G=55, B=172
assign pixel_in = 24'b001101111011010110101100; //R=55, G=181, B=172
//assign pixel_in = 24'b100111111000101010000101; //R=159, G=138, B=133
wire [23:0] pixel_out;

initial
begin
    while(1)
    begin
    #1; clk = 1'b0;
    #1; clk = 1'b1;
  end
end

wire de_out;
wire h_sync_out;
wire v_sync_out;

rgb2hsv test (
    .clk(clk),
    .de_in(1'b1),
    .h_sync_in(1'b1),
    .v_sync_in(1'b1),
    .pixel_RGB(pixel_in),
    .pixel_HSV(pixel_out),
    .de_out(de_out),
    .h_sync_out(h_sync_out),
    .v_sync_out(v_sync_out)
);


wire [23:0] H;

assign H = pixel_out[23:0];


endmodule
