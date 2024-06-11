//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    environment package that will run on the host simulator.
//
// CONTAINS:
//     - <crop_video_configuration.svh>
//     - <crop_video_environment.svh>
//     - <crop_video_env_sequence_base.svh>
//     - <crop_video_predictor.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package crop_video_env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import uvmf_base_pkg::*;
  import crop_video_config_pkg::*;
  import crop_video_config_pkg_hdl::*;
  import crop_video_axis_snk_pkg::*;
  import crop_video_axis_snk_pkg_hdl::*;
  import crop_video_axis_src_pkg::*;
  import crop_video_axis_src_pkg_hdl::*;
 
  `uvm_analysis_imp_decl(_crop_video_axis_snk_agent_ae)
  `uvm_analysis_imp_decl(_crop_video_config_agent_ae)

  // pragma uvmf custom package_imports_additional begin
  // pragma uvmf custom package_imports_additional end

  // Parameters defined as HVL parameters

  `include "src/crop_video_env_typedefs.svh"
  `include "src/crop_video_env_configuration.svh"
  `include "src/crop_video_predictor.svh"
  `include "src/crop_video_environment.svh"
  `include "src/crop_video_env_sequence_base.svh"

  // pragma uvmf custom package_item_additional begin
  // UVMF_CHANGE_ME : When adding new environment level sequences to the src directory
  //    be sure to add the sequence file here so that it will be
  //    compiled as part of the environment package.  Be sure to place
  //    the new sequence after any base sequence of the new sequence.
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

