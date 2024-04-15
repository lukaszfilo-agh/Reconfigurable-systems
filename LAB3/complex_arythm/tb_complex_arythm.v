`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 13:57:02
// Design Name: 
// Module Name: tb_complex_arythm
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


module tb_complex_arythm(
    );
    
reg clk = 1'b0;
reg ce = 1'b1;

reg signed [17:0] A=18'b111001101110101001;
reg signed [7:0] B=8'b00111011;
reg signed [11:0] C=12'b110110001010;
reg signed [7:0] D=8'b00100100;
reg signed [13:0] E=14'b11001110000000;
reg signed [18:0] F=19'b0010000110100011111;
wire signed [35:0] Y;

initial
begin
  while(1)
  begin
    #1; clk = 1'b0;
    #1; clk = 1'b1;
  end
end  

complex_arythm dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .Y(Y),
    .clk(clk)
    );
endmodule
