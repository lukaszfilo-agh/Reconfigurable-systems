`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 11:25:38
// Design Name: 
// Module Name: tb_cpu
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


module tb_cpu(
);

reg clk = 0;
reg [15:0]cnt = 8'b0;
reg [7:0]gpi = 8'b0;

wire [7:0]gpo;

initial
begin
    while(1)
    begin
        #1; clk <=1;
        #1; clk <=0;
        cnt = cnt+1;
    end
end

always @(posedge clk)
begin
    case(cnt)
        106:
        begin
            gpi = 8'b00000001;
        end
        230:
        begin
            gpi = 8'b00000010;
        end
    endcase
end
    
cpu dut(
    .clk(clk),
    .gpi(gpi),
    .gpo(gpo)
);
endmodule
