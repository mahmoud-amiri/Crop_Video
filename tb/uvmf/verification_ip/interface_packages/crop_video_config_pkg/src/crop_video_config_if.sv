//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the crop_video_config interface signals.
//      It is instantiated once per crop_video_config bus.  Bus Functional Models, 
//      BFM's named crop_video_config_driver_bfm, are used to drive signals on the bus.
//      BFM's named crop_video_config_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(crop_video_config_bus.crop_x), // Agent output 
// .dut_signal_port(crop_video_config_bus.crop_y), // Agent output 
// .dut_signal_port(crop_video_config_bus.crop_width), // Agent output 
// .dut_signal_port(crop_video_config_bus.crop_height), // Agent output 

import uvmf_base_pkg_hdl::*;
import crop_video_config_pkg_hdl::*;

interface  crop_video_config_if 

  (
  input tri clk, 
  input tri rst,
  inout tri [15:0] crop_x,
  inout tri [15:0] crop_y,
  inout tri [15:0] crop_width,
  inout tri [15:0] crop_height
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input crop_x,
  input crop_y,
  input crop_width,
  input crop_height
  );

modport initiator_port 
  (
  input clk,
  input rst,
  output crop_x,
  output crop_y,
  output crop_width,
  output crop_height
  );

modport responder_port 
  (
  input clk,
  input rst,  
  input crop_x,
  input crop_y,
  input crop_width,
  input crop_height
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

