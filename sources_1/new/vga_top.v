`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2016 14:40:45
// Design Name: 
// Module Name: vga_top
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


module vga_top(
    input clk, 
    input [1:0] sw,
    input [1:0] btn,
//    input [2:0] RGB, obj_select,
    input up_sw, down_sw, up_sw1, down_sw1,
    output hsync, vsync,
    output [3:0] red, green, blue,
//    output [3:0] hit_count_reg,
//    output refr_tick, 
//    output [3:0] hit_count, //game_stop
//    output [3:0] sq_veloc
    output [7:0] led_out
);

wire clk_pixel, clk190, clk1, clr, vidon, locked;
wire [16:0] hc, vc;
wire startd, startp;
    
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

//vga_pong obj3(
//    .clr(clr),
//    .clk_pixel(clk_pixel),
//    .clk1(clk1),
//    .vidon(vidon),
//    .game_start(startp),
//    .game_on(sw[0]),
//    .up_sw(up_sw),
//    .down_sw(down_sw),
////    .RGB(RGB),
////    .obj_select(obj_select),
//    .hc(hc),
//    .vc(vc),
////    .led_out(led_out),
////    .hit_count_outp(led_out[3:0]),
////    .sq_veloc(led_out[7:4]),
////    .blue_wall_reg(led_out[3:0]),
////    .blue_wall_next(led_out[7:4]),
//    .red(red),
//    .green(green),
//    .blue(blue),
//    .one_score_outp(led_out[3:0]),
//    .sq_velocity_outp(led_out[7:4])
//);

vga_multiplayer obj3(
    .clr(clr),
    .clk_pixel(clk_pixel),
    .clk1(clk1),
    .vidon(vidon),
    .game_start(startp),
    .game_on(sw),
    .up_sw(up_sw),
    .down_sw(down_sw),
    .up_sw1(up_sw1),
    .down_sw1(down_sw1),
    .hc(hc),
    .vc(vc),
    .red(red),
    .green(green),
    .blue(blue),
    .one_score_outp(led_out[3:0]),
    .sq_velocity_outp(led_out[7:4])
);

clk_div obj4(
    .mclk(clk_pixel),
    .clk(clk190)
);

debounce obj5(
    .inp(btn[1]),
    .clk(clk190),
    .outp(startd)
);

clk_pulse obj6(
    .inp(startd),
    .cclk(clk190),
    .outp(startp)
);

clk_div #(.N(26))
obj7 (
    .mclk(clk_pixel),
    .clk(clk1)
);

endmodule
