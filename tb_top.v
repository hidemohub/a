`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 23:28:22
// Design Name: 
// Module Name: tb_top
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

//~ `New testbench
`timescale  1ns / 1ps

module tb_top;

// top Parameters
parameter PERIOD  = 20;


// top Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [11:0]  ad1_in                       = 0 ;
reg   key                                  = 0 ;

// top Outputs
wire  clk_65m_1                            ;
wire  [13:0]  DataA                        ;
wire  ClkA                                 ;
wire  WRTA                                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end


reg [12:0] addr;
wire [11:0] adc_1;
integer i = 0;
rom   rom(
  .a(addr),        // input wire [12 : 0] a
  .clk(clk),    // input wire clk
  .qspo(adc_1)  // output wire [11 : 0] qspo
);

top  u_top (
    .clk                     ( clk               ),
    .rst_n                   ( rst_n             ),
    .ad1_in                  ( adc_1            ),
    .key                     ( key               ),

    .clk_65m_1               ( clk_65m_1         ),
    .DataA                   ( DataA             ),
    .ClkA                    ( ClkA              ),
    .WRTA                    ( WRTA              )
);

initial begin
addr = 0;

repeat(100)begin
for(i=0;i<8192;i=i+1)begin
addr = addr + 1'b1;
#62.5;
end
end

$finish;
end




initial begin
rst_n = 0;
#100;
rst_n = 1;
#201;

key = 1;
#1000;
key = 0;
#1000;
end

endmodule