`timescale 1ns / 1ps
//-----------------------------------------------
// Company: agh
//-----------------------------------------------
module d_mem
(
  input [7:0]address,
  output [7:0]data
);
//-----------------------------------------------
//data memory
wire [7:0]data_memory[255:0];
assign data_memory[0]=8'b00000001;
assign data_memory[1]=8'b00000010;
assign data_memory[2]=8'b00000100;
assign data_memory[3]=8'b00001000;
assign data_memory[4]=8'b00010000;
assign data_memory[5]=8'b00100000;
assign data_memory[6]=8'b01000000;
assign data_memory[7]=8'b00000000;
//-----------------------------------------------
assign data=data_memory[address];
//-----------------------------------------------
endmodule
//-----------------------------------------------
