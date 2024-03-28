`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 16:28:36
// Design Name: 
// Module Name: modulo_N
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


module modulo_N #(
    parameter N = 8,
    parameter WIDTH = $clog2(N)
)
(
    input clk,
    input ce,
    input rst,
    output [WIDTH - 1:0] out
    );
    
    reg [WIDTH - 1:0]val = 0;
    
    always @(posedge clk)
    begin
        if(rst) val <= 0;
        else begin
            if(ce) begin
                if(val == N - 1) val <= 0;
                else val <= val + 1;
            end
            else val <= val;
        end
    end
    assign out = val;
endmodule
