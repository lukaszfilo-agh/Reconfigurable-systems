`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 12:28:34 PM
// Design Name: 
// Module Name: delay_single
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


module delay_single #(
    parameter N = 4
)
(
    input clk,
    input [N-1:0] d,
    output [N-1:0] q
    );
reg [N-1:0]val = 0;

always @(posedge clk)
begin
    val<=d;
end

assign q=val;

endmodule
