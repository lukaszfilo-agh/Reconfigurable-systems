`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 13:50:17
// Design Name: 
// Module Name: rgb2hsv
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


module rgb2hsv(
    input clk,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input [23:0] pixel_RGB,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_HSV
);

wire signed [7:0] R;
assign R = pixel_RGB[23:16];

wire signed [7:0] G;
assign G = pixel_RGB[15:8];

wire signed [7:0] B;
assign B = pixel_RGB[7:0];

// Constant 255 for division
wire signed [7:0] const_255;
assign const_255 = 8'd255;

// Divide R, G and B to [0,1]
wire signed [15:0] div_R;
RGB_DIV R_DIV ( // latency = 18
    .aclk(clk),
    .s_axis_dividend_tdata(R),
    .s_axis_divisor_tdata(const_255),
    .m_axis_dout_tdata(div_R)
);

wire signed [15:0] div_G;
RGB_DIV G_DIV (
    .aclk(clk),
    .s_axis_dividend_tdata(G),
    .s_axis_divisor_tdata(const_255),
    .m_axis_dout_tdata(div_G)
);

wire signed [15:0] div_B;
RGB_DIV B_DIV (
    .aclk(clk),
    .s_axis_dividend_tdata(B),
    .s_axis_divisor_tdata(const_255),
    .m_axis_dout_tdata(div_B)
);

wire signed [9:0] r_01;
assign r_01[9] = 1'b0;
assign r_01[8:0] = div_R[8:0];

wire signed [9:0] g_01;
assign g_01[9] = 1'b0;
assign g_01[8:0] = div_G[8:0];

wire signed [9:0] b_01;
assign b_01[9] = 1'b0;
assign b_01[8:0] = div_B[8:0];

wire signed [19:0] rgb_mux_sub [2:0];
assign rgb_mux_sub[0] = {g_01, b_01};
assign rgb_mux_sub[1] = {b_01, r_01};
assign rgb_mux_sub[2] = {r_01, g_01};


// find max
wire [1:0] idx_max;
wire signed [9:0] max;

find_max max_1 (
    .a(r_01),
    .b(g_01),
    .c(b_01),
    .out(max),
    .index(idx_max)
);

// V = max(R,G,B)
wire signed [9:0] V;
assign V = max;

// find min
wire [1:0] idx_min;
wire signed [9:0] min;

find_min min_1 (
    .a(r_01),
    .b(g_01),
    .c(b_01),
    .out(min),
    .index(idx_min)
);

// calc C
wire signed [10:0] C;
SUB_10_signed Calc_C ( // latency = 1
    .CLK(clk),
    .A(max),
    .B(min),
    .S(C)
);

// calc S
wire signed [9:0] V_delay_S;

delay_line #(
    .N(10),
    .DELAY(1)
) delay_V (
    .clk(clk),
    .idata(V),
    .odata(V_delay_S)
);

wire signed [23:0] div_S;
DIV_S S_DIV ( // latency = 23
    .aclk(clk),
    .s_axis_dividend_tdata(C),
    .s_axis_divisor_tdata(V_delay_S),
    .m_axis_dout_tdata(div_S)
);

// Delay for divide by 0
wire signed [9:0] V_delay_S_18;
delay_line #(
    .N(10),
    .DELAY(23)
) delay_V_18 (
    .clk(clk),
    .idata(V_delay_S),
    .odata(V_delay_S_18)
);

wire signed [9:0] S;
assign S = (V_delay_S_18 > 0) ? {1'b0, div_S[8:0]} : 10'b0;

// calc H
wire signed [10:0] sub_result;
SUB_10_signed H_sub ( // latency = 1
    .CLK(clk),
    .A(rgb_mux_sub[idx_max][19:10]),
    .B(rgb_mux_sub[idx_max][9:0]),
    .S(sub_result)
);

// Divide subtract result by C
wire [7:0] dividend_H;
assign dividend_H = (sub_result[10] == 0) ? sub_result[7:0] : -sub_result[7:0];

wire [7:0] divisor_H;
assign divisor_H = (C[10] == 0) ? C[7:0] : -C[7:0];

wire signed [15:0] div_result_H;
RGB_DIV H_div_C ( // latency = 18
    .aclk(clk),
    .s_axis_dividend_tdata(dividend_H),
    .s_axis_divisor_tdata(divisor_H),
    .m_axis_dout_tdata(div_result_H)
);

// Delay sign for division
wire [1:0] sign_delayed;
delay_line #(
    .N(2),
    .DELAY(18)
) delay_sign (
     .clk(clk),
    .idata({sub_result[10], C[10]}),
    .odata(sign_delayed)
);

// Combine div result and sign
wire signed [8:0] H_result_signed;
assign H_result_signed[8] = sign_delayed[0] ^ sign_delayed[1];
assign H_result_signed[7:0] = (H_result_signed[8] == 0) ? div_result_H[7:0] : ~ div_result_H[7:0];

// Constant for H times 60
wire signed [8:0] const_60_mul;
assign const_60_mul = 9'b000111100;

// Multiply H and 60
wire signed [17:0] mult_h_result; // 8 bit fraction
MULT_H multiply_h ( // latency = 3
    .CLK(clk),
    .A(H_result_signed),
    .B(const_60_mul),
    .P(mult_h_result)
);

// Delay max idx for adding 0 120 or 240
wire [1:0] max_delayed_22;

delay_line #(
    .N(2),
    .DELAY(22)
) delay_max_idx_22 (
    .clk(clk),
    .idata(idx_max),
    .odata(max_delayed_22)
);

// Create mux for adding
wire signed [17:0] mux_add [2:0];
assign mux_add[0] = 18'b0;
assign mux_add[1] = {3'b0, 7'b1111000, 8'b0};
assign mux_add[2] = {2'b0, 8'b11110000, 8'b0};

// Add 0 120 or 240 to H
wire signed [18:0] add_result_h;
adder_mux add_h ( //latency = 2
    .CLK(clk),
    .A(mult_h_result),
    .B(mux_add[max_delayed_22]),
    .S(add_result_h)
);

// Create mux for adding
wire signed [18:0] mux_add_360 [1:0];
assign mux_add_360[0] = 19'b0;
assign mux_add_360[1] = {2'b0,9'b101101000,8'b0};

// Add 360 if H < 0
wire signed [19:0] h_360;
add_360 H_add_360 ( // latency = 2
    .CLK(clk),
    .A(add_result_h),
    .B(mux_add_360[add_result_h[18]]),
    .S(h_360)
);

// Create division 360 constant
wire [18:0] div_360_const;
assign div_360_const = 19'b0010110100000000000;

// Divide H by 360
wire [31:0] div_360_result_H;
DIV_360 H_FIN (
    .aclk(clk),
    .s_axis_dividend_tdata(h_360[18:0]),
    .s_axis_divisor_tdata(div_360_const),
    .m_axis_dout_tdata(div_360_result_H)
);

wire signed [9:0] H;
assign H = {1'b0, div_360_result_H[8:0]};

// Constant for 255 multiply
wire signed [9:0] const_255_mul;
assign const_255_mul = {2'b0, const_255};

// calc H_255
wire signed [19:0] H_prod;
MUL_255 H255 ( // latency = 3
    .CLK(clk),
    .A(H),
    .B(const_255_mul),
    .P(H_prod)
);

wire [7:0] H_255;
assign H_255 = H_prod[15:8];

// calc S_255
wire signed [19:0] S_prod;
MUL_255 S255 ( // latency = 3
    .CLK(clk),
    .A(S),
    .B(const_255_mul),
    .P(S_prod)
);

wire [7:0] S_255;
assign S_255 = S_prod[15:8];

// calc V_255
wire signed [19:0] V_prod;
MUL_255 V255 ( // latency = 3
    .CLK(clk),
    .A(max),
    .B(const_255_mul),
    .P(V_prod)
);

wire [7:0] V_255;
assign V_255 = V_prod[15:8];

// Delay S
wire [7:0] S_255_DELAYED;
delay_line #(
    .N(8),
    .DELAY(31)
) delay_S_255 (
    .clk(clk),
    .idata(S_255),
    .odata(S_255_DELAYED)
);

// Delay V
wire [7:0] V_255_DELAYED;
delay_line #(
    .N(8),
    .DELAY(55)
) delay_V_255 (
    .clk(clk),
    .idata(V_255),
    .odata(V_255_DELAYED)
);

// Delay de, h_sync, v_sync
delay_line #(
    .N(3),
    .DELAY(76)
    ) sync_delay (
    .idata({de_in, h_sync_in, v_sync_in}),
    .clk(clk),
    .odata({de_out, h_sync_out, v_sync_out})
);

assign pixel_HSV = {H_255, S_255_DELAYED, V_255_DELAYED};

endmodule
