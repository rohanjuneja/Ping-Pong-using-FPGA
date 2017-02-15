`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2016 12:33:48
// Design Name: 
// Module Name: bcd
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


module bcd(
    input [5:0] inp,
    output reg [3:0] tens,
    output reg [3:0] ones
);
    
    integer i;
    reg [5:0] temp;
    
    always @(*)
    begin
        {tens, ones} = 8'd0;
        temp = inp;
        for(i=0 ; i<6; i=i+1)
        begin 
            if(tens > 4'd4)
                tens = tens + 4'd3;
            if(ones > 4'd4)
                ones = ones + 4'd3;
            {tens, ones, temp} = {tens, ones, temp} << 1;
        end
    end
endmodule