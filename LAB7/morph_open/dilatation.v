`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2024 17:35:38
// Design Name: 
// Module Name: dilatation
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


module dilatation #(
    parameter IMG_H = 83
)
(
    input clk,
    input mask,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    output de_out,
    output h_sync_out,
    output v_sync_out, 
    output [23:0] dilatation_out
);

wire context_valid;

wire [7:0] mask_new;

reg [3:0] D11 = 0;
reg [3:0] D12 = 0;
reg [3:0] D13 = 0;
reg [3:0] D14 = 0;
reg [3:0] D15 = 0;

reg [3:0] D21 = 0;
reg [3:0] D22 = 0;
reg [3:0] D23 = 0;
reg [3:0] D24 = 0;
reg [3:0] D25 = 0;

reg [3:0] D31 = 0;
reg [3:0] D32 = 0;
reg [3:0] D33 = 0;
reg [3:0] D34 = 0;
reg [3:0] D35 = 0;

reg [3:0] D41 = 0;
reg [3:0] D42 = 0;
reg [3:0] D43 = 0;
reg [3:0] D44 = 0;
reg [3:0] D45 = 0;

reg [3:0] D51 = 0;
reg [3:0] D52 = 0;
reg [3:0] D53 = 0;
reg [3:0] D54 = 0;
reg [3:0] D55 = 0;

reg [2:0] sum_1 = 0;
reg [2:0] sum_2 = 0;
reg [2:0] sum_3 = 0;
reg [2:0] sum_4 = 0;
reg [2:0] sum_5 = 0;
reg [4:0] sum_all = 0;

wire [15:0] long_data_in;
wire [15:0] long_data_out;

wire [3:0] center_pixel;
wire [3:0] center_pixel_delay;

assign long_data_in = {D15, D25, D35, D45};

delayLinieBRAM_WP long_line (
    .clk(clk),
    .rst(0),
    .ce(1),
    .din(long_data_in),
    .dout(long_data_out),
    .h_size(IMG_H - 5)
);

always @ (posedge clk)
begin
    
    if (context_valid) begin
        sum_1 <= D11[3] + D12[3] + D13[3] + D14[3] + D15[3];
        sum_2 <= D21[3] + D22[3] + D23[3] + D24[3] + D25[3];
        sum_3 <= D31[3] + D32[3] + D33[3] + D34[3] + D35[3];
        sum_4 <= D41[3] + D42[3] + D43[3] + D44[3] + D45[3];
        sum_5 <= D51[3] + D52[3] + D53[3] + D54[3] + D55[3];
        sum_all <= sum_1 + sum_2 + sum_3 + sum_4 + sum_5;
    end
    
    D11 <= {mask, de_in, h_sync_in, v_sync_in};
    D12 <= D11;
    D13 <= D12;
    D14 <= D13;
    D15 <= D14;
    D21 <= long_data_out[15:12];
    D22 <= D21;
    D23 <= D22;
    D24 <= D23;
    D25 <= D24;
    D31 <= long_data_out[11:8];
    D32 <= D31;
    D33 <= D32;
    D34 <= D33;
    D35 <= D34;
    D41 <= long_data_out[7:4];
    D42 <= D41;
    D43 <= D42;
    D44 <= D43;
    D45 <= D44;
    D51 <= long_data_out[3:0];
    D52 <= D51;
    D53 <= D52;
    D54 <= D53;
    D55 <= D54;
end

assign context_valid = D11[2] & D12[2] & D13[2] & D14[2] & D15[2] & D21[2] & D22[2] & D23[2] & D24[2] & D25[2] & D31[2] & D32[2] & D33[2] & D34[2] & D35[2] & D41[2] & D42[2] & D43[2] & D44[2] & D45[2] & D51[2] & D52[2] & D53[2] & D54[2] & D55[2];

assign center_pixel = {context_valid, D33[2], D33[1], D33[0]};


delay_line #(
    .N(4),
    .DELAY(2)
)  delay_center_pixel (
    .clk(clk),
    .idata(center_pixel),
    .odata(center_pixel_delay)
);

assign mask_new = (sum_all > 5'd0 ? 255 : 0);

assign dilatation_out = center_pixel_delay[3] == 1 ? {mask_new,mask_new,mask_new} : 23'b0;

assign de_out = center_pixel_delay[2];
assign h_sync_out = center_pixel_delay[1];
assign v_sync_out = center_pixel_delay[0];

endmodule
