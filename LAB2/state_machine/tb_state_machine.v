`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 12:39:58 PM
// Design Name: 
// Module Name: tb_state_machine
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


module tb_state_machine #(
    parameter LENGTH = 16
)
( 
    );
    
wire [7:0] odata;
wire send;
wire y;
reg clk = 1'b0;

initial
    begin
    while(1)
    begin
        #1; clk=1'b0;
        #1; clk=1'b1;
    end
end

load_file #(
        .LENGTH(LENGTH)
    )
    dutr (
        .odata(odata), 
        .send(send)
);
        
state_machine duts (
    .clk(clk),
    .rst(1'b0),
    .send(send),
    .data(odata), 
    .txd(y));
        
write_file #(
    .LENGTH(LENGTH)
) 
dutw(
    .idata(y));


endmodule
