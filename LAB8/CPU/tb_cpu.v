`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 11:25:38
// Design Name: 
// Module Name: tb_cpu
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


module tb_cpu(
);

reg clk=1'b0;
initial
begin
    while(1)
        begin
        #1 clk=1'b0;
        #1 clk=1'b1;
    end
end
    
cpu dut (
    .clk(clk)
);
endmodule
