//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   crop_video_axis_snk_agent_ae receives transactions of type  crop_video_axis_snk_transaction #()
//   crop_video_config_agent_ae receives transactions of type  crop_video_config_transaction #()
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  crop_video_sb_ap broadcasts transactions of type crop_video_axis_src_transaction #()
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import server_api_pkg::*;
class crop_video_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( crop_video_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_crop_video_axis_snk_agent_ae #(crop_video_axis_snk_transaction #(), crop_video_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) crop_video_axis_snk_agent_ae;
  uvm_analysis_imp_crop_video_config_agent_ae #(crop_video_config_transaction, crop_video_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) crop_video_config_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(crop_video_axis_src_transaction #()) crop_video_sb_ap;


  // Transaction variable for predicted values to be sent out crop_video_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef crop_video_axis_src_transaction #() crop_video_sb_ap_output_transaction_t;
  crop_video_sb_ap_output_transaction_t crop_video_sb_ap_output_transaction;
  // Code for sending output transaction out through crop_video_sb_ap
  // crop_video_sb_ap.write(crop_video_sb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  crop_video_axis_snk_transaction #() crop_video_axis_snk_agent_ae_debug;
  crop_video_config_transaction crop_video_config_agent_ae_debug;


  // pragma uvmf custom class_item_additional begin
  // Declare the ServerAPI instance
  ServerAPI srv;

  //shared config transaction
  crop_video_config_transaction sct;
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
    srv = new(); 
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    crop_video_axis_snk_agent_ae = new("crop_video_axis_snk_agent_ae", this);
    crop_video_config_agent_ae = new("crop_video_config_agent_ae", this);
    crop_video_sb_ap =new("crop_video_sb_ap", this );
  // pragma uvmf custom build_phase begin
    // Initialize the ServerAPI instance
    srv.init("./port.json", "port_A");
    srv.start();
  // pragma uvmf custom build_phase end
  endfunction

  function string int_to_str(int num);
    automatic string str0 = "";
    string digit_str;
    int digit;
    while(num > 0) begin
        digit = num % 10;
        num = num / 10;
        $sformat(digit_str, "%0d", digit);
        str0 = {digit_str, str0};
    end
    return str0;
  endfunction

  // FUNCTION: write_crop_video_axis_snk_agent_ae
  // Transactions received through crop_video_axis_snk_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_crop_video_axis_snk_agent_ae(crop_video_axis_snk_transaction #() t);
    // pragma uvmf custom crop_video_axis_snk_agent_ae_predictor begin
    json_assoc_t   data_to_send, received_data;
    string res;
    crop_video_axis_snk_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through crop_video_axis_snk_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    crop_video_sb_ap_output_transaction = crop_video_sb_ap_output_transaction_t::type_id::create("crop_video_sb_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    data_to_send["s00_axis_tdata"] = int_to_str(t.s00_axis_tdata);
    data_to_send["s00_axis_tstrb"] = int_to_str(t.s00_axis_tstrb);
    data_to_send["s00_axis_tlast"] = int_to_str(t.s00_axis_tlast);
    data_to_send["s00_axis_tvalid"] = int_to_str(t.s00_axis_tlast);
    data_to_send["s00_axis_tuser"] = int_to_str(t.s00_axis_tuser);
    data_to_send["s00_axis_tready"] = int_to_str(t.s00_axis_tready);
    data_to_send["crop_x"] = int_to_str(sct.crop_x);
    data_to_send["crop_y"] = int_to_str(sct.crop_y);
    data_to_send["crop_width"] = int_to_str(sct.crop_width);
    data_to_send["crop_height"] = int_to_str(sct.crop_height);
    // $display("data_to_send:");
    // $display(data_to_send);
    srv.send(data_to_send);
    `uvm_info("PRED", {"Sent Data: ", data_to_send}, UVM_MEDIUM)

    received_data = srv.receive();
    // $display("received_data:");
    // $display(received_data);
    $sscanf(received_data["m00_axis_tdata"], "%d", crop_video_sb_ap_output_transaction.m00_axis_tdata);
    $sscanf(received_data["m00_axis_tstrb"], "%d", crop_video_sb_ap_output_transaction.m00_axis_tstrb);
    $sscanf(received_data["m00_axis_tlast"], "%d", crop_video_sb_ap_output_transaction.m00_axis_tlast);
    $sscanf(received_data["m00_axis_tlast"], "%d", crop_video_sb_ap_output_transaction.m00_axis_tlast);
    $sscanf(received_data["m00_axis_tuser"], "%d", crop_video_sb_ap_output_transaction.m00_axis_tuser);
    $sscanf(received_data["m00_axis_tready"], "%d",crop_video_sb_ap_output_transaction.m00_axis_tready);
    `uvm_info("PRED", {"Received Data: ", received_data}, UVM_MEDIUM)
    // Code for sending output transaction out through crop_video_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    crop_video_sb_ap.write(crop_video_sb_ap_output_transaction);
    // pragma uvmf custom crop_video_axis_snk_agent_ae_predictor end
  endfunction

  // FUNCTION: write_crop_video_config_agent_ae
  // Transactions received through crop_video_config_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_crop_video_config_agent_ae(crop_video_config_transaction t);
    // pragma uvmf custom crop_video_config_agent_ae_predictor begin
    
    crop_video_config_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through crop_video_config_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    // crop_video_sb_ap_output_transaction = crop_video_sb_ap_output_transaction_t::type_id::create("crop_video_sb_ap_output_transaction");
    
    
    sct = t;
    // Code for sending output transaction out through crop_video_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    // crop_video_sb_ap.write(crop_video_sb_ap_output_transaction);
    // pragma uvmf custom crop_video_config_agent_ae_predictor end
  endfunction

// pragma uvmf custom external begin
virtual function void final_phase(uvm_phase phase);
    // Stop the socket
    srv.stop();
endfunction
// pragma uvmf custom external end
endclass 



