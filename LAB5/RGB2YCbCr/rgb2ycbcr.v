`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 12:38:31
// Design Name: 
// Module Name: rgb2ycbcr
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


module rgb2ycbcr(
    input clk,
    input de_in,
    input Hsync_in,
    input Vsync_in,
    input [23:0] pixel_RGB,
    output de_out,
    output Hsync_out,
    output Vsync_out,
    output [23:0] pixel_YCbCr
);

wire signed [17:0] R;
wire signed [17:0] G;
wire signed [17:0] B;

wire signed [17:0] M11;
wire signed [17:0] M12;
wire signed [17:0] M13;
wire signed [17:0] M21;
wire signed [17:0] M22;
wire signed [17:0] M23;
wire signed [17:0] M31;
wire signed [17:0] M32;
wire signed [17:0] M33;

wire signed [35:0] R_MUL_M11;
wire signed [35:0] G_MUL_M12;
wire signed [35:0] B_MUL_M13;
wire signed [35:0] R_MUL_M21;
wire signed [35:0] G_MUL_M22;
wire signed [35:0] B_MUL_M23;
wire signed [35:0] R_MUL_M31;
wire signed [35:0] G_MUL_M32;
wire signed [35:0] B_MUL_M33;

wire signed [8:0] Y_ADD_11_12;
wire signed [8:0] Y_ADD_13_delay;
wire signed [8:0] Y_final;

wire signed [8:0] Cb_ADD_21_22;
wire signed [8:0] Cb_ADD_23_const;
wire signed [8:0] Cb_final;

wire signed [8:0] Cr_ADD_31_32;
wire signed [8:0] Cr_ADD_33_const;
wire signed [8:0] Cr_final;

wire signed [8:0] const;

assign R = {10'b0,pixel_RGB[23:16]};
assign G = {10'b0,pixel_RGB[15:8]};
assign B = {10'b0,pixel_RGB[7:0]};

assign M11 = 18'b001001100100010111;
assign M12 = 18'b010010110010001011; 
assign M13 = 18'b000011101001011110;

assign M21 = 18'b111010100110011011;
assign M22 = 18'b110101011001100101;
assign M23 = 18'b010000000000000000;

assign M31 = 18'b010000000000000000;
assign M32 = 18'b110010100110100010;
assign M33 = 18'b111101011001011110;

assign const = 9'b010000000;

MULT RM11 (
    .CLK(clk),
    .A(R),
    .B(M11),
    .P(R_MUL_M11)
);

MULT GM12 (
    .CLK(clk),
    .A(G),
    .B(M12),
    .P(G_MUL_M12)
);

MULT BM13 (
    .CLK(clk),
    .A(B),
    .B(M13),
    .P(B_MUL_M13)
);

MULT RM21 (
    .CLK(clk),
    .A(R),
    .B(M21),
    .P(R_MUL_M21)
);

MULT GM22 (
    .CLK(clk),
    .A(G),
    .B(M22),
    .P(G_MUL_M22)
);

MULT BM23 (
    .CLK(clk),
    .A(B),
    .B(M23),
    .P(B_MUL_M23)
);

MULT RM31 (
    .CLK(clk),
    .A(R),
    .B(M31),
    .P(R_MUL_M31)
);

MULT GM32 (
    .CLK(clk),
    .A(G),
    .B(M32),
    .P(G_MUL_M32)
);

MULT BM33 (
    .CLK(clk),
    .A(B),
    .B(M33),
    .P(B_MUL_M33)
);

// Y
ADD ADD_Y1 ( //latency = 1
    .A({R_MUL_M11[35], R_MUL_M11[24:17]}),
    .B({G_MUL_M12[35], G_MUL_M12[24:17]}),
    .CLK(clk),
    .S(Y_ADD_11_12)
  );
  
delay_line #(
    .N(9),
    .DELAY(1)
    ) Y2_delay (
    .idata({B_MUL_M13[35], B_MUL_M13[24:17]}),
    .clk(clk),
    .odata(Y_ADD_13_delay)
);

ADD ADD_Y_final (
    .A(Y_ADD_11_12),
    .B(Y_ADD_13_delay),
    .CLK(clk),
    .S(Y_final)
);

//Cb
ADD ADD_Cb1( //latency = 1
    .A({R_MUL_M21[35], R_MUL_M21[24:17]}),
    .B({G_MUL_M22[35], G_MUL_M22[24:17]}),
    .CLK(clk),
    .S(Cb_ADD_21_22)
  );

ADD ADD_Cb2(
    .A({B_MUL_M23[35], B_MUL_M23[24:17]}),
    .B(const),
    .CLK(clk),
    .S(Cb_ADD_23_const)
);

ADD ADD_Cb_final (
    .A(Cb_ADD_21_22),
    .B(Cb_ADD_23_const),
    .CLK(clk),
    .S(Cb_final)
);


//Cr
ADD ADD_Cr1 ( //latency = 1
    .A({R_MUL_M31[35], R_MUL_M31[24:17]}),
    .B({G_MUL_M32[35], G_MUL_M32[24:17]}),
    .CLK(clk),
    .S(Cr_ADD_31_32)
  );

ADD ADD_Cr2 (
    .A({B_MUL_M33[35], B_MUL_M33[24:17]}),
    .B(const),
    .CLK(clk),
    .S(Cr_ADD_33_const)
);

ADD ADD_Cr_final (
    .A(Cr_ADD_31_32),
    .B(Cr_ADD_33_const),
    .CLK(clk),
    .S(Cr_final)
);

assign pixel_YCbCr = {Y_final[7:0], Cb_final[7:0], Cr_final[7:0]};

// sync
delay_line #(
    .N(3),
    .DELAY(5) // 3 mul + 2 add
    ) sync_delay (
    .idata({de_in, Hsync_in, Vsync_in}),
    .clk(clk),
    .odata({de_out, Hsync_out, Vsync_out})
);

endmodule
