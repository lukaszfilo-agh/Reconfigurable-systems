`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 15:15:44
// Design Name: 
// Module Name: tb_accumulator
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


module tb_accumulator(
);

reg clk = 1'b0;
reg rst = 1'b0;
reg [3:0] cnt = 0;
reg [12:0] A = 13'b0000001110110;
wire [19:0] out;

initial begin
    #2; A <= 13'b0000000100111;
    #2; A <= 13'b0000000011100;
    #2; A <= 13'b0000010000111;
    #2; A <= 13'b0000011000101;
    #2; A <= 13'b0000001100111;
    #2; A <= 13'b0000000110111;
    #2; A <= 13'b0000000100000;
    #2; A <= 13'b0000001000111;
    #2; A <= 13'b0000001010100;
end

initial begin
    while(1) begin
        #1; clk <= 1'b0;
        #1; clk <= 1'b1;
    end
end

always @(posedge clk) begin
    if (cnt == 10) begin
        cnt <= 0;
        rst <= 1'b1;
    end else begin
        if (rst == 1) begin
            rst <= 1'b0;
        end else begin
            cnt <= cnt + 1;
        end
    end  
end

accumulator dut(
    .clk(clk),
    .ce(1'b1),
    .rst(rst),
    .A(A),
    .Y(out)
);
endmodule
