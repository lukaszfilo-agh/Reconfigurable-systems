`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 15:45:17
// Design Name: 
// Module Name: tb_delay_line
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


module tb_delay_line# (
    parameter N = 5,
    parameter DELAY = 4
)
(  
    );
    wire [N-1:0] out;
    
    reg clk=1'b0;
    reg [N-1:0] in = 5'b10101;
    
    initial
    begin
        while(1)
        begin
            #1; clk=1'b0;
            #1; clk=1'b1;
        end
    end
    
    delay_line #(
    .N(N),
    .DELAY(DELAY)
    ) dut
    (
    .clk(clk),
    .idata(in),
    .odata(out)
    );
    
endmodule
