`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 12:19:52 PM
// Design Name: 
// Module Name: delay_line
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


module delay_line # (
    parameter N = 4,
    parameter DELAY = 4
)
(
    input [N-1:0] idata,
    input clk,
    output [N-1:0] odata
    );
    wire [N-1:0] tdata [DELAY:0];
    assign tdata[0] = idata;
    genvar i;
    generate
        if (DELAY == 0) begin
            assign odata = idata;
        end 
        else begin
            for (i = 0; i < DELAY; i = i + 1) begin
                delay_single #(
                .N(N)
                )
                delay1
                (
                .clk(clk),
                .d(tdata[i]),
                .q(tdata[i+1])
                );
              end
              assign odata = tdata[DELAY];
         end
    endgenerate
endmodule
