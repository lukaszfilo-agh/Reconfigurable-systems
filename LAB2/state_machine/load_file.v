`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 12:42:09 PM
// Design Name: 
// Module Name: load_file
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


module load_file #(
    parameter LENGTH  = 16
)
(
    output [7:0] odata,
    output send
    );

integer file;
reg [7:0] data_r = 0;
reg [7:0] i = 0;
reg send_r = 0;

initial begin
    file = $fopen("/media/lsriw/2E2E-BD4A/VIVADO_PROJECTS/state_machine/asci.txt","rb");
    for (i = 0; i < LENGTH; i = i + 1) begin
        data_r = $fgetc(file);
        #24;
    end
    $fclose(file);
end

always begin
    #2;
    send_r = 1'b1;
    #2;
    send_r = 1'b0;
    #20;
end

assign odata = data_r;
assign send = send_r;

endmodule