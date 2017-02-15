`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2016 14:41:00
// Design Name: 
// Module Name: top
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


module top(
    input clk, 
    input [0:0] btn,
    output wire hsync, vsync,
    output wire [3:0] red, green, blue
    );
    
wire clk_pixel, clr, vidon, locked;
wire [16:0] hc, vc;
assign clr = btn[0];

vga_ctrl obj1(
    .clk(clk_pixel),
    .clr(clr),
    .hsync(hsync),
    .vsync(vsync),
    .hc(hc),
    .vc(vc),
    .vidon(vidon)
);

clock_wrapper obj2(
    .clk100M(clk),
    .clk65M(clk_pixel),
    .locked(locked),
    .reset(clr)
);

//vga_wall obj3(
//    .vidon(vidon),
//    .red(red),
//    .green(green),
//    .blue(blue)
//);

assign red = vidon ? 15 : 0;
assign blue = vidon ? 15 : 0;
assign green = vidon ? 15 : 0;
    
endmodule
