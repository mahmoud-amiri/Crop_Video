//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import crop_video_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #9ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 0; 
    #200ns;
    rst =  1; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  crop_video_config_if  crop_video_config_agent_bus(
     // pragma uvmf custom crop_video_config_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom crop_video_config_agent_bus_connections end
     );
  crop_video_axis_snk_if  crop_video_axis_snk_agent_bus(
     // pragma uvmf custom crop_video_axis_snk_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom crop_video_axis_snk_agent_bus_connections end
     );
  crop_video_axis_src_if  crop_video_axis_src_agent_bus(
     // pragma uvmf custom crop_video_axis_src_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom crop_video_axis_src_agent_bus_connections end
     );
  crop_video_config_monitor_bfm  crop_video_config_agent_mon_bfm(crop_video_config_agent_bus);
  crop_video_axis_snk_monitor_bfm  crop_video_axis_snk_agent_mon_bfm(crop_video_axis_snk_agent_bus);
  crop_video_axis_src_monitor_bfm  crop_video_axis_src_agent_mon_bfm(crop_video_axis_src_agent_bus);
  crop_video_config_driver_bfm  crop_video_config_agent_drv_bfm(crop_video_config_agent_bus);
  crop_video_axis_snk_driver_bfm  crop_video_axis_snk_agent_drv_bfm(crop_video_axis_snk_agent_bus);
  crop_video_axis_src_driver_bfm  crop_video_axis_src_agent_drv_bfm(crop_video_axis_src_agent_bus);
  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  crop_vid #(
    .C_S00_AXIS_TDATA_WIDTH(32),
    .C_M00_AXIS_TDATA_WIDTH(32),
    .C_M00_AXIS_START_COUNT(32)
  ) crop_vid_inst (
    .crop_x(crop_video_config_agent_bus.crop_x),
    .crop_y(crop_video_config_agent_bus.crop_y),
    .crop_width(crop_video_config_agent_bus.crop_width),
    .crop_height(crop_video_config_agent_bus.crop_height),
    .s00_axis_aclk(clk),
    .s00_axis_aresetn(rst),
    .s00_axis_tlast(crop_video_axis_snk_agent_bus.s00_axis_tlast),
    .s00_axis_tvalid(crop_video_axis_snk_agent_bus.s00_axis_tvalid),
    .s00_axis_tuser(crop_video_axis_snk_agent_bus.s00_axis_tuser),
    .s00_axis_tready(crop_video_axis_snk_agent_bus.s00_axis_tready),
    .s00_axis_tdata(crop_video_axis_snk_agent_bus.s00_axis_tdata),
    .s00_axis_tstrb(crop_video_axis_snk_agent_bus.s00_axis_tstrb),

    .m00_axis_aclk(crop_video_axis_src_agent_bus.m00_axis_aclk),
    .m00_axis_aresetn(crop_video_axis_src_agent_bus.m00_axis_aresetn),
    .m00_axis_tready(crop_video_axis_src_agent_bus.m00_axis_tready),
    .m00_axis_tvalid(crop_video_axis_src_agent_bus.m00_axis_tvalid),
    .m00_axis_tlast(crop_video_axis_src_agent_bus.m00_axis_tlast),
    .m00_axis_tuser(crop_video_axis_src_agent_bus.m00_axis_tuser),
    .m00_axis_tdata(crop_video_axis_src_agent_bus.m00_axis_tdata),
    .m00_axis_tstrb(crop_video_axis_src_agent_bus.m00_axis_tstrb)
  );
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual crop_video_config_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_config_agent_BFM , crop_video_config_agent_mon_bfm ); 
    uvm_config_db #( virtual crop_video_axis_snk_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_axis_snk_agent_BFM , crop_video_axis_snk_agent_mon_bfm ); 
    uvm_config_db #( virtual crop_video_axis_src_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_axis_src_agent_BFM , crop_video_axis_src_agent_mon_bfm ); 
    uvm_config_db #( virtual crop_video_config_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_config_agent_BFM , crop_video_config_agent_drv_bfm  );
    uvm_config_db #( virtual crop_video_axis_snk_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_axis_snk_agent_BFM , crop_video_axis_snk_agent_drv_bfm  );
    uvm_config_db #( virtual crop_video_axis_src_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , crop_video_axis_src_agent_BFM , crop_video_axis_src_agent_drv_bfm ); 

  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

