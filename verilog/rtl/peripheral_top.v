`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2021 21:24:31
// Design Name: 
// Module Name: peripheral_top
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


module peripheral_top(

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


// gpio
    input  [31:0]    gpi,
    output [31:0]    gpo,
    output [31:0]    gpio_oe,
    
    output           hb_o
  
    );
 
wire clock;
assign clock = wb_clk_i;

 wire rst;
 assign rst = wb_rst_i;
 assign hb_o = 1'b1;
 


wire [31:0]   gpio_apb_addr   ;
wire          gpio_apb_sel    ;
wire          gpio_apb_write  ;
wire          gpio_apb_ena    ;
wire [31:0]   gpio_apb_wdata  ;
wire [31:0]   gpio_apb_rdata  ;
wire [3:0]    gpio_apb_pstb   ;




wire   [31:0]  peripheral_apb_addr  ;  
wire           peripheral_apb_sel   ;  
wire           peripheral_apb_write ;  
wire           peripheral_apb_ena   ;  
wire   [31:0]  peripheral_apb_wdata ;  
wire   [3:0]   peripheral_apb_pstb  ;  
wire   [31:0]  peripheral_apb_rdata ;



 
wishbone2apb  u_wishbone2apb (
.wb_clk_i      (wb_clk_i ),
.wb_rst_i      (wb_rst_i ),
.wbs_stb_i     (wbs_stb_i),
.wbs_cyc_i     (wbs_cyc_i),
.wbs_we_i      (wbs_we_i ),
.wbs_sel_i     (wbs_sel_i),
.wbs_dat_i     (wbs_dat_i),
.wbs_adr_i     (wbs_adr_i),
              
.wbs_ack_o     (wbs_ack_o), 
.wbs_dat_o     (wbs_dat_o),
              
.s_apb_addr    (peripheral_apb_addr  ),
.s_apb_sel     (peripheral_apb_sel   ),
.s_apb_write   (peripheral_apb_write ),
.s_apb_ena     (peripheral_apb_ena   ),
.s_apb_wdata   (peripheral_apb_wdata ),
.s_apb_pstb    (peripheral_apb_pstb  ),
              
.s_apb_rdata   (peripheral_apb_rdata),
.s_apb_rready  (1'b1)
);
 

gpio_ssp u_gpio_ssp (

.clock       (clock),
.rst         (rst),
.apb_addr    (peripheral_apb_addr  ),
.apb_sel     (peripheral_apb_sel   ),
.apb_write   (peripheral_apb_write ),
.apb_ena     (peripheral_apb_ena   ),
.apb_wdata   (peripheral_apb_wdata ),
.apb_rdata   (peripheral_apb_rdata ),
.apb_pstb    (peripheral_apb_pstb  ),
.apb_rready  (),

            
.gpi         (gpi    ),
.gpo         (gpo    ),
.gpio_oe     (gpio_oe)

);


 
 
 endmodule
