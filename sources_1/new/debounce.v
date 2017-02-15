`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2016 14:02:50
// Design Name: 
// Module Name: debounce
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

// debouncing the input with each pushbutton press
module debounce(
    input wire inp,
    input wire clk,
    output wire outp
);

reg delay1, delay2, delay3;

always @(posedge clk) begin
    delay1 <= inp;
    delay2 <= delay1;
    delay3 <= delay2;
end

assign outp = delay1 & delay2 & delay3;

endmodule
