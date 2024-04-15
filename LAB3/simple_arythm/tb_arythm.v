`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2024 11:12:08
// Design Name: 
// Module Name: tb_arythm
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


module tb_arythm(
);

reg clk = 1'b0;
reg ce  = 1'b1;

reg signed [11:0] A=12'b000101001011; //A=0.32345
reg signed [11:0] B=12'b110011011010; //B=-0.78743
reg signed [11:0] C=12'b001001000011; //C=0.56532
wire signed [24:0] out; //-0.2623

initial
begin
   while(1)
   begin
     #1; clk = 1'b0;
     #1; clk = 1'b1;
   end
end  

arythm dut(
  .A(A),
  .B(B),
  .C(C),
  .out(out),
  .clk(clk),
  .ce(ce)
);

endmodule
