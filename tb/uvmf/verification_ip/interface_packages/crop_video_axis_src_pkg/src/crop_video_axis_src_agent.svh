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
class crop_video_axis_src_agent #(
     int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH = 32,
     int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8 = 4,
     int crop_video_axis_src_C_M00_AXIS_START_COUNT = 32
     ) extends uvmf_parameterized_agent #(
                    .CONFIG_T(crop_video_axis_src_configuration #(
                              .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                              .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                              .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                              )),
                    .DRIVER_T(crop_video_axis_src_driver #(
                              .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                              .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                              .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                              )),
                    .MONITOR_T(crop_video_axis_src_monitor #(
                               .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                               .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                               .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                               )),
                    .COVERAGE_T(crop_video_axis_src_transaction_coverage #(
                                .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                                .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                                .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                                )),
                    .TRANS_T(crop_video_axis_src_transaction #(
                             .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                             .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                             .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                             ))
                    );

  `uvm_component_param_utils( crop_video_axis_src_agent #(
                              crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH,
                              crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8,
                              crop_video_axis_src_C_M00_AXIS_START_COUNT
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

