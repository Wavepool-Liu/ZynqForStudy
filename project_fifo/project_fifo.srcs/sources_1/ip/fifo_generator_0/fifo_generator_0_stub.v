// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Aug 11 10:50:47 2020
// Host        : DESKTOP-FR76LPK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/1TCPproxy/fifo/project_fifo/project_fifo.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0_stub.v
// Design      : fifo_generator_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3" *)
module fifo_generator_0(clk, srst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[5:0],wr_en,rd_en,dout[5:0],full,empty" */;
  input clk;
  input srst;
  input [5:0]din;
  input wr_en;
  input rd_en;
  output [5:0]dout;
  output full;
  output empty;
endmodule
