//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This test extends test_top and makes 
//    changes to test_top using the UVM factory type_override:
//
//    Test scenario: 
//      This is a template test that can be used to create future tests.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class AXI_Stream_pattern_test extends test_top;

  `uvm_component_utils( AXI_Stream_pattern_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  
  virtual function void build_phase(uvm_phase phase);
  // Define a type alias for the parameterized sequence
    typedef crop_video_ext_sequence #(
      .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(32),
      .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(4)
    ) crop_video_ext_sequence_32_4;

    crop_video_bench_sequence_base::type_id::set_type_override(crop_video_ext_sequence_32_4::get_type());

    // The factory override below is an example of how to replace the crop_video_bench_sequence_base 
    // sequence with the example_derived_test_sequence.

    // crop_video_bench_sequence_base::type_id::set_type_override(crop_video_ext_sequence(
    //                 .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(32),
    //                 .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(4))::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

