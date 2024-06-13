// ==============================================================================
// =====            Mentor Graphics UK Ltd                                  =====
// =====            Rivergate, London Road, Newbury BERKS RG14 2QB          =====
// ==============================================================================
//! @file
//  Project                : alu_2019_4
//  Unit                   : ALU_random_sequence
//! @brief  Add Class Description Here... 
//-------------------------------------------------------------------------------
//  Created by             : graemej
//  Creation Date          : 2019/09/10
//-------------------------------------------------------------------------------
// Revision History:
//  URL of HEAD            : $HeadURL$
//  Revision of last commit: $Rev$  
//  Author of last commit  : $Author$
//  Date of last commit    : $Date$  
//
// ==============================================================================
// This unpublished work contains proprietary information.
// All right reserved. Supplied in confidence and must not be copied, used or disclosed 
// for any purpose without express written permission.
// 2019 @ Copyright Mentor Graphics UK Ltd
// ==============================================================================


`ifndef __CROP_VIDEO_EXT_SEQUENCE
`define __CROP_VIDEO_EXT_SEQUENCE

`include "uvm_macros.svh"

class crop_video_ext_sequence #(
            int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH = 32,
            int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8 = 4
            ) extends crop_video_bench_sequence_base;

  `uvm_object_utils(crop_video_ext_sequence) 

  // Define type and handle for reset sequence
  typedef crop_video_axis_snk_video_pattern_sequence #(
            crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH,
            crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8
  ) crop_video_axis_snk_video_pattern_sequence_t;
  crop_video_axis_snk_video_pattern_sequence_t crop_video_axis_snk_video_pattern_seq;
  
  // constructor
  function new(string name = "");
    super.new(name);
  endfunction : new

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    // crop_video_env_seq = crop_video_env_sequence_base_t::type_id::create("crop_video_env_seq");
    crop_video_axis_snk_video_pattern_seq = crop_video_axis_snk_video_pattern_sequence#(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH, crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)::type_id::create("crop_video_axis_snk_video_pattern_sequence");
    crop_video_config_agent_random_seq = crop_video_config_agent_random_seq_t::type_id::create("crop_video_config_agent_random_seq");
    crop_video_axis_src_agent_random_seq     = crop_video_axis_src_agent_random_seq_t::type_id::create("crop_video_axis_src_agent_random_seq");

    fork
      crop_video_config_agent_config.wait_for_reset();
      crop_video_axis_snk_agent_config.wait_for_reset();
      crop_video_axis_src_agent_config.wait_for_reset();
    join
    // Start RESPONDER sequences here
    fork
    join_none
    // Start INITIATOR sequences here
    fork
      repeat (25) begin
        crop_video_config_agent_random_seq.start(crop_video_config_agent_sequencer);
        crop_video_axis_src_agent_random_seq.start(crop_video_axis_src_agent_sequencer);
        crop_video_axis_snk_video_pattern_seq.start(crop_video_axis_snk_agent_sequencer);
        
      end
    join

// crop_video_env_seq.start(top_configuration.vsqr);

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    fork
      crop_video_config_agent_config.wait_for_num_clocks(400);
      crop_video_axis_snk_agent_config.wait_for_num_clocks(400);
      crop_video_axis_src_agent_config.wait_for_num_clocks(400);
    join

    // pragma uvmf custom body end
  endtask


endclass : crop_video_ext_sequence

`endif
