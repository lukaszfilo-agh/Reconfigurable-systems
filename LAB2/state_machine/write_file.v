`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 12:42:09 PM
// Design Name: 
// Module Name: write_file
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


module write_file#(
    parameter LENGTH = 16
)
(
    input idata
    );
    
integer file;
reg [7:0] i;

initial
    begin
    file = $fopen ("/media/lsriw/2E2E-BD4A/VIVADO_PROJECTS/state_machine/output_vivado.txt","wb");
        for (i = 0; i < LENGTH*12; i = i + 1)
            begin
            $fwrite(file, "%d", idata);
            #2;
        end
    $fclose(file);
    $finish;
end
    
endmodule
