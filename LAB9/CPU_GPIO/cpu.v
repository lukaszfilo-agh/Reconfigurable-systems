`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 10:31:25
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input [7:0]gpi,
    output [7:0]gpo
);

reg [7:0] r0 = 0;
reg [7:0] r1 = 0;
reg [7:0] r2 = 0;
reg [7:0] r3 = 0;
reg [7:0] r4 = 0;
reg [7:0] r5 = 0;
reg [7:0] r6 = 0;
reg [7:0] pc = 0;

assign gpo = r4;

// Instr
wire [31:0] instr;
wire [1:0] pc_op = instr[25:24];
wire [1:0] alu_op = instr[21:20];
wire [2:0] rx_op = instr[18:16];
wire imm_op = instr[15];
wire [2:0] ry_op = instr[14:12];
wire rd_op = instr[11];
wire [2:0] d_op = instr[10:8];
wire [7:0] imm = instr[7:0];

//Dekoder
wire [6:0] d_out_mux [6:0];
wire [6:0] d_out;
assign d_out_mux[0] = 7'b1000000;
assign d_out_mux[1] = 7'b0100000;
assign d_out_mux[2] = 7'b0010000;
assign d_out_mux[3] = 7'b0001000;
assign d_out_mux[4] = 7'b0000100;
assign d_out_mux[5] = 7'b0000010;
assign d_out_mux[6] = 7'b0000001;
assign d_out = d_out_mux[d_op];


// RD_MUX
wire [7:0] alu_res;
wire [7:0] data_m_o;
wire [7:0] rd_mux [1:0];
wire [7:0] rd;
assign rd_mux[0] = alu_res;
assign rd_mux[1] = data_m_o;
assign rd = rd_mux[rd_op];

// RX_MUX
wire [7:0] rx_mux [7:0];
wire [7:0] rx;
assign rx_mux[7] = pc;
assign rx_mux[6] = r6;
assign rx_mux[5] = r5;
assign rx_mux[4] = r4;
assign rx_mux[3] = r3;
assign rx_mux[2] = r2;
assign rx_mux[1] = r1;
assign rx_mux[0] = r0;
assign rx = rx_mux[rx_op];

// RY_MUX
wire [7:0] ry_mux [7:0];
wire [7:0] ry;
assign ry_mux[7] = pc;
assign ry_mux[6] = r6;
assign ry_mux[5] = r5;
assign ry_mux[4] = r4;
assign ry_mux[3] = r3;
assign ry_mux[2] = r2;
assign ry_mux[1] = r1;
assign ry_mux[0] = r0;
assign ry = ry_mux[ry_op];

// IMM_MUX
wire [7:0] imm_mux [1:0];
wire [7:0] imm_mux_o;
assign imm_mux[0] = ry;
assign imm_mux[1] = imm;
assign imm_mux_o = imm_mux[imm_op];

//ALU
wire [7:0] and_out;
wire [7:0] add_out;
wire [7:0] zero_out;

alu alu_module(
    .clk(clk),
    .rx(rx), 
    .ry(imm_mux_o), 
    .and_out(and_out),
    .add_out(add_out), 
    .zero_out(zero_out)
);


// ALU_MUX
wire [7:0] alu_mux [3:0];
assign alu_mux[0] = and_out;
assign alu_mux[1] = add_out;
assign alu_mux[2] = zero_out;
assign alu_mux[3] = imm_mux_o;
assign alu_res = alu_mux[alu_op];

// JUMP COND
assign jmp_cond = ((pc_op == 2'b10) && (zero_out == 8'b11111111)) || ((pc_op == 2'b11) && (zero_out == 8'b00000000)) || (pc_op == 2'b01) ? 0 : 1;

// PC_MUX
wire [7:0] pc_mux [1:0];
wire [7:0] pc_mux_out;
assign pc_mux[0] = alu_res;
assign pc_mux[1] = pc + 1;
assign pc_mux_out = pc_mux[jmp_cond];

always @(posedge clk) begin
    case(d_out)
        7'b1000000:r0 <= rd;
        7'b0100000:r1 <= rd;
        7'b0010000:r2 <= rd;
        7'b0001000:r3 <= rd;
        7'b0000100:r4 <= rd;
        7'b0000010:r5 <= rd;
        7'b0000001:r6 <= 0;
    endcase
    pc <= pc_mux_out;
    r5 <= gpi;
end

// pc_addr
i_mem instr_mem(
    .address(pc), 
    .data(instr)
 );

// memory
d_mem data_memory(
    .address(alu_res),
    .data(data_m_o)
 );

endmodule
