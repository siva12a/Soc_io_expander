`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2021 15:29:26
// Design Name: 
// Module Name: wishbone2apb
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


module wishbone2apb(
    input            wb_clk_i,
    input            wb_rst_i,
    input            wbs_stb_i,
    input            wbs_cyc_i,
    input            wbs_we_i,
    input [3:0]      wbs_sel_i,
    input [31:0]     wbs_dat_i,
    input [31:0]     wbs_adr_i,
    
    output           wbs_ack_o,
    output [31:0]    wbs_dat_o,
    
    output   [31:0]  s_apb_addr  ,
    output           s_apb_sel   ,
    output           s_apb_write ,
    output           s_apb_ena   ,
    output   [31:0]  s_apb_wdata ,
    output   [3:0]   s_apb_pstb  ,
    
    input    [31:0]  s_apb_rdata ,
    input            s_apb_rready
    
    );
    
    assign s_apb_addr  = wbs_adr_i;
    assign s_apb_write = wbs_we_i;
    assign s_apb_pstb  = wbs_sel_i;
    assign s_apb_wdata = wbs_dat_i;
    assign wbs_dat_o   = s_apb_rdata;
    
    wire   valid;
    assign valid = wbs_stb_i && wbs_cyc_i;
    assign s_apb_sel = valid;
    
    reg penable;
    assign wbs_ack_o = penable;
    assign s_apb_ena = penable;
    
    always @(posedge wb_clk_i ) begin
        if(wb_rst_i) begin
            penable <= 1'b0;
        end else begin
            penable <= valid ? !penable ? 1'b1 : 1'b0 : 1'b0;
        end
    
    
    
    end
    
    
    
    
    
    
    
endmodule
