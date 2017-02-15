`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2016 14:11:12
// Design Name: 
// Module Name: clk_div
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


// decreasing the clock frequency to 190Hz
module clk_div 
#(parameter N = 19)
(  
    input wire mclk ,
    output wire clk 
);
reg [N-1:0] q; // 19-bit counter

always @(posedge mclk) begin
	    q <= q + 1;
end

assign clk = q[N-1];

endmodule
