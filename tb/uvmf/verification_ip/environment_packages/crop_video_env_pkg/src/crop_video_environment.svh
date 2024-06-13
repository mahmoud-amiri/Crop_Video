//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class crop_video_environment  extends uvmf_environment_base #(
    .CONFIG_T( crop_video_env_configuration 
  ));
  `uvm_component_utils( crop_video_environment )





  typedef crop_video_config_agent  crop_video_config_agent_t;
  crop_video_config_agent_t crop_video_config_agent;

  typedef crop_video_axis_snk_agent  crop_video_axis_snk_agent_t;
  crop_video_axis_snk_agent_t crop_video_axis_snk_agent;

  typedef crop_video_axis_src_agent  crop_video_axis_src_agent_t;
  crop_video_axis_src_agent_t crop_video_axis_src_agent;




  typedef crop_video_predictor #(
                .CONFIG_T(CONFIG_T)
                ) crop_video_pred_t;
  crop_video_pred_t crop_video_pred;

  typedef uvmf_in_order_scoreboard #(.T(crop_video_axis_src_transaction))  crop_video_sb_t;
  crop_video_sb_t crop_video_sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(crop_video_env_configuration)) crop_video_vsqr_t;
  crop_video_vsqr_t vsqr;

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
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    crop_video_config_agent = crop_video_config_agent_t::type_id::create("crop_video_config_agent",this);
    crop_video_config_agent.set_config(configuration.crop_video_config_agent_config);
    crop_video_axis_snk_agent = crop_video_axis_snk_agent_t::type_id::create("crop_video_axis_snk_agent",this);
    crop_video_axis_snk_agent.set_config(configuration.crop_video_axis_snk_agent_config);
    crop_video_axis_src_agent = crop_video_axis_src_agent_t::type_id::create("crop_video_axis_src_agent",this);
    crop_video_axis_src_agent.set_config(configuration.crop_video_axis_src_agent_config);
    crop_video_pred = crop_video_pred_t::type_id::create("crop_video_pred",this);
    crop_video_pred.configuration = configuration;
    crop_video_sb = crop_video_sb_t::type_id::create("crop_video_sb",this);

    vsqr = crop_video_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    crop_video_config_agent.monitored_ap.connect(crop_video_pred.crop_video_config_agent_ae);
    crop_video_axis_snk_agent.monitored_ap.connect(crop_video_pred.crop_video_axis_snk_agent_ae);
    crop_video_pred.crop_video_sb_ap.connect(crop_video_sb.expected_analysis_export);
    crop_video_axis_src_agent.monitored_ap.connect(crop_video_sb.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase() 
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.crop_video_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

