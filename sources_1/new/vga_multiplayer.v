`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2016 14:42:29
// Design Name: 
// Module Name: vga_pong
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


module vga_multiplayer(
    input clr, clk_pixel, clk1, vidon,
    input [1:0] game_on, 
    input game_start, up_sw, down_sw, up_sw1, down_sw1,
    input [16:0] hc, vc,
//    input [2:0] RGB, obj_select,
    output reg [3:0] red, green, blue,
    output [3:0] one_score_outp, sq_velocity_outp
//    output reg [3:0] hit_count_outp, 
//    output wire [3:0] sq_veloc
);

//reg [3:0] hit_count_outp;

assign one_score_outp[0] = two_score_reg[0];//one_score_reg[0];
assign one_score_outp[1] = two_score_reg[1];//one_score_reg[1];
assign one_score_outp[2] = two_score_reg[2];//one_score_reg[2];
assign one_score_outp[3] = two_score_reg[3];//one_score_reg[3];

assign sq_velocity_outp[0] = hit_count1;//sq_velocity_reg[0];
assign sq_velocity_outp[1] = hit_count;//sq_velocity_reg[1];
assign sq_velocity_outp[2] = hit_count1;//sq_velocity_reg[2];
assign sq_velocity_outp[3] = hit_count;//sq_velocity_reg[3];

//always @(posedge clk_pixel) begin
//    if(clr == 1)
//        hit_count_outp = 0;
//    else if((hit_count == 1) && (refr_tick == 1)) 
//        hit_count_outp = hit_count_outp + 4'd1;
//end
    
parameter hpixels = 1344;
parameter vlines = 806;
parameter hbp = 296;
parameter hfp = 1320;
parameter vbp = 35;
parameter vfp = 803;
parameter hsp = 136;
parameter vsp = 6;

parameter hscreen = 1024;
parameter vscreen = 768;

parameter wall_x_left = 50;
parameter wall_x_right = 100;
reg wall_on;

wire hit_count;
reg [16:0] hit_count_sq_reg, hit_count_sq_next, hit_count_bar_reg, hit_count_bar_next;
wire hit_count1;
reg [16:0] hit_count1_sq_reg, hit_count1_sq_next, hit_count1_bar_reg, hit_count1_bar_next;

parameter sq_size = 32;
parameter velocity_sq_default = 3;
parameter sq_x_start = 200;
parameter sq_y_start = 200;
reg [16:0] sq_velocity_reg, sq_velocity_next;
wire [16:0] sq_xstart, sq_ystart;
reg [16:0] sq_xstart_reg, sq_ystart_reg, sq_xstart_next, sq_ystart_next;
reg [16:0] sq_xstart_delta_reg, sq_ystart_delta_reg, sq_xstart_delta_next, sq_ystart_delta_next;
reg sq_on;

reg [16:0] hit_count_sq1_reg, hit_count_sq1_next;
wire hit_count1;
reg [16:0] hit_count1_sq1_reg, hit_count1_sq1_next;

parameter sq1_size = 32;
parameter velocity_sq1_default = 3;
parameter sq1_x_start = 825;
parameter sq1_y_start = 568;
reg [16:0] sq1_velocity_reg, sq1_velocity_next;
wire [16:0] sq1_xstart, sq1_ystart;
reg [16:0] sq1_xstart_reg, sq1_ystart_reg, sq1_xstart_next, sq1_ystart_next;
reg [16:0] sq1_xstart_delta_reg, sq1_ystart_delta_reg, sq1_xstart_delta_next, sq1_ystart_delta_next;
reg sq1_on;

reg game_stop, game_win;

wire refr_tick;
assign refr_tick = ((vc==0) && (hc==0));

parameter velocity_bar_default = 4;
parameter bar_x_left = 900;
parameter bar_size_default = 200;
parameter bar_y_start = 200;
parameter bar_width = 1;
wire [16:0] bar_ystart;
reg [16:0] bar_xstart_reg, bar_xstart_next, bar_ystart_reg, bar_ystart_next;
reg [16:0] bar_ystart_delta_reg, bar_ystart_delta_next;
reg [16:0] bar_size_reg, bar_size_next;
reg bar_on;

parameter velocity_bar1_default = 4;
parameter bar1_x_left = 125;
parameter bar1_size_default = 200;
parameter bar1_y_start = 200;
parameter bar1_width = 1;
wire [16:0] bar1_ystart;
reg [16:0] bar1_xstart_reg, bar1_xstart_next, bar1_ystart_reg, bar1_ystart_next;
reg [16:0] bar1_ystart_delta_reg, bar1_ystart_delta_next;
reg [16:0] bar1_size_reg, bar1_size_next;
reg bar1_on;

reg [16:0] one_score_reg, one_score_next;
reg [16:0] two_score_reg, two_score_next;

/*always @(*) begin
    if((hc >= wall_x_left + hbp) && (hc < wall_x_right + hbp))
        wall_on = 1;
    else
        wall_on = 0;
end*/

always @(*) begin
    if((hc >= sq_xstart + hbp) && (hc < sq_xstart + sq_size + hbp) && (vc >= sq_ystart + vbp) && (vc < sq_ystart + sq_size + vbp))
        sq_on = 1;
    else
        sq_on = 0;
end

assign sq_xstart = sq_xstart_reg;
assign sq_ystart = sq_ystart_reg;

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        sq_xstart_reg <= sq_x_start;
        sq_ystart_reg <= sq_y_start;
    end
    else begin
        sq_xstart_reg <= sq_xstart_next;
        sq_ystart_reg <= sq_ystart_next;
    end
end

always @(*) begin
    sq_xstart_next = sq_xstart_reg;
    if(game_stop == 1)
        sq_xstart_next = sq_x_start;
    else if(refr_tick == 1)
        sq_xstart_next = sq_xstart_reg + sq_xstart_delta_reg;
end

always @(*) begin
    sq_ystart_next = sq_ystart_reg;
    if(game_stop == 1)
        sq_ystart_next = sq_y_start;
    else if(refr_tick == 1)
        sq_ystart_next = sq_ystart_reg + sq_ystart_delta_reg;
end

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        sq_xstart_delta_reg <= 0;
        sq_ystart_delta_reg <= 0;
    end
    else begin
        sq_xstart_delta_reg <= sq_xstart_delta_next;
        sq_ystart_delta_reg <= sq_ystart_delta_next;
    end
end

//wire [3:0] temp_velocity;
//assign temp_velocity = (sq_velocity_reg >> 1);

always @(*) begin
    sq_xstart_delta_next = sq_xstart_delta_reg;
//    if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size) && (sq_xstart + sq_size >= bar_x_right + temp_velocity) && (sq_xstart < bar_x_left - temp_velocity + 1))
//        sq_xstart_delta_next = -sq_xstart_delta_reg;
    
//    if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size_reg) && (sq_xstart + sq_size >= bar_xstart_reg - temp_velocity) && (sq_xstart + sq_size < bar_xstart_reg + bar_width + temp_velocity + 1))
//        sq_xstart_delta_next = -sq_velocity_reg;
    if ((sq_xstart + sq_size >= bar_xstart_reg) && (~((sq_ystart > bar_ystart + bar_size_reg) || (sq_ystart + sq_size < bar_ystart))))
        sq_xstart_delta_next = -sq_velocity_reg;
    else if ((sq_xstart <= bar1_xstart_reg + bar1_width) && (~((sq_ystart > bar1_ystart + bar1_size_reg) || (sq_ystart + sq_size < bar1_ystart))))
        sq_xstart_delta_next = sq_velocity_reg;
//    else if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size_reg) && (sq_xstart < bar_xstart_reg + bar_width + temp_velocity + 1) && (sq_xstart >= bar_xstart_reg - temp_velocity))
//        sq_xstart_delta_next = sq_velocity_reg;

//    else if(sq_xstart <= wall_x_right)
//        sq_xstart_delta_next = sq_velocity_reg;

    else if((sq_xstart + sq_size > sq1_xstart) && (sq_xstart + sq_size < sq1_xstart + sq1_size) && (sq_ystart + sq_size > sq1_ystart) && (sq_ystart + sq_size < sq1_ystart + sq1_size))
        sq_xstart_delta_next = -sq_velocity_reg;
    else if((sq_xstart + sq_size > sq1_xstart) && (sq_xstart + sq_size < sq1_xstart + sq1_size) && (sq_ystart < sq1_ystart + sq1_size) && (sq_ystart > sq1_ystart))
        sq_xstart_delta_next = -sq_velocity_reg;
    else if((sq_xstart < sq1_xstart + sq1_size) && (sq_xstart > sq1_xstart) && (sq_ystart + sq_size > sq1_ystart) && (sq_ystart +sq_size < sq1_ystart + sq1_size))
        sq_xstart_delta_next = sq_velocity_reg;
    else if((sq_xstart < sq1_xstart + sq1_size) && (sq_xstart > sq1_xstart) && (sq_ystart < sq1_ystart + sq1_size) && (sq_ystart > sq1_ystart))
        sq_xstart_delta_next = sq_velocity_reg;

//    else if(sq_xstart >= hfp - hbp - sq_size)
//        sq_xstart_delta_next = -sq_velocity_reg;
    else if (sq_velocity_reg >  sq_xstart_delta_reg)
        sq_xstart_delta_next = sq_velocity_reg;
    else if(game_stop == 1 || game_start == 1)
        sq_xstart_delta_next = velocity_sq_default;
end

always @(*) begin
    sq_ystart_delta_next = sq_ystart_delta_reg;
    if(sq_ystart <= 8)
        sq_ystart_delta_next = sq_velocity_reg;
    else if(sq_ystart > vfp - vbp - sq_size)
        sq_ystart_delta_next = -sq_velocity_reg;
    else if((sq_xstart + sq_size > sq1_xstart) && (sq_xstart + sq_size < sq1_xstart + sq1_size) && (sq_ystart + sq_size > sq1_ystart) && (sq_ystart + sq_size < sq1_ystart + sq1_size))
        sq_ystart_delta_next = -sq_velocity_reg;
    else if((sq_xstart + sq_size > sq1_xstart) && (sq_xstart + sq_size < sq1_xstart + sq1_size) && (sq_ystart < sq1_ystart + sq1_size) && (sq_ystart > sq1_ystart))
        sq_ystart_delta_next = sq_velocity_reg;
    else if((sq_xstart < sq1_xstart + sq1_size) && (sq_xstart > sq1_xstart) && (sq_ystart + sq_size > sq1_ystart) && (sq_ystart +sq_size < sq1_ystart + sq1_size))
        sq_ystart_delta_next = -sq_velocity_reg;
    else if((sq_xstart < sq1_xstart + sq1_size) && (sq_xstart > sq1_xstart) && (sq_ystart < sq1_ystart + sq1_size) && (sq_ystart > sq1_ystart))
        sq_ystart_delta_next = sq_velocity_reg;
    else if(game_stop == 1 || game_start == 1)
        sq_ystart_delta_next = -velocity_sq_default;
end

//sq1
always @(*) begin
    if((hc >= sq1_xstart + hbp) && (hc < sq1_xstart + sq1_size + hbp) && (vc >= sq1_ystart + vbp) && (vc < sq1_ystart + sq1_size + vbp))
        sq1_on = 1;
    else
        sq1_on = 0;
end

assign sq1_xstart = sq1_xstart_reg;
assign sq1_ystart = sq1_ystart_reg;

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        sq1_xstart_reg <= sq1_x_start;
        sq1_ystart_reg <= sq1_y_start;
    end
    else begin
        sq1_xstart_reg <= sq1_xstart_next;
        sq1_ystart_reg <= sq1_ystart_next;
    end
end

always @(*) begin
    sq1_xstart_next = sq1_xstart_reg;
    if(game_stop == 1)
        sq1_xstart_next = sq1_x_start;
    else if(refr_tick == 1)
        sq1_xstart_next = sq1_xstart_reg + sq1_xstart_delta_reg;
end

always @(*) begin
    sq1_ystart_next = sq1_ystart_reg;
    if(game_stop == 1)
        sq1_ystart_next = sq1_y_start;
    else if(refr_tick == 1)
        sq1_ystart_next = sq1_ystart_reg + sq1_ystart_delta_reg;
end

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        sq1_xstart_delta_reg <= 0;
        sq1_ystart_delta_reg <= 0;
    end
    else begin
        sq1_xstart_delta_reg <= sq1_xstart_delta_next;
        sq1_ystart_delta_reg <= sq1_ystart_delta_next;
    end
end

always @(*) begin
    sq1_xstart_delta_next = sq1_xstart_delta_reg;
//    if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size) && (sq_xstart + sq_size >= bar_x_right + temp_velocity) && (sq_xstart < bar_x_left - temp_velocity + 1))
//        sq_xstart_delta_next = -sq_xstart_delta_reg;
    
//    if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size_reg) && (sq_xstart + sq_size >= bar_xstart_reg - temp_velocity) && (sq_xstart + sq_size < bar_xstart_reg + bar_width + temp_velocity + 1))
//        sq_xstart_delta_next = -sq_velocity_reg;
    if ((sq1_xstart + sq1_size >= bar_xstart_reg) && (~((sq1_ystart > bar_ystart + bar_size_reg) || (sq1_ystart + sq1_size < bar_ystart))))
        sq1_xstart_delta_next = -sq1_velocity_reg;
    else if ((sq1_xstart <= bar1_xstart_reg + bar1_width) && (~((sq1_ystart > bar1_ystart + bar1_size_reg) || (sq1_ystart + sq1_size < bar1_ystart))))
        sq1_xstart_delta_next = sq1_velocity_reg;
//    else if((sq_ystart + sq_size >= bar_ystart) && (sq_ystart < bar_ystart + bar_size_reg) && (sq_xstart < bar_xstart_reg + bar_width + temp_velocity + 1) && (sq_xstart >= bar_xstart_reg - temp_velocity))
//        sq_xstart_delta_next = sq_velocity_reg;

//    else if(sq1_xstart <= wall_x_right)
//        sq1_xstart_delta_next = sq1_velocity_reg;

    else if((sq1_xstart + sq1_size > sq_xstart) && (sq1_xstart + sq1_size < sq_xstart + sq_size) && (sq1_ystart + sq1_size > sq_ystart) && (sq1_ystart + sq1_size < sq_ystart + sq_size))
        sq1_xstart_delta_next = -sq1_velocity_reg;
    else if((sq1_xstart + sq1_size > sq_xstart) && (sq1_xstart + sq1_size < sq_xstart + sq_size) && (sq1_ystart < sq_ystart + sq_size) && (sq1_ystart > sq_ystart))
        sq1_xstart_delta_next = -sq1_velocity_reg;
    else if((sq1_xstart < sq_xstart + sq_size) && (sq1_xstart > sq_xstart) && (sq1_ystart + sq1_size > sq_ystart) && (sq1_ystart + sq1_size < sq_ystart + sq_size))
        sq1_xstart_delta_next = sq1_velocity_reg;
    else if((sq1_xstart < sq_xstart + sq_size) && (sq1_xstart > sq_xstart) && (sq1_ystart < sq_ystart + sq_size) && (sq1_ystart > sq_ystart))
        sq1_xstart_delta_next = sq1_velocity_reg;
    
//    else if(sq_xstart >= hfp - hbp - sq_size)
//        sq_xstart_delta_next = -sq_velocity_reg;
    else if (sq1_velocity_reg >  sq1_xstart_delta_reg)
        sq1_xstart_delta_next = sq1_velocity_reg;
    else if(game_stop == 1 || game_start == 1)
        sq1_xstart_delta_next = -velocity_sq1_default;
end

always @(*) begin
    sq1_ystart_delta_next = sq1_ystart_delta_reg;
    if(sq1_ystart <= 8)
        sq1_ystart_delta_next = sq1_velocity_reg;
    else if(sq1_ystart > vfp - vbp - sq1_size)
        sq1_ystart_delta_next = -sq1_velocity_reg;
    else if((sq1_xstart + sq1_size > sq_xstart) && (sq1_xstart + sq1_size < sq_xstart + sq_size) && (sq1_ystart + sq1_size > sq_ystart) && (sq1_ystart + sq1_size < sq_ystart + sq_size))
        sq1_ystart_delta_next = -sq1_velocity_reg;
    else if((sq1_xstart + sq1_size > sq_xstart) && (sq1_xstart + sq1_size < sq_xstart + sq_size) && (sq1_ystart < sq_ystart + sq_size) && (sq1_ystart > sq_ystart))
        sq1_ystart_delta_next = sq1_velocity_reg;
    else if((sq1_xstart < sq_xstart + sq_size) && (sq1_xstart > sq_xstart) && (sq1_ystart + sq1_size > sq_ystart) && (sq1_ystart + sq1_size < sq_ystart + sq_size))
        sq1_ystart_delta_next = -sq1_velocity_reg;
    else if((sq1_xstart < sq_xstart + sq_size) && (sq1_xstart > sq_xstart) && (sq1_ystart < sq_ystart + sq_size) && (sq1_ystart > sq_ystart))
        sq1_ystart_delta_next = sq1_velocity_reg;
    else if(game_stop == 1 || game_start == 1)
        sq1_ystart_delta_next = velocity_sq1_default;
end

// Bar
always @(*) begin
    if((hc >= bar_xstart_reg + hbp) && (hc < bar_xstart_reg + bar_width + hbp) && (vc >= bar_ystart + vbp) && (vc < bar_ystart + bar_size_reg + vbp))
        bar_on = 1;
    else
        bar_on = 0;
end

always @(*) begin
    if((hc >= bar1_xstart_reg + hbp) && (hc < bar1_xstart_reg + bar1_width + hbp) && (vc >= bar1_ystart + vbp) && (vc < bar1_ystart + bar1_size_reg + vbp))
        bar1_on = 1;
    else
        bar1_on = 0;
end

//Movement of the bar
assign bar_ystart = bar_ystart_reg;

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar_ystart_reg <= bar_y_start;
    else
        bar_ystart_reg <= bar_ystart_next;
end

always @(*) begin
    if(clr == 1)
        bar_ystart_next = bar_y_start;
    else if(refr_tick == 1)
        bar_ystart_next = bar_ystart_reg + bar_ystart_delta_reg;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar_ystart_delta_reg <= velocity_bar_default;
    else
        bar_ystart_delta_reg <= bar_ystart_delta_next;
end

always @(*) begin
    bar_ystart_delta_next = bar_ystart_delta_reg;
//    if((bar_ystart <= velocity_bar_default) || (bar_ystart > vfp - vbp - bar_size))
//        bar_ystart_delta_next = 0;
//    else if(bar_ystart > vfp - vbp - bar_size)
    if((up_sw == 1) && (bar_ystart > velocity_bar_default))
        bar_ystart_delta_next = -velocity_bar_default;
    else if((down_sw == 1) && ((bar_ystart < vfp - vbp - bar_size_reg)))
        bar_ystart_delta_next = velocity_bar_default;
    else
        bar_ystart_delta_next = 0;
end

//Movement of bar1
assign bar1_ystart = bar1_ystart_reg;

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar1_ystart_reg <= bar1_y_start;
    else
        bar1_ystart_reg <= bar1_ystart_next;
end

always @(*) begin
    if(clr == 1)
        bar1_ystart_next = bar1_y_start;
    else if(refr_tick == 1)
        bar1_ystart_next = bar1_ystart_reg + bar1_ystart_delta_reg;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar1_ystart_delta_reg <= velocity_bar1_default;
    else
        bar1_ystart_delta_reg <= bar1_ystart_delta_next;
end

always @(*) begin
    bar1_ystart_delta_next = bar1_ystart_delta_reg;
//    if((bar_ystart <= velocity_bar_default) || (bar_ystart > vfp - vbp - bar_size))
//        bar_ystart_delta_next = 0;
//    else if(bar_ystart > vfp - vbp - bar_size)
    if((up_sw1 == 1) && (bar1_ystart > velocity_bar1_default))
        bar1_ystart_delta_next = -velocity_bar1_default;
    else if((down_sw1 == 1) && ((bar1_ystart < vfp - vbp - bar1_size_reg)))
        bar1_ystart_delta_next = velocity_bar1_default;
    else
        bar1_ystart_delta_next = 0;
end


//Decreasing bar size
always @(*) begin
    bar_size_next = bar_size_reg;
    if(bar_size_reg < 17'd100)
        bar_size_next = bar_size_default;
    else if(hit_count_bar_reg == 17'd3)
        bar_size_next = bar_size_reg - 17'd50;
    else if(game_start == 1 || game_stop == 1)
        bar_size_next = bar_size_default;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar_size_reg <= bar_size_default;
    else
        bar_size_reg <= bar_size_next;
end

//Decreasing bar1 size
always @(*) begin
    bar1_size_next = bar1_size_reg;
    if(bar1_size_reg < 17'd100)
        bar1_size_next = bar1_size_default;
    else if(hit_count1_bar_reg == 17'd3)
        bar1_size_next = bar1_size_reg - 17'd50;
    else if(game_start == 1 || game_stop == 1)
        bar1_size_next = bar1_size_default;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar1_size_reg <= bar1_size_default;
    else
        bar1_size_reg <= bar1_size_next;
end

//Move bar forward
always @(*) begin
    bar_xstart_next = bar_xstart_reg;
//    if(hit_count_barp_reg == 17'd27)
//        bar_xstart_next = bar_xstart_reg - 17'd100;
//    else 
    if(game_start == 1 || game_stop == 1)
        bar_xstart_next = bar_x_left;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar_xstart_reg <= bar_x_left;
    else
        bar_xstart_reg <= bar_xstart_next;
end

//Move bar1 forward
always @(*) begin
    bar1_xstart_next = bar1_xstart_reg;
//    if(hit_count1_barp_reg == 17'd27)
//        bar1_xstart_next = bar1_xstart_reg + 17'd100;
//    else 
    if(game_start == 1 || game_stop == 1)
        bar1_xstart_next = bar1_x_left;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        bar1_xstart_reg <= bar1_x_left;
    else
        bar1_xstart_reg <= bar1_xstart_next;
end

//Incrementing square velocity
always @(*) begin
    sq_velocity_next = sq_velocity_reg;
    if(sq_velocity_reg > 17'd7)
        sq_velocity_next = velocity_sq_default;
    else if(hit_count_sq_reg == 17'd9)
        sq_velocity_next = sq_velocity_reg + 17'd2;
//    else if(sq_velocity_next != sq_velocity_reg)
//        sq_velcoity_next = 
    else if(game_stop == 1 || game_start == 1)
        sq_velocity_next = velocity_sq_default;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        sq_velocity_reg <= velocity_sq_default;
    else
        sq_velocity_reg <= sq_velocity_next;
end

//Incrementing square 1 velocity
always @(*) begin
    sq1_velocity_next = sq1_velocity_reg;
    if(sq1_velocity_reg > 17'd7)
        sq1_velocity_next = velocity_sq1_default;
    else if(hit_count_sq1_reg == 17'd9)
        sq1_velocity_next = sq1_velocity_reg + 17'd2;
//    else if(sq_velocity_next != sq_velocity_reg)
//        sq_velcoity_next = 
    else if(game_stop == 1 || game_start == 1)
        sq1_velocity_next = velocity_sq1_default;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        sq1_velocity_reg <= velocity_sq1_default;
    else
        sq1_velocity_reg <= sq1_velocity_next;
end

// Incrementing the hit count
assign hit_count = ((sq_xstart + sq_size >= bar_x_left) || (sq1_xstart + sq1_size >= bar_x_left));

// Incrementing the hit count 1
assign hit_count1 = ((sq_xstart <= bar1_x_left + bar1_width) || (sq1_xstart <= bar1_x_left + bar1_width));

//incrementing hit count for square velocity
always @(*) begin
    hit_count_sq_next = hit_count_sq_reg;
    if((hit_count == 1) && (refr_tick == 1))
        hit_count_sq_next = hit_count_sq_reg + 17'd1;
    else if(hit_count_sq_reg == 17'd9)
        hit_count_sq_next = 0;
    else if(game_stop == 1)
        hit_count_sq_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count_sq_reg <= 0;
    else
        hit_count_sq_reg <= hit_count_sq_next;
end

//incrementing hit count for square velocity 1
always @(*) begin
    hit_count1_sq_next = hit_count1_sq_reg;
    if((hit_count1 == 1) && (refr_tick == 1))
        hit_count1_sq_next = hit_count1_sq_reg + 17'd1;
    else if(hit_count1_sq_reg == 17'd9)
        hit_count1_sq_next = 0;
    else if(game_stop == 1)
        hit_count1_sq_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count1_sq_reg <= 0;
    else
        hit_count1_sq_reg <= hit_count1_sq_next;
end

//incrementing hit count for square 1 velocity
always @(*) begin
    hit_count_sq1_next = hit_count_sq1_reg;
    if((hit_count == 1) && (refr_tick == 1))
        hit_count_sq1_next = hit_count_sq1_reg + 17'd1;
    else if(hit_count_sq1_reg == 17'd9)
        hit_count_sq1_next = 0;
    else if(game_stop == 1)
        hit_count_sq1_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count_sq1_reg <= 0;
    else
        hit_count_sq1_reg <= hit_count_sq1_next;
end

//incrementing hit count for square 1 velocity 1
always @(*) begin
    hit_count1_sq1_next = hit_count1_sq1_reg;
    if((hit_count1 == 1) && (refr_tick == 1))
        hit_count1_sq1_next = hit_count1_sq1_reg + 17'd1;
    else if(hit_count1_sq1_reg == 17'd9)
        hit_count1_sq1_next = 0;
    else if(game_stop == 1)
        hit_count1_sq1_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count1_sq1_reg <= 0;
    else
        hit_count1_sq1_reg <= hit_count1_sq1_next;
end

//Incrementing hit count for bar size
always @(*) begin
    hit_count_bar_next = hit_count_bar_reg;
    if((hit_count == 1) && (refr_tick == 1))
        hit_count_bar_next = hit_count_bar_reg + 17'd1;
    else if(hit_count_bar_reg == 17'd3)
        hit_count_bar_next = 0;
    else if(game_stop == 1)
        hit_count_bar_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count_bar_reg <= 0;
    else
        hit_count_bar_reg <= hit_count_bar_next;
end

//Incrementing hit count for bar 1 size
always @(*) begin
    hit_count1_bar_next = hit_count1_bar_reg;
    if((hit_count1 == 1) && (refr_tick == 1))
        hit_count1_bar_next = hit_count1_bar_reg + 17'd1;
    else if(hit_count1_bar_reg == 17'd3)
        hit_count1_bar_next = 0;
    else if(game_stop == 1)
        hit_count1_bar_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count1_bar_reg <= 0;
    else
        hit_count1_bar_reg <= hit_count1_bar_next;
end
/*
//Incrementing hit count for bar position
always @(*) begin
    hit_count_barp_next = hit_count_barp_reg;
    if((hit_count == 1) && (refr_tick == 1))
        hit_count_barp_next = hit_count_barp_reg + 17'd1;
    else if(hit_count_barp_reg == 17'd27)
        hit_count_barp_next = 0;
    else if(game_stop == 1)
        hit_count_barp_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count_barp_reg <= 0;
    else
        hit_count_barp_reg <= hit_count_barp_next;
end

//Incrementing hit count for bar 1 position
always @(*) begin
    hit_count1_barp_next = hit_count1_barp_reg;
    if((hit_count1 == 1) && (refr_tick == 1))
        hit_count1_barp_next = hit_count1_barp_reg + 17'd1;
    else if(hit_count1_barp_reg == 17'd27)
        hit_count1_barp_next = 0;
    else if(game_stop == 1)
        hit_count1_barp_next = 0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        hit_count1_barp_reg <= 0;
    else
        hit_count1_barp_reg <= hit_count1_barp_next;
end*/

//Assigning values to game_stop
always @(posedge clk_pixel) begin
    if(clr == 1)
        game_stop = 1;
    else if((game_on == 2'd0) || (game_on == 2'd1) || (game_on == 2'd2))
        game_stop = 1;
    else if(game_start == 1)
        game_stop = 0;
//    else if(sq_xstart >= hfp - hbp - sq_size)
//        game_stop = 1;

//if ((sq_xstart + sq_size >= bar_xstart_reg) && (~((sq_ystart > bar_ystart + bar_size_reg) || (sq_ystart + sq_size < bar_ystart))))
//        sq_xtart_delta_next = -sq_velocity_reg;
    else if ((sq_xstart + sq_size > bar_x_left) && ((sq_ystart + sq_size < bar_ystart_reg)||(sq_ystart > bar_ystart_reg + bar_size_reg)))
        game_stop = 1'b1;
    else if(((sq_xstart < bar1_x_left + bar1_width) && ((sq_ystart + sq_size < bar1_ystart_reg)||(sq_ystart > bar1_ystart_reg + bar1_size_reg))))
        game_stop = 1'b1;
    else if ((sq1_xstart + sq1_size > bar_x_left) && ((sq1_ystart + sq1_size < bar_ystart_reg)||(sq1_ystart > bar_ystart_reg + bar_size_reg)))
        game_stop = 1'b1;
    else if(((sq1_xstart < bar1_x_left + bar1_width) && ((sq1_ystart + sq1_size < bar1_ystart_reg)||(sq1_ystart > bar1_ystart_reg + bar1_size_reg))))
        game_stop = 1'b1;
    else if(game_win == 1)
        game_stop = 1;
end

//Assigning values to game_win
always @(posedge clk_pixel) begin
    if(clr == 1)
        game_win = 0;
    else if(game_start == 1)
        game_win = 0;
    else if((one_score_reg >= 17'd27) || (two_score_reg >= 17'd27))
        game_win = 1;
end

//Incrementing one score
always @(*) begin
    one_score_next = one_score_reg;
    if((hit_count == 1) && (refr_tick == 1))
        one_score_next = one_score_reg + 17'd1;
    else if((game_start == 1) || (game_stop == 1))
        one_score_next = 17'd0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        one_score_reg <= 0;
    else
        one_score_reg <= one_score_next;
end

//Incrementing two score
always @(*) begin
    two_score_next = two_score_reg;
    if((hit_count1 == 1) && (refr_tick == 1))
        two_score_next = two_score_reg + 17'd1;
    else if((game_start == 1) || (game_stop == 1))
        two_score_next = 17'd0;
end

always @(posedge clk_pixel) begin
    if(clr == 1)
        two_score_reg <= 0;
    else
        two_score_reg <= two_score_next;
end

wire [10:0] rom_addr_ball, rom_pix_ball, rom_addr_tens, rom_pix_tens, rom_addr_ones, rom_pix_ones;
wire [4:0] drom_addr_ball, drom_addr_tens, drom_addr_ones;
wire [0:31] drom_data_ball, drom_data_tens, drom_data_ones;

assign rom_addr_ball = vc - vbp - sq_ystart;
assign rom_pix_ball = hc - hbp - sq_xstart;
assign drom_addr_ball = rom_addr_ball[4:0];
reg R;

//Print one score
assign rom_addr_tens = vc - vbp - (32 + 20);
assign rom_pix_tens = hc - hbp - (hfp - hbp - 64 - 10);
assign drom_addr_tens = rom_addr_tens[4:0];
assign rom_addr_ones = vc - vbp - (32 + 20);
assign rom_pix_ones = hc - hbp - (hfp - hbp - 32 - 10);
assign drom_addr_ones = rom_addr_ones[4:0];
reg tens_num, ones_num;
wire [3:0] tens, ones;

font_ball obj1(
    .drom_addr_num(drom_addr_ball),
    .drom_data_num(drom_data_ball)
);

bcd obj2(
    .inp(one_score_reg[5:0]),
    .tens(tens),
    .ones(ones)
);

font_number obj3(
    .num_ip(tens),
    .drom_addr_num(drom_addr_tens),
    .drom_data_num(drom_data_tens)
);

font_number obj4(
    .num_ip(ones),
    .drom_addr_num(drom_addr_ones),
    .drom_data_num(drom_data_ones)
);

reg tens_on, ones_on;
always @(*) begin
    if((hc >=  (hfp - hbp - 64 - 10) + hbp) && (hc <  (hfp - hbp - 32 - 10) + hbp) && (vc >= (32 + 20) + vbp) && (vc < (64 + 20) + vbp))
        tens_on <= 1;
    else
        tens_on <= 0;    
end

always @(*) begin
    if((hc >= (hfp - hbp - 32 - 10) + hbp) && (hc < (hfp - hbp - 10) + hbp) && (vc >= (32 + 20) + vbp) && (vc < (64 + 20) + vbp))
        ones_on <= 1;
    else
        ones_on <= 0;    
end

//Print two score
wire [10:0] rom_addr_tens1, rom_pix_tens1, rom_addr_ones1, rom_pix_ones1;
wire [4:0] drom_addr_tens1, drom_addr_ones1;
wire [0:31] drom_data_tens1, drom_data_ones1;

assign rom_addr_tens1 = vc - vbp - (32 + 20);
assign rom_pix_tens1 = hc - hbp - (10);
assign drom_addr_tens1 = rom_addr_tens1[4:0];
assign rom_addr_ones1 = vc - vbp - (32 + 20);
assign rom_pix_ones1 = hc - hbp - (32 + 10);
assign drom_addr_ones1 = rom_addr_ones1[4:0];
reg tens_num1, ones_num1;
wire [3:0] tens1, ones1;

bcd obj21(
    .inp(two_score_reg[5:0]),
    .tens(tens1),
    .ones(ones1)
);

font_number obj31(
    .num_ip(tens1),
    .drom_addr_num(drom_addr_tens1),
    .drom_data_num(drom_data_tens1)
);

font_number obj41(
    .num_ip(ones1),
    .drom_addr_num(drom_addr_ones1),
    .drom_data_num(drom_data_ones1)
);

reg tens_on1, ones_on1;
always @(*) begin
    if((hc >=  (10) + hbp) && (hc <  (32 + 10) + hbp) && (vc >= (32 + 20) + vbp) && (vc < (64 + 20) + vbp))
        tens_on1 <= 1;
    else
        tens_on1 <= 0;
end

always @(*) begin
    if((hc >= (32 + 10) + hbp) && (hc < (64 + 10) + hbp) && (vc >= (32 + 20) + vbp) && (vc < (64 + 20) + vbp))
        ones_on1 <= 1;
    else
        ones_on1 <= 0;
end

//Print square 2
wire [10:0] rom_addr_ball1, rom_pix_ball1;
wire [4:0] drom_addr_ball1;
wire [0:31] drom_data_ball1;

assign rom_addr_ball1 = vc - vbp - sq1_ystart;
assign rom_pix_ball1 = hc - hbp - sq1_xstart;
assign drom_addr_ball1 = rom_addr_ball1[4:0];
reg R1;

font_ball obj11(
    .drom_addr_num(drom_addr_ball1),
    .drom_data_num(drom_data_ball1)
);

//By word
reg by_on;
always @(*) begin
    if((hc >= (10) + hbp) && (hc < (10 + 64) + hbp) && (vc >= (vfp - vbp - 32 - 10) + vbp) && (vc < (vfp - vbp - 32 - 10 + 32) + vbp))
        by_on <= 1;
    else
        by_on <= 0;    
end

wire [10:0] rom_addr_by, rom_pix_by /*rom_addr_tens, rom_pix_tens, rom_addr_ones, rom_pix_ones*/;
wire [4:0] drom_addr_by/*, drom_addr_tens, drom_addr_ones*/;
wire [0:63] drom_data_by/*, drom_data_tens, drom_data_ones*/;
reg by_word;

assign rom_addr_by = vc - vbp - (vfp - vbp - 32 - 10);
assign rom_pix_by = hc - hbp - (10);
assign drom_addr_by = rom_addr_by[4:0];

word_by obj5(
    .drom_addr_num(drom_addr_by),
    .drom_data_num(drom_data_by)
);

//Name word
reg name_on;
always @(*) begin
    if((hc >= (10 + 96) + hbp) && (hc < (10 + 96 + 160) + hbp) && (vc >= (vfp - vbp - 32 - 10) + vbp) && (vc < (vfp - vbp - 32 - 10 + 32) + vbp))
        name_on <= 1;
    else
        name_on <= 0;    
end

wire [10:0] rom_addr_name, rom_pix_name;
wire [4:0] drom_addr_name;
wire [0:159] drom_data_name;
reg name_word;

assign rom_addr_name = vc - vbp - (vfp - vbp - 32 - 10);
assign rom_pix_name = hc - hbp - (10 + 96);
assign drom_addr_name = rom_addr_name[4:0];

word_name obj6(
    .drom_addr_num(drom_addr_name),
    .drom_data_num(drom_data_name)
);

//word Player1
reg player1_on;
always @(*) begin
    if((hc >= (hfp - hbp - 224 - 10) + hbp) && (hc < (hfp - hbp - 224 - 10 + 224) + hbp) && (vc >= (10) + vbp) && (vc < (10 + 32) + vbp))
        player1_on <= 1;
    else
        player1_on <= 0;    
end

wire [10:0] rom_addr_player1, rom_pix_player1;
wire [4:0] drom_addr_player1;
wire [0:223] drom_data_player1;
reg player1_word;

assign rom_addr_player1 = vc - vbp - (10);
assign rom_pix_player1 = hc - hbp - (hfp - hbp - 224 - 10);
assign drom_addr_player1 = rom_addr_player1[4:0];

word_player1 obj7(
    .drom_addr_num(drom_addr_player1),
    .drom_data_num(drom_data_player1)
);

//word Player2
reg player2_on;
always @(*) begin
    if((hc >= (10) + hbp) && (hc < (10 + 224) + hbp) && (vc >= (10) + vbp) && (vc < (10 + 32) + vbp))
        player2_on <= 1;
    else
        player2_on <= 0;    
end

wire [10:0] rom_addr_player2, rom_pix_player2;
wire [4:0] drom_addr_player2;
wire [0:223] drom_data_player2;
reg player2_word;

assign rom_addr_player2 = vc - vbp - (10);
assign rom_pix_player2 = hc - hbp - (10);
assign drom_addr_player2 = rom_addr_player2[4:0];

word_player2 obj71(
    .drom_addr_num(drom_addr_player2),
    .drom_data_num(drom_data_player2)
);

//Move the words
parameter word_size = 224 + 32 + 64 + 32 + 128 + 32 + 128;
parameter velocity_word_default = 2;
parameter word_x_start = 180;
parameter word_y_start = 100;
wire [16:0] word_xstart, word_ystart;
reg [16:0] word_xstart_reg, word_ystart_reg, word_xstart_next, word_ystart_next;
reg [16:0] word_xstart_delta_reg, word_ystart_delta_reg, word_xstart_delta_next, word_ystart_delta_next;

assign word_xstart = word_xstart_reg;
assign word_ystart = word_ystart_reg;

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        word_xstart_reg <= word_x_start;
        word_ystart_reg <= word_y_start;
    end
    else begin
        word_xstart_reg <= word_xstart_next;
        word_ystart_reg <= word_ystart_next;
    end
end

always @(*) begin
    word_xstart_next = word_xstart_reg;
    if(refr_tick == 1)
        word_xstart_next = word_xstart_reg + word_xstart_delta_reg;
end

always @(*) begin
    word_ystart_next = word_ystart_reg;
    if(refr_tick == 1)
        word_ystart_next = word_ystart_reg + word_ystart_delta_reg;
end

always @(posedge clk_pixel) begin
    if(clr == 1) begin
        word_xstart_delta_reg <= velocity_word_default;
        word_ystart_delta_reg <= velocity_word_default;
    end
    else begin
        word_xstart_delta_reg <= word_xstart_delta_next;
        word_ystart_delta_reg <= word_ystart_delta_next;
    end
end

always @(*) begin
    word_xstart_delta_next = word_xstart_delta_reg;
    if(word_xstart <= 1)
        word_xstart_delta_next = velocity_word_default;
    else if(word_xstart >= hfp - hbp - word_size)
        word_xstart_delta_next = -velocity_word_default;
        
end

always @(*) begin
    word_ystart_delta_next = word_ystart_delta_reg;
    if(word_ystart <= 1)
        word_ystart_delta_next = velocity_word_default;
    else if(word_ystart >= vfp - vbp - 32)
        word_ystart_delta_next = -velocity_word_default;
end

//Word welcome
reg welcome_on;
always @(*) begin
    if((hc >= (word_xstart) + hbp) && (hc < (word_xstart + 224) + hbp) && (vc >= (word_ystart) + vbp) && (vc < (word_ystart + 32) + vbp))
        welcome_on <= 1;
    else
        welcome_on <= 0;    
end

wire [10:0] rom_addr_welcome, rom_pix_welcome;
wire [4:0] drom_addr_welcome;
wire [0:223] drom_data_welcome;
reg welcome_word;

assign rom_addr_welcome = vc - vbp - (word_ystart);
assign rom_pix_welcome = hc - hbp - (word_xstart);
assign drom_addr_welcome = rom_addr_welcome[4:0];

word_welcome obj8(
    .drom_addr_num(drom_addr_welcome),
    .drom_data_num(drom_data_welcome)
);

//Word to
reg to_on;
always @(*) begin
    if((hc >= (word_xstart + 224 + 32) + hbp) && (hc < (word_xstart + 224 + 32 + 64) + hbp) && (vc >= (word_ystart) + vbp) && (vc < (word_ystart + 32) + vbp))
        to_on <= 1;
    else
        to_on <= 0;
end

wire [10:0] rom_addr_to, rom_pix_to;
wire [4:0] drom_addr_to;
wire [0:63] drom_data_to;
reg to_word;

assign rom_addr_to = vc - vbp - (word_ystart);
assign rom_pix_to = hc - hbp - (word_xstart + 224 + 32);
assign drom_addr_to = rom_addr_to[4:0];

word_to obj9(
    .drom_addr_num(drom_addr_to),
    .drom_data_num(drom_data_to)
);

//Word Ping
reg ping_on;
always @(*) begin
    if((hc >= (word_xstart + 224 + 32 + 64 + 32) + hbp) && (hc < (word_xstart + 224 + 32 + 64 + 32 + 128) + hbp) && (vc >= (word_ystart) + vbp) && (vc < (word_ystart + 32) + vbp))
        ping_on <= 1;
    else
        ping_on <= 0;    
end

wire [10:0] rom_addr_ping, rom_pix_ping;
wire [4:0] drom_addr_ping;
wire [0:127] drom_data_ping;
reg ping_word;

assign rom_addr_ping = vc - vbp - (word_ystart);
assign rom_pix_ping = hc - hbp - (word_xstart + 224 + 32 + 64 + 32);
assign drom_addr_ping = rom_addr_ping[4:0];

word_ping obj10(
    .drom_addr_num(drom_addr_ping),
    .drom_data_num(drom_data_ping)
);

//Word Pong
reg pong_on;
always @(*) begin
    if((hc >= (word_xstart + 224 + 32 + 64 + 32 + 128 + 32) + hbp) && (hc < (word_xstart + 224 + 32 + 64 + 32 + 128 + 32 + 128) + hbp) && (vc >= (word_ystart) + vbp) && (vc < (word_ystart + 32) + vbp))
        pong_on <= 1;
    else
        pong_on <= 0;    
end

wire [10:0] rom_addr_pong, rom_pix_pong;
wire [4:0] drom_addr_pong;
wire [0:127] drom_data_pong;
reg pong_word;

assign rom_addr_pong = vc - vbp - (word_ystart);
assign rom_pix_pong = hc - hbp - (word_xstart + 224 + 32 + 64 + 32 + 128 + 32);
assign drom_addr_pong = rom_addr_pong[4:0];

word_pong obj111(
    .drom_addr_num(drom_addr_pong),
    .drom_data_num(drom_data_pong)
);

//reg [3:0] red_wall_reg, green_wall_reg, blue_wall_reg, red_sq_reg, green_sq_reg, blue_sq_reg, red_bar_reg, green_bar_reg, blue_bar_reg;

always @(*) begin
    red = 0;
    green = 0;
    blue = 0;
    tens_num = drom_data_tens[rom_pix_tens];
    ones_num = drom_data_ones[rom_pix_ones];
    tens_num1 = drom_data_tens1[rom_pix_tens1];
    ones_num1 = drom_data_ones1[rom_pix_ones1];
    by_word = drom_data_by[rom_pix_by];
    name_word = drom_data_name[rom_pix_name];
    player1_word = drom_data_player1[rom_pix_player1];
    player2_word = drom_data_player2[rom_pix_player2];
    welcome_word = drom_data_welcome[rom_pix_welcome];
    to_word = drom_data_to[rom_pix_to];
    ping_word = drom_data_ping[rom_pix_ping];
    pong_word = drom_data_pong[rom_pix_pong];
    R = drom_data_ball[rom_pix_ball];
    R1 = drom_data_ball1[rom_pix_ball1];
    if(game_on == 2'd3) begin
        if((tens_on == 1) && (tens_num == 1) && (vidon == 1)) begin
//            tens_num = drom_data_tens[rom_pix_tens];
//            if(tens_num == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((ones_on == 1) && (ones_num == 1) && (vidon == 1)) begin
//            ones_num = drom_data_ones[rom_pix_ones];
//            if(ones_num == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((tens_on1 == 1) && (tens_num1 == 1) && (vidon == 1)) begin
//            tens_num = drom_data_tens[rom_pix_tens];
//            if(tens_num == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((ones_on1 == 1) && (ones_num1 == 1) && (vidon == 1)) begin
//            ones_num = drom_data_ones[rom_pix_ones];
//            if(ones_num == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((by_on == 1) && (by_word == 1) && (vidon == 1)) begin
//            by_word = drom_data_by[rom_pix_by];
//            if(by_word == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((name_on == 1) && (name_word == 1) && (vidon == 1)) begin
//            name_word = drom_data_name[rom_pix_name];
//            if(name_word == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((player1_on == 1) && (player1_word == 1) && (vidon == 1)) begin
//            player1_word = drom_data_player1[rom_pix_player1];
//            if(player1_word == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((player2_on == 1) && (player2_word == 1) && (vidon == 1)) begin
//            player2_word = drom_data_player2[rom_pix_player2];
//            if(player2_word == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        /*else if((wall_on == 1) && (vidon == 1)) begin
            red = 4'd0; //red_wall_reg;
            green = 4'd15; //green_wall_reg;
            blue = 4'd15; //blue_wall_reg;
        end*/
        else if((sq_on == 1) && (R == 1) && (vidon == 1)) begin
//            R = drom_data_ball[rom_pix_ball];
//            if(R == 1) begin
                red = 4'd15;
                green = 4'd0;
                blue = 4'd0;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((sq1_on == 1) && (R1 == 1) && (vidon == 1)) begin
//            R = drom_data_ball[rom_pix_ball];
//            if(R == 1) begin
                red = 4'd0;
                green = 4'd0;
                blue = 4'd15;
//            end
//            else begin
//                red = 4'd15;
//                green = 4'd15;
//                blue = 4'd15;
//            end
        end
        else if((bar_on == 1) && (vidon == 1)) begin
            red = 4'd0; //red_bar_reg;
            green = 4'd15; //green_bar_reg;
            blue = 4'd0; //blue_bar_reg;
        end
        else if((bar1_on == 1) && (vidon == 1)) begin
            red = 4'd0; //red_bar_reg;
            green = 4'd15; //green_bar_reg;
            blue = 4'd0; //blue_bar_reg;
        end
        
        else if(vidon == 1) begin
            red = 4'd15;
            green = 4'd15;
            blue = 4'd15;
        end
    end
    else if((by_on == 1) && (by_word == 1) && (vidon == 1)) begin
//        by_word = drom_data_by[rom_pix_by];
//        if(by_word == 1) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
//        end
//        else begin
//            red = 4'd15;
//            green = 4'd15;
//            blue = 4'd15;
//        end
    end
    else if((name_on == 1) && (name_word == 1) && (vidon == 1)) begin
//        name_word = drom_data_name[rom_pix_name];
//        if(name_word == 1) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
//        end
//        else begin
//            red = 4'd15;
//            green = 4'd15;
//            blue = 4'd15;
//        end
    end
    else if((welcome_on == 1) && (welcome_word == 1) && (vidon == 1)) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
    end
    else if((to_on == 1) && (to_word == 1) && (vidon == 1)) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
    end
    else if((ping_on == 1) && (ping_word == 1) && (vidon == 1)) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
    end
    else if((pong_on == 1) && (pong_word == 1) && (vidon == 1)) begin
            red = 4'd0;
            green = 4'd0;
            blue = 4'd0;
    end
    else if(vidon == 1) begin
        red = 4'd15;
        green = 4'd15;
        blue = 4'd15;
    end
end

//always @(posedge clk1) begin
//    if(clr == 1) begin
//        red_wall_reg = 4'd0;
//        red_sq_reg = 4'd15;
//        red_bar_reg = 4'd0;
//        green_wall_reg = 4'd0;
//        green_sq_reg = 4'd0;
//        green_bar_reg = 4'd15;
//        blue_wall_reg = 4'd15;
//        blue_sq_reg = 4'd0;
//        blue_bar_reg = 4'd0;
//    end
//    else begin
//        if(RGB[0] == 1) begin
//            if(obj_select[0] == 1)
//                red_wall_reg = red_wall_reg + 4'd1;
//            if(obj_select[1] == 1)
//                red_sq_reg = red_sq_reg + 4'd1;
//            if(obj_select[2] == 1)
//                red_bar_reg = red_bar_reg + 4'd1;
//        end
//        if(RGB[1] == 1) begin
//            if(obj_select[0] == 1)
//                green_wall_reg = green_wall_reg + 4'd1;
//            if(obj_select[1] == 1)
//                green_sq_reg = green_sq_reg + 4'd1;
//            if(obj_select[2] == 1)
//                green_bar_reg = green_bar_reg + 4'd1;
//        end
//        if(RGB[2] == 1) begin
//            if(obj_select[0] == 1)
//                blue_wall_reg = blue_wall_reg + 4'd1;
//            if(obj_select[1] == 1)
//                blue_sq_reg = blue_sq_reg + 4'd1;
//            if(obj_select[2] == 1)
//                blue_bar_reg = blue_bar_reg + 4'd1;
//        end
//    end
//end

endmodule