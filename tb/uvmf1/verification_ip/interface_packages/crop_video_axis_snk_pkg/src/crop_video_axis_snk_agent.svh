//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: Protocol specific agent class definition
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_axis_snk_agent #(
     int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH = 32,
     int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8 = 4
     ) extends uvmf_parameterized_agent #(
                    .CONFIG_T(crop_video_axis_snk_configuration #(
                              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
                              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
                              )),
                    .DRIVER_T(crop_video_axis_snk_driver #(
                              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
                              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
                              )),
                    .MONITOR_T(crop_video_axis_snk_monitor #(
                               .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
                               .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
                               )),
                    .COVERAGE_T(crop_video_axis_snk_transaction_coverage #(
                                .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
                                .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
                                )),
                    .TRANS_T(crop_video_axis_snk_transaction #(
                             .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
                             .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
                             ))
                    );

  `uvm_component_param_utils( crop_video_axis_snk_agent #(
                              crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH,
                              crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8
                              ))

// pragma uvmf custom class_item_additional begin
// pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
  // FUNCTION: build_phase
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    if (configuration.active_passive == ACTIVE) begin
      // Place sequencer handle into configuration object
      // so that it may be retrieved from configuration 
      // rather than using uvm_config_db
      configuration.sequencer = this.sequencer;
    end
  endfunction
  
endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

