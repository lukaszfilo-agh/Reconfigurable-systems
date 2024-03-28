`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 11:35:17 AM
// Design Name: 
// Module Name: cascade_and
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


module cascade_and # (
    parameter LENGHT=8
    )
    (
    input [LENGHT-1:0]x,
    output y
    );
    
    wire [LENGHT:0] chain;
    assign chain[0] = 1'b1;
    
    genvar i;
    
    generate 
        for(i=0; i<LENGHT; i = i+1) begin
        assign chain[i+1] = x[i] & chain[i];
        end
    endgenerate
    assign y = chain[LENGHT];
endmodule
