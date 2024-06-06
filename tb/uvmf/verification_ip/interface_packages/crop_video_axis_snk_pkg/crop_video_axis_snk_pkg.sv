//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <crop_video_axis_snk_typedefs_hdl>
//    - <crop_video_axis_snk_typedefs.svh>
//    - <crop_video_axis_snk_transaction.svh>

//    - <crop_video_axis_snk_configuration.svh>
//    - <crop_video_axis_snk_driver.svh>
//    - <crop_video_axis_snk_monitor.svh>

//    - <crop_video_axis_snk_transaction_coverage.svh>
//    - <crop_video_axis_snk_sequence_base.svh>
//    - <crop_video_axis_snk_random_sequence.svh>

//    - <crop_video_axis_snk_responder_sequence.svh>
//    - <crop_video_axis_snk2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package crop_video_axis_snk_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import crop_video_axis_snk_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/crop_video_axis_snk_macros.svh"

   export crop_video_axis_snk_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/crop_video_axis_snk_typedefs.svh"
   `include "src/crop_video_axis_snk_transaction.svh"

   `include "src/crop_video_axis_snk_configuration.svh"
   `include "src/crop_video_axis_snk_driver.svh"
   `include "src/crop_video_axis_snk_monitor.svh"

   `include "src/crop_video_axis_snk_transaction_coverage.svh"
   `include "src/crop_video_axis_snk_sequence_base.svh"
   `include "src/crop_video_axis_snk_random_sequence.svh"

   `include "src/crop_video_axis_snk_responder_sequence.svh"
   `include "src/crop_video_axis_snk2reg_adapter.svh"

   `include "src/crop_video_axis_snk_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

