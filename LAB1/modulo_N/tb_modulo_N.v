`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 16:45:35
// Design Name: 
// Module Name: tb_modulo_N
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


module tb_modulo_N #(
    parameter N = 10,
    parameter WIDTH = $clog2(N)
)
(
    );
    wire [WIDTH-1:0] out;
    
    reg clk=1'b0;
    reg ce=1'b1;
    reg rst=1'b0;
    
    initial
    begin
        while(1)
        begin
            #1; clk=1'b0;
            #1; clk=1'b1;
        end
    end
    
    modulo_N #(
    .N(N),
    .WIDTH(WIDTH)
    ) dut
    (
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .out(out)
    );
    
endmodule
