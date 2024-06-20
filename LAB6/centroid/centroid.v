`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 09:10:51
// Design Name: 
// Module Name: centroid
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


module centroid #(
    parameter IMG_H = 64,
    parameter IMG_W = 64
)
(
    input clk,
    input ce,
    input rst,
    input de,
    input hsync,
    input vsync,
    input mask,
    output [10:0] x,
    output [10:0] y
);

reg [10:0] x_pos = 0;
reg [10:0] y_pos = 0;

reg prev_vsync;

reg [20:0] m00 = 0;
reg [20:0] m00w = 0; // mozliwe ze niepotrzebne

wire eof;

wire [30:0] m01_wire;
wire [30:0] m10_wire;

wire [10:0] result_x;
wire [10:0] result_y;

wire ready_x;
wire ready_y;

always @(posedge  clk)
begin
    prev_vsync <= vsync; //end of frame
    
    if (vsync == 1)
    begin
        x_pos <= 0;
        y_pos <= 0;
    end
    
    m00w <= m00;
    
    if (eof == 1)
    begin
        m00 <= 0;
    end
    
    if (de == 1)
    begin
        if (mask == 1)
        begin
            m00 <= m00 + 1;
        end
        x_pos <= x_pos + 1;
        if (x_pos == IMG_W - 1)
        begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
            if (y_pos == IMG_H - 1)
            begin
                y_pos <= 0;
            end
        end
    end
end

assign eof = (prev_vsync == 1'b0 & vsync == 1'b1) ? 1'b1 : 1'b0;

accumulator add_x (
    .rst(eof),
    .clk(clk),
    .ce(mask && de),
    .A(x_pos),
    .Y(m10_wire)
);

accumulator add_y (
    .rst(eof),
    .clk(clk),
    .ce(mask && de),
    .A(y_pos),
    .Y(m01_wire)
);

divider_ip div_x (
    .clk(clk),
    .start(eof),
    .dividend({1'b0, m10_wire}),
    .divisor(m00[19:0]),
    .quotient(result_x),
    .qv(ready_x)
);

divider_ip div_y (
    .clk(clk),
    .start(eof),
    .dividend({1'b0, m01_wire}),
    .divisor(m00[19:0]),
    .quotient(result_y),
    .qv(ready_y)
);

assign x = result_x[10:0];
assign y = result_y[10:0];

endmodule
