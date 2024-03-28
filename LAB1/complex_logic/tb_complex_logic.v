`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 22:01:35
// Design Name: 
// Module Name: tb_complex_logic
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


module tb_complex_logic(
    );
wire out;

reg [7:0] x = 8'b10101010;
reg [7:0] y = 8'b10101010;

complex_logic dut (
    .x(x),
    .y(y),
    .out(out)
);

endmodule
