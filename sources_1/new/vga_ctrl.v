`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2016 14:26:36
// Design Name: 
// Module Name: vga_ctrl
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


module vga_ctrl(
    input clk,clr, 
    output reg hsync, vsync,
    output reg [16:0] hc, vc, 
    output reg vidon
);

parameter hpixels = 1344;
parameter vlines = 806;
parameter hbp = 296;
parameter hfp = 1320;
parameter vbp = 35;
parameter vfp = 803;
parameter hsp = 136;
parameter vsp = 6;
reg vsenable;

always @(posedge clk or posedge clr) begin
    if(clr == 1)
        hc = 0;
    else begin
        if(hc == hpixels - 1) begin
            hc = 0;
            vsenable = 1;
        end
        else begin
            hc = hc + 1;
            vsenable = 0;
        end
    end
end

always @(posedge clk or posedge clr) begin
    if(clr == 1)
        vc = 0;
    else if(vsenable == 1) begin
        if(vc == vlines - 1) begin
            vc = 0;
        end
        else begin
            vc = vc + 1;
        end
    end
end

always @(*)begin
    if(hc < hsp)
        hsync = 0;
    else
        hsync = 1;
end

always @(*)begin
    if(vc < vsp)
        vsync = 0;
    else
        vsync = 1;
end

always @(*) begin
    if((hc < hfp) && (hc > hbp) && (vc < vfp) && (vc > vbp))
        vidon = 1;
    else
        vidon = 0;
end

endmodule
