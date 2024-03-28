`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 11:59:32 AM
// Design Name: 
// Module Name: tb_cascade_and
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


module tb_cascade_and(
    );
    wire out;
    localparam LENGHT=8;
    
    reg clk=1'b0;
    reg [LENGHT-1:0]cnt = 8'b0;
    
    initial
    begin
        while(1)
        begin
            #1; clk=1'b0;
            #1; clk=1'b1;
        end
    end
    
    always @(posedge clk)
    begin
        cnt <= cnt + 1;
    end
    
    cascade_and dut
    (
        .x(cnt),
        .y(out)
    );
endmodule
