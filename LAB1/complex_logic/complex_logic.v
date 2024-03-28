`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 17:10:36
// Design Name: 
// Module Name: complex_logic
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


module complex_logic(
    input [7:0] x,
    input [7:0] y,
    output out
);

wire [7:0] temp_8;
wire [3:0] temp_4;
wire [1:0] temp_2;

genvar i;
generate
    for (i=0; i < 8; i = i+ 1)
    begin
    assign temp_8[i] = x[i] & y[i];
        if (i % 2 == 0)
        begin
            assign temp_4[i/2] = temp_8[i] | temp_8[i+1];
            if (i % 4 == 0)
            begin
                assign temp_2[i/4] = temp_4[i/2] & temp_4[i/2 + 1];
            end
        end
    end
endgenerate

assign out = temp_2[0] | temp_2[1];

endmodule
