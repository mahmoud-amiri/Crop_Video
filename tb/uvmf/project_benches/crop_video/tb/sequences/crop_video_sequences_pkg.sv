//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: This package includes all high level sequence classes used 
//     in the environment.  These include utility sequences and top
//     level sequences.
//
// CONTAINS:
//     -<crop_video_sequence_base>
//     -<example_derived_test_sequence>
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//

package crop_video_sequences_pkg;
  import uvm_pkg::*;
  import uvmf_base_pkg::*;
  import crop_video_config_pkg::*;
  import crop_video_config_pkg_hdl::*;
  import crop_video_axis_snk_pkg::*;
  import crop_video_axis_snk_pkg_hdl::*;
  import crop_video_axis_src_pkg::*;
  import crop_video_axis_src_pkg_hdl::*;
  import crop_video_parameters_pkg::*;
  import crop_video_env_pkg::*;
  `include "uvm_macros.svh"



  // pragma uvmf custom package_imports_additional begin
  // pragma uvmf custom package_imports_additional end

  `include "src/crop_video_bench_sequence_base.svh"
  `include "src/register_test_sequence.svh"
  `include "src/example_derived_test_sequence.svh"

  // pragma uvmf custom package_item_additional begin
  // UVMF_CHANGE_ME : When adding new sequences to the src directory
  //    be sure to add the sequence file here so that it will be
  //    compiled as part of the sequence package.  Be sure to place
  //    the new sequence after any base sequences of the new sequence.
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

