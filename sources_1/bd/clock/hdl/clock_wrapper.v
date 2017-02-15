//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Fri Sep 30 15:22:03 2016
//Host        : Rohan running 64-bit major release  (build 9200)
//Command     : generate_target clock_wrapper.bd
//Design      : clock_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clock_wrapper
   (clk100M,
    clk65M,
    locked,
    reset);
  input clk100M;
  output clk65M;
  output locked;
  input reset;

  wire clk100M;
  wire clk65M;
  wire locked;
  wire reset;

  clock clock_i
       (.clk100M(clk100M),
        .clk65M(clk65M),
        .locked(locked),
        .reset(reset));
endmodule
