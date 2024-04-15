`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 13:23:19
// Design Name: 
// Module Name: complex_arythm
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


module complex_arythm(
    input clk,
    input [17:0] A,
    input [7:0] B,
    input [11:0] C,
    input [7:0] D,
    input [13:0] E,
    input [18:0] F,
    output [35:0] Y
    );
    
wire signed [12:0] B_ext;
assign B_ext={B,5'b0};
wire signed [10:0] D_ext;
assign D_ext={D,3'b0};
wire signed [17:0] E_ext;
assign E_ext={E,4'b0};

wire signed [18:0] A_sum_B;
wire signed [30:0] AB_times_C;
wire signed [14:0] E_sum_D;
wire signed [19:0] E_sum_F;
wire signed [34:0] ED_times_EF;
wire signed [11:0] Delay_C;
wire signed [35:0] Y_wire;
 
c_addsub_0 AsumB ( //latency = 2
    .A(A),
    .B(B_ext),
    .CLK(clk),
    .S(A_sum_B)
);

c_addsub_1 DsumE ( //latency = 2
    .A(D_ext),
    .B(E),
    .CLK(clk),
    .S(E_sum_D)
);

c_addsub_2 EsumF ( //latency = 2
    .A(E_ext),
    .B(F),
    .CLK(clk),
    .S(E_sum_F)
);
    
delay_line #(
    .N(12),
    .DELAY(2)
    ) delay1 (
    .clk(clk),
    .idata(C),
    .odata(Delay_C)
);
 
mult_gen_0 ABtimesC (
    .A(A_sum_B),
    .B(Delay_C),
    .CLK(clk),
    .P(AB_times_C)
);

mult_gen_1 EDtimesEF (
    .A(E_sum_D),
    .B(E_sum_F),
    .CLK(clk),
    .P(ED_times_EF));

wire signed [34:0] ED_times_EF_ext;
assign ED_times_EF_ext = {ED_times_EF, 1'b0};

c_addsub_3 ABCsumEDEF ( //latency = 2
    .A(AB_times_C),
    .B(ED_times_EF_ext),
    .CLK(clk),
    .S(Y_wire)); 

assign Y = Y_wire;

endmodule
