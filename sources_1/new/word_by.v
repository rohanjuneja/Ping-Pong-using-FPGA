`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2016 13:28:25
// Design Name: 
// Module Name: font_words
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


module word_by(
    input [4:0] drom_addr_num,
    output reg [0:63] drom_data_num
);

always @(*)
    begin
	    case (drom_addr_num)
            0:drom_data_num = 64'b0111111111111111111111111110000001000000000000000000000000000010;
            1:drom_data_num = 64'b0100000000000000000000000001000001000000000000000000000000000010;
            2:drom_data_num = 64'b0100000000000000000000000000100001000000000000000000000000000010;
            3:drom_data_num = 64'b0100000000000000000000000000010001000000000000000000000000000010;
            4:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
            5:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
            6:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
            7:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
            8:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
            9:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
           10:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
           11:drom_data_num = 64'b0100000000000000000000000000001001000000000000000000000000000010;
           12:drom_data_num = 64'b0100000000000000000000000000010001000000000000000000000000000010;
           13:drom_data_num = 64'b0100000000000000000000000000100001000000000000000000000000000010;
           14:drom_data_num = 64'b0100000000000000000000000001000000100000000000000000000000000100;
           15:drom_data_num = 64'b0111111111111111111111111110000000011111111111111111111111111000;
           16:drom_data_num = 64'b0100000000000000000000000001000000000000000000010000000000000000;
           17:drom_data_num = 64'b0100000000000000000000000000100000000000000000010000000000000000;
           18:drom_data_num = 64'b0100000000000000000000000000010000000000000000010000000000000000;
           19:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           20:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           21:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           22:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           23:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           24:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           25:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           26:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           27:drom_data_num = 64'b0100000000000000000000000000001000000000000000010000000000000000;
           28:drom_data_num = 64'b0100000000000000000000000000010000000000000000010000000000000000;
           29:drom_data_num = 64'b0100000000000000000000000000100000000000000000010000000000000000;
           30:drom_data_num = 64'b0100000000000000000000000001000000000000000000010000000000000000;
           31:drom_data_num = 64'b0111111111111111111111111110000000000000000000010000000000000000;
        endcase
    end

endmodule