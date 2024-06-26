//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: This package contains all tests currently written for
//     the simulation project.  Once compiled, any test can be selected
//     from the vsim command line using +UVM_TESTNAME=yourTestNameHere
//
// CONTAINS:
//     -<test_top>
//     -<example_derived_test>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

package crop_video_tests_pkg;

   import uvm_pkg::*;
   import uvmf_base_pkg::*;
   import crop_video_parameters_pkg::*;
   import crop_video_env_pkg::*;
   import crop_video_sequences_pkg::*;
   import crop_video_config_pkg::*;
   import crop_video_config_pkg_hdl::*;
   import crop_video_axis_snk_pkg::*;
   import crop_video_axis_snk_pkg_hdl::*;
   import crop_video_axis_src_pkg::*;
   import crop_video_axis_src_pkg_hdl::*;


   `include "uvm_macros.svh"

  // pragma uvmf custom package_imports_additional begin 
  // pragma uvmf custom package_imports_additional end

  `include "src/test_top.svh"
  `include "src/register_test.svh"
  `include "src/example_derived_test.svh"
  `include "src/AXI_Stream_pattern_test.svh"
  
  // pragma uvmf custom package_item_additional begin
  // UVMF_CHANGE_ME : When adding new tests to the src directory
  //    be sure to add the test file here so that it will be
  //    compiled as part of the test package.  Be sure to place
  //    the new test after any base tests of the new test.
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

