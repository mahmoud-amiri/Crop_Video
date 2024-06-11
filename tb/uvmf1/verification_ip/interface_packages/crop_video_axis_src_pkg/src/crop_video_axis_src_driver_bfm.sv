//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the crop_video_axis_src signal driving.  It is
//     accessed by the uvm crop_video_axis_src driver through a virtual interface
//     handle in the crop_video_axis_src configuration.  It drives the singals passed
//     in through the port connection named bus of type crop_video_axis_src_if.
//
//     Input signals from the crop_video_axis_src_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within crop_video_axis_src_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:
//
//             configure:
//                   This function gets configuration attributes from the
//                   UVM driver to set any required BFM configuration
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             initiate_and_get_response:
//                   This task is used to perform signaling activity for initiating
//                   a protocol transfer.  The task initiates the transfer, using
//                   input data from the initiator struct.  Then the task captures
//                   response data, placing the data into the response struct.
//                   The response struct is returned to the driver class.
//
//             respond_and_wait_for_next_transfer:
//                   This task is used to complete a current transfer as a responder
//                   and then wait for the initiator to start the next transfer.
//                   The task uses data in the responder struct to drive protocol
//                   signals to complete the transfer.  The task then waits for 
//                   the next transfer.  Once the next transfer begins, data from
//                   the initiator is placed into the initiator struct and sent
//                   to the responder sequence for processing to determine 
//                   what data to respond with.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import crop_video_axis_src_pkg_hdl::*;
`include "src/crop_video_axis_src_macros.svh"

interface crop_video_axis_src_driver_bfm #(
  int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH = 32,
  int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8 = 4,
  int crop_video_axis_src_C_M00_AXIS_START_COUNT = 32
  )
  (crop_video_axis_src_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute crop_video_axis_src_driver_bfm partition_interface_xif

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH=%x crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8=%x crop_video_axis_src_C_M00_AXIS_START_COUNT=%x ", crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH,crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8,crop_video_axis_src_C_M00_AXIS_START_COUNT),
      UVM_DEBUG)
end
`endif

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clk_i;
  tri rst_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals
  tri  m00_axis_tvalid_i;
  reg  m00_axis_tvalid_o = 'b0;
  tri  m00_axis_tlast_i;
  reg  m00_axis_tlast_o = 'b0;
  tri  m00_axis_tuser_i;
  reg  m00_axis_tuser_o = 'b0;
  tri [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata_i;
  reg [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata_o = 'b0;
  tri [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb_i;
  reg [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb_o = 'b0;

  // INITIATOR mode output signals
  tri  m00_axis_aclk_i;
  reg  m00_axis_aclk_o = 'b0;
  tri  m00_axis_aresetn_i;
  reg  m00_axis_aresetn_o = 'b0;
  tri  m00_axis_tready_i;
  reg  m00_axis_tready_o = 'b0;

  // Bi-directional signals
  

  assign clk_i = bus.clk;
  assign rst_i = bus.rst;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)
  assign m00_axis_tvalid_i = bus.m00_axis_tvalid;
  assign bus.m00_axis_tvalid = (initiator_responder == RESPONDER) ? m00_axis_tvalid_o : 'bz;
  assign m00_axis_tlast_i = bus.m00_axis_tlast;
  assign bus.m00_axis_tlast = (initiator_responder == RESPONDER) ? m00_axis_tlast_o : 'bz;
  assign m00_axis_tuser_i = bus.m00_axis_tuser;
  assign bus.m00_axis_tuser = (initiator_responder == RESPONDER) ? m00_axis_tuser_o : 'bz;
  assign m00_axis_tdata_i = bus.m00_axis_tdata;
  assign bus.m00_axis_tdata = (initiator_responder == RESPONDER) ? m00_axis_tdata_o : 'bz;
  assign m00_axis_tstrb_i = bus.m00_axis_tstrb;
  assign bus.m00_axis_tstrb = (initiator_responder == RESPONDER) ? m00_axis_tstrb_o : 'bz;


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.m00_axis_aclk = (initiator_responder == INITIATOR) ? m00_axis_aclk_o : 'bz;
  assign m00_axis_aclk_i = bus.m00_axis_aclk;
  assign bus.m00_axis_aresetn = (initiator_responder == INITIATOR) ? m00_axis_aresetn_o : 'bz;
  assign m00_axis_aresetn_i = bus.m00_axis_aresetn;
  assign bus.m00_axis_tready = (initiator_responder == INITIATOR) ? m00_axis_tready_o : 'bz;
  assign m00_axis_tready_i = bus.m00_axis_tready;

  // Proxy handle to UVM driver
  crop_video_axis_src_pkg::crop_video_axis_src_driver #(
    .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
    .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
    .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
    )  proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in crop_video_axis_src_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from crop_video_axis_src_driver to this BFM
  // ****************************************************************************
  `crop_video_axis_src_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by crop_video_axis_src_driver and crop_video_axis_src_driver_bfm
  // to communicate initiator driven data to crop_video_axis_src_driver_bfm.           
  `crop_video_axis_src_INITIATOR_STRUCT
    crop_video_axis_src_initiator_s initiator_struct;
  // Responder macro used by crop_video_axis_src_driver and crop_video_axis_src_driver_bfm
  // to communicate Responder driven data to crop_video_axis_src_driver_bfm.
  `crop_video_axis_src_RESPONDER_STRUCT
    crop_video_axis_src_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( negedge rst_i )
     begin
       // RESPONDER mode output signals
       m00_axis_tvalid_o <= 'b0;
       m00_axis_tlast_o <= 'b0;
       m00_axis_tuser_o <= 'b0;
       m00_axis_tdata_o <= 'b0;
       m00_axis_tstrb_o <= 'b0;
       // INITIATOR mode output signals
       m00_axis_aclk_o <= 'b0;
       m00_axis_aresetn_o <= 'b0;
       m00_axis_tready_o <= 'b0;
       // Bi-directional signals
 
     end    
// pragma uvmf custom reset_condition_and_response end

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //

  function void configure(crop_video_axis_src_configuration_s crop_video_axis_src_configuration_arg); // pragma tbx xtf  
    initiator_responder = crop_video_axis_src_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction                                                                             

// pragma uvmf custom initiate_and_get_response begin
// ****************************************************************************
// UVMF_CHANGE_ME
// This task is used by an initator.  The task first initiates a transfer then
// waits for the responder to complete the transfer.
    task initiate_and_get_response( 
       // This argument passes transaction variables used by an initiator
       // to perform the initial part of a protocol transfer.  The values
       // come from a sequence item created in a sequence.
       input crop_video_axis_src_initiator_s crop_video_axis_src_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output crop_video_axis_src_responder_s crop_video_axis_src_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the crop_video_axis_src_initiator_struct:
       //   bit m00_axis_tready ;
       //   bit m00_axis_tvalid ;
       //   bit m00_axis_tlast ;
       //   bit m00_axis_tuser ;
       //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ;
       //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ;
       // Members within the crop_video_axis_src_responder_struct:
       //   bit m00_axis_tready ;
       //   bit m00_axis_tvalid ;
       //   bit m00_axis_tlast ;
       //   bit m00_axis_tuser ;
       //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ;
       //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ;
       initiator_struct = crop_video_axis_src_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clk_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //      crop_video_axis_src_responder_struct.xyz = m00_axis_tvalid_i;  //     
       //      crop_video_axis_src_responder_struct.xyz = m00_axis_tlast_i;  //     
       //      crop_video_axis_src_responder_struct.xyz = m00_axis_tuser_i;  //     
       //      crop_video_axis_src_responder_struct.xyz = m00_axis_tdata_i;  //    [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] 
       //      crop_video_axis_src_responder_struct.xyz = m00_axis_tstrb_i;  //    [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] 
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //      m00_axis_aclk_o <= crop_video_axis_src_initiator_struct.xyz;  //     
       //      m00_axis_aresetn_o <= crop_video_axis_src_initiator_struct.xyz;  //     
       //      m00_axis_tready_o <= crop_video_axis_src_initiator_struct.xyz;  //     
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clk_i);
    @(posedge clk_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // crop_video_axis_src_responder_struct.
    @(posedge clk_i);
    @(posedge clk_i);
    responder_struct = crop_video_axis_src_responder_struct;
  endtask        
// pragma uvmf custom initiate_and_get_response end

// pragma uvmf custom respond_and_wait_for_next_transfer begin
// ****************************************************************************
// The first_transfer variable is used to prevent completing a transfer in the 
// first call to this task.  For the first call to this task, there is not
// current transfer to complete.
bit first_transfer=1;

// UVMF_CHANGE_ME
// This task is used by a responder.  The task first completes the current 
// transfer in progress then waits for the initiator to start the next transfer.
  task respond_and_wait_for_next_transfer( 
       // This argument is used to send data received from the initiator
       // back to the sequence item.  The sequence determines how to respond.
       output crop_video_axis_src_initiator_s crop_video_axis_src_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input crop_video_axis_src_responder_s crop_video_axis_src_responder_struct 
       );// pragma tbx xtf   
  // Variables within the crop_video_axis_src_initiator_struct:
  //   bit m00_axis_tready ;
  //   bit m00_axis_tvalid ;
  //   bit m00_axis_tlast ;
  //   bit m00_axis_tuser ;
  //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ;
  //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ;
  // Variables within the crop_video_axis_src_responder_struct:
  //   bit m00_axis_tready ;
  //   bit m00_axis_tvalid ;
  //   bit m00_axis_tlast ;
  //   bit m00_axis_tuser ;
  //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ;
  //   bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clk_i);
       //    
       //    How to assign a initiator struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      crop_video_axis_src_initiator_struct.xyz = m00_axis_aclk_i;  //     
       //      crop_video_axis_src_initiator_struct.xyz = m00_axis_aresetn_i;  //     
       //      crop_video_axis_src_initiator_struct.xyz = m00_axis_tready_i;  //     
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an responder struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //      m00_axis_tvalid_o <= crop_video_axis_src_responder_struct.xyz;  //     
       //      m00_axis_tlast_o <= crop_video_axis_src_responder_struct.xyz;  //     
       //      m00_axis_tuser_o <= crop_video_axis_src_responder_struct.xyz;  //     
       //      m00_axis_tdata_o <= crop_video_axis_src_responder_struct.xyz;  //    [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] 
       //      m00_axis_tstrb_o <= crop_video_axis_src_responder_struct.xyz;  //    [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] 
       //    Responder inout signals
    
  @(posedge clk_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the crop_video_axis_src_responder_struct.
    @(posedge clk_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clk_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the crop_video_axis_src_initiator_struct.
    @(posedge clk_i);
    @(posedge clk_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

