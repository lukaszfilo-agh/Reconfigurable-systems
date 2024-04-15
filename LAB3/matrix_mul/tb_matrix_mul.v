`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 14:22:01
// Design Name: 
// Module Name: tb_matrix_mul
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


module tb_matrix_mul(
);

reg clk = 1'b0;

reg signed [12:0] A = 13'b0000001010101;
reg signed [12:0] B = 13'b0000001010101;

wire signed [26:0] Y;
wire signed [26:0] Z;

initial
begin
    while(1)
    begin
        #1; clk = 1'b0;
        #1; clk = 1'b1;
    end
end

matrix_mul dut (
    .A(A),
    .B(B),
    .clk(clk),
    .Y(Y),
    .Z(Z)
);

endmodule
