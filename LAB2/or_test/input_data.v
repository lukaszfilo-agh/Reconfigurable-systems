`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 12:30:19
// Design Name: 
// Module Name: input_data
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


module input_data(
    output [9:0] data_t
    );
    
reg [9:0] data_r = 10'd0;
    
initial
begin
    for (data_r = 10'd0; data_r != 10'd1023; data_r = data_r + 1)
    begin
        #1;
    end
end
    
assign data_t = data_r;

endmodule
