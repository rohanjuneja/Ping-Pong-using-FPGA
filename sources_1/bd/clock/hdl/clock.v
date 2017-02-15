//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Fri Sep 30 15:22:03 2016
//Host        : Rohan running 64-bit major release  (build 9200)
//Command     : generate_target clock.bd
//Design      : clock
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "clock,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=clock,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,synth_mode=Global}" *) (* HW_HANDOFF = "clock.hwdef" *) 
module clock
   (clk100M,
    clk65M,
    locked,
    reset);
  input clk100M;
  output clk65M;
  output locked;
  input reset;

  wire clk100M_1;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_locked;
  wire reset_1;

  assign clk100M_1 = clk100M;
  assign clk65M = clk_wiz_0_clk_out1;
  assign locked = clk_wiz_0_locked;
  assign reset_1 = reset;
  clock_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk100M_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .locked(clk_wiz_0_locked),
        .reset(reset_1));
endmodule
