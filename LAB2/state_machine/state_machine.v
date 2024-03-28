`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 11:54:45 AM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input clk,
    input rst,
    input send,
    input [7:0] data,
    output txd
    );
    
localparam STATE0 = 2'd0;
localparam STATE1 = 2'd1;
localparam STATE2 = 2'd2;
localparam STATE3 = 2'd3;

reg [1:0] state = STATE0;
reg [7:0] data_reg = 0;
reg send_mem = 0;
reg txd_r = 0;
reg [2:0] cnt = 0;


always @(posedge clk) begin
    if(rst) begin 
        state <= STATE0;
        cnt <= 0;
    end
    else begin
        case(state)
        
            STATE0:
            begin
                if (send & ~send_mem) begin
                    data_reg <= data;
                    state <= STATE1;
                end
                
            end
            
            STATE1:
            begin
                txd_r <= 1;
                state <= STATE2;
            end
            
            STATE2:
            begin
                if (cnt == 7) begin
                    txd_r <= data_reg[cnt];
                    cnt <= 0;
                    state <= STATE3;
                end
                else begin
                    txd_r <= data_reg[cnt];
                    cnt <= cnt + 1;
                end
            end
            
            STATE3:
            begin
                txd_r <= 0;
                state <= STATE0;
            end
            
        endcase
		send_mem <= send;
    end
end

assign txd = txd_r;
    
endmodule
