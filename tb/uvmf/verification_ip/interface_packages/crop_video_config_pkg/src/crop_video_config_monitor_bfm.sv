//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the crop_video_config signal monitoring.
//      It is accessed by the uvm crop_video_config monitor through a virtual
//      interface handle in the crop_video_config configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type crop_video_config_if.
//
//     Input signals from the crop_video_config_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the crop_video_config bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import crop_video_config_pkg_hdl::*;
`include "src/crop_video_config_macros.svh"


interface crop_video_config_monitor_bfm 
  ( crop_video_config_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute crop_video_config_monitor_bfm partition_interface_xif                                  

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
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`crop_video_config_MONITOR_STRUCT
  crop_video_config_monitor_s crop_video_config_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `crop_video_config_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clk_i;
  tri rst_i;
  tri [15:0] crop_x_i;
  tri [15:0] crop_y_i;
  tri [15:0] crop_width_i;
  tri [15:0] crop_height_i;
  assign clk_i = bus.clk;
  assign rst_i = bus.rst;
  assign crop_x_i = bus.crop_x;
  assign crop_y_i = bus.crop_y;
  assign crop_width_i = bus.crop_width;
  assign crop_height_i = bus.crop_height;

  // Proxy handle to UVM monitor
  crop_video_config_pkg::crop_video_config_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clk_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( rst_i === 1 ) ;                                                              
    @(posedge clk_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clk_i);  
                                                                   
    repeat (count-1) @(posedge clk_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clk_i);  
      do_monitor( crop_video_config_monitor_struct );
                                                                 
 
      proxy.notify_transaction( crop_video_config_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(crop_video_config_configuration_s crop_video_config_configuration_arg); // pragma tbx xtf  
    initiator_responder = crop_video_config_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output crop_video_config_monitor_s crop_video_config_monitor_struct);
    //
    // Available struct members:
    //     //    crop_video_config_monitor_struct.crop_x
    //     //    crop_video_config_monitor_struct.crop_y
    //     //    crop_video_config_monitor_struct.crop_width
    //     //    crop_video_config_monitor_struct.crop_height
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clk_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      crop_video_config_monitor_struct.xyz = crop_x_i;  //    [15:0] 
    //      crop_video_config_monitor_struct.xyz = crop_y_i;  //    [15:0] 
    //      crop_video_config_monitor_struct.xyz = crop_width_i;  //    [15:0] 
    //      crop_video_config_monitor_struct.xyz = crop_height_i;  //    [15:0] 
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

