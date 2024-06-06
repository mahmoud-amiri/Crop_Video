//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the crop_video_axis_snk interface signals.
//      It is instantiated once per crop_video_axis_snk bus.  Bus Functional Models, 
//      BFM's named crop_video_axis_snk_driver_bfm, are used to drive signals on the bus.
//      BFM's named crop_video_axis_snk_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tdata), // Agent output 
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tstrb), // Agent output 
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tlast), // Agent output 
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tvalid), // Agent output 
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tuser), // Agent output 
// .dut_signal_port(crop_video_axis_snk_bus.s00_axis_tready), // Agent input 

import uvmf_base_pkg_hdl::*;
import crop_video_axis_snk_pkg_hdl::*;

interface  crop_video_axis_snk_if #(
  int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH = 32,
  int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8 = 4
  )

  (
  input tri clk, 
  input tri rst,
  inout tri [crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH-1:0] s00_axis_tdata,
  inout tri [crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8-1:0] s00_axis_tstrb,
  inout tri  s00_axis_tlast,
  inout tri  s00_axis_tvalid,
  inout tri  s00_axis_tuser,
  inout tri  s00_axis_tready
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input s00_axis_tdata,
  input s00_axis_tstrb,
  input s00_axis_tlast,
  input s00_axis_tvalid,
  input s00_axis_tuser,
  input s00_axis_tready
  );

modport initiator_port 
  (
  input clk,
  input rst,
  output s00_axis_tdata,
  output s00_axis_tstrb,
  output s00_axis_tlast,
  output s00_axis_tvalid,
  output s00_axis_tuser,
  input s00_axis_tready
  );

modport responder_port 
  (
  input clk,
  input rst,  
  input s00_axis_tdata,
  input s00_axis_tstrb,
  input s00_axis_tlast,
  input s00_axis_tvalid,
  input s00_axis_tuser,
  output s00_axis_tready
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

