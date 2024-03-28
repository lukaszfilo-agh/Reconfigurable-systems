`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 12:36:48
// Design Name: 
// Module Name: tb_or_gate
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


module tb_or_gate(
    );

wire [9:0] data;
wire check;
wire out;

input_data dut_id (
    .data_t(data)
    );
    
or_gate dut (
    .i(data),
    .o(out)
);

check_data dut_chk (
    .idata(data),
    .result(out),
    .check(check)
);
    
endmodule
