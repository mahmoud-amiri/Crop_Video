//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the crop_video_axis_src interface signals.
//      It is instantiated once per crop_video_axis_src bus.  Bus Functional Models, 
//      BFM's named crop_video_axis_src_driver_bfm, are used to drive signals on the bus.
//      BFM's named crop_video_axis_src_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_aclk), // Agent output 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_aresetn), // Agent output 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tready), // Agent output 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tvalid), // Agent input 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tlast), // Agent input 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tuser), // Agent input 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tdata), // Agent input 
// .dut_signal_port(crop_video_axis_src_bus.m00_axis_tstrb), // Agent input 

import uvmf_base_pkg_hdl::*;
import crop_video_axis_src_pkg_hdl::*;

interface  crop_video_axis_src_if #(
  int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH = 32,
  int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8 = 4,
  int crop_video_axis_src_C_M00_AXIS_START_COUNT = 32
  )

  (
  input tri clk, 
  input tri rst,
  inout tri  m00_axis_aclk,
  inout tri  m00_axis_aresetn,
  inout tri  m00_axis_tready,
  inout tri  m00_axis_tvalid,
  inout tri  m00_axis_tlast,
  inout tri  m00_axis_tuser,
  inout tri [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata,
  inout tri [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input m00_axis_aclk,
  input m00_axis_aresetn,
  input m00_axis_tready,
  input m00_axis_tvalid,
  input m00_axis_tlast,
  input m00_axis_tuser,
  input m00_axis_tdata,
  input m00_axis_tstrb
  );

modport initiator_port 
  (
  input clk,
  input rst,
  output m00_axis_aclk,
  output m00_axis_aresetn,
  output m00_axis_tready,
  input m00_axis_tvalid,
  input m00_axis_tlast,
  input m00_axis_tuser,
  input m00_axis_tdata,
  input m00_axis_tstrb
  );

modport responder_port 
  (
  input clk,
  input rst,  
  input m00_axis_aclk,
  input m00_axis_aresetn,
  input m00_axis_tready,
  output m00_axis_tvalid,
  output m00_axis_tlast,
  output m00_axis_tuser,
  output m00_axis_tdata,
  output m00_axis_tstrb
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

