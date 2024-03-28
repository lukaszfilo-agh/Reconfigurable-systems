`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 12:34:32
// Design Name: 
// Module Name: check_data
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


module check_data(
    input [0:9] idata,
    input result,
    output check
    );
    
integer file;

initial
begin
    file=$fopen("errors.log", "wb");
    $fwrite(file,"Errors:\n");
    $fclose(file);
end

always @(negedge check)
begin
    file=$fopen("errors.log", "a");
    $fwrite(file,"Input data: %b result: '%b', correct result: '%b'\n", idata, result, |idata);
    $fclose(file);
end

assign check = ( (|idata) == result );


endmodule
