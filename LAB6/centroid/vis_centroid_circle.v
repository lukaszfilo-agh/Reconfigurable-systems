`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 11:06:18
// Design Name: 
// Module Name: vis_centroid_circle
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


module vis_centroid_circle #(
    parameter IMG_H = 64,
    parameter IMG_W = 64
)
(
    input [10:0] x,
    input [10:0] y,
    input clk,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input [23:0] pixel_in,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_out
);

wire [7:0] R;
wire [7:0] G;
wire [7:0] B;

assign R = pixel_in[23:16];
assign G = pixel_in[15:8];
assign B = pixel_in[7:0];

reg [10:0] x_pos = 0;
reg [10:0] y_pos = 0;
reg prev_vsync;

reg [7:0] R_reg;
reg [7:0] G_reg;
reg [7:0] B_reg;

always @(posedge clk)
begin
    R_reg <= R;
    G_reg <= G;
    B_reg <= B;
    
    prev_vsync <= v_sync_in;
    
    if (v_sync_in == 1)
    begin
        x_pos <= 0;
        y_pos <= 0;
    end
    
    if (de_in == 1)
    begin
        x_pos <= x_pos + 1;
        if (x_pos == IMG_W - 1)
        begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
        end
    end
    
    if ((x_pos == x) && ((y_pos == y + 3) || (y_pos == y - 3)))
    begin
        R_reg <= 255;
        G_reg <= 0;
        B_reg <= 0;
    end
    
    if ((y_pos == y + 2) || (y_pos == y - 2))
    begin
        if ((x_pos > x-3) && (x_pos < x+3))
        begin
            R_reg <= 255;
            G_reg <= 0;
            B_reg <= 0;
        end
    end
    
    if ((y_pos == y + 1) || (y_pos == y - 1))
    begin
        if ((x_pos > x-3) && (x_pos < x+3))
        begin
            R_reg <= 255;
            G_reg <= 0;
            B_reg <= 0;
        end
    end
    
    if (y_pos == y)
    begin
        if ((x_pos > x-4) && (x_pos < x+4))
        begin
            R_reg <= 255;
            G_reg <= 0;
            B_reg <= 0;
        end
    end
    
    if ((x_pos == x) && ((y_pos - y) < 3) && ((y - y_pos) < 3))
    begin
        R_reg <= 255;
        G_reg <= 0;
        B_reg <= 0;
    end
    
    if (((x_pos - x) == 1) && ((y_pos - y) < 2) && ((y - y_pos) < 2))
    begin
        R_reg <= 255;
        G_reg <= 0;
        B_reg <= 0;
    end
    
    if ((y_pos == y) && ((x_pos - x) < 3) && ((x - x_pos) < 3))
    begin
        R_reg <= 255;
        G_reg <= 0;
        B_reg <= 0;
    end
end

assign pixel_out[23:16] = R_reg;
assign pixel_out[15:8] = G_reg;
assign pixel_out[7:0] = B_reg;

assign de_out = de_in;
assign h_sync_out = h_sync_in;
assign v_sync_out = v_sync_in;

endmodule
