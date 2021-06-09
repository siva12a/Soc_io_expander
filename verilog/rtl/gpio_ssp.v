`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2021 13:03:24
// Design Name: gpio with apb interface
// Module Name: gpio
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


module gpio_ssp(
    input              clock,
    input              rst,
    input  [31:0]      apb_addr,
    input              apb_sel,
    input              apb_write,
    input              apb_ena,
    input  [31:0]      apb_wdata,
    output reg [31:0]  apb_rdata,
    input  [3:0]       apb_pstb,
    output             apb_rready,
   // output             gpio_intr,
    
    input  [31:0]      gpi,
    output [31:0]      gpo,
    output [31:0]      gpio_oe
    
     
    
    );
    
    localparam GPO_ADDR    = 8'h00;
    localparam GPI_ADDR    = 8'h04;
    localparam GPID_ADDR   = 8'h0C;
    
    
    reg [31:0] gpio_0_s;
    reg [31:0] gpiod;
    assign apb_rready = 1'b1;
    
    assign gpio_oe    = gpiod; 
    
    assign gpo = gpio_0_s;
    
    
    
    
     
    always @(posedge clock) begin 
        if(rst) begin
        
            gpio_0_s   <= 32'h000000000;
            apb_rdata  <= 32'h0000_0000;
            gpiod      <= 32'hF0000000;
        
        end else begin
        
            if(apb_sel && apb_write && !apb_ena) begin 
                case(apb_addr[7:0]) 
                            GPO_ADDR     : begin gpio_0_s  <= apb_wdata;end
                            GPID_ADDR    : begin gpiod    <=  apb_wdata ;end
                            
                 endcase        
              end
              
             if(apb_sel && !apb_write && !apb_ena) begin 
                    case(apb_addr[7:0]) 
                            GPO_ADDR     : begin apb_rdata  <= gpio_0_s ;end
                            GPID_ADDR    : begin apb_rdata  <= gpiod; end
                            GPI_ADDR     : begin apb_rdata  <= gpi; end
                            default      : begin apb_rdata  <= apb_rdata  <= 32'h0000_0000; end
                    endcase      
                            
            end            
            
              
              
              
              
              
             
        
        end
    
    end
    
    
    
    
    
    
    
    
    
    
endmodule
