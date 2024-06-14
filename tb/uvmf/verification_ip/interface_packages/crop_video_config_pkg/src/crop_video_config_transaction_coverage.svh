//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records crop_video_config transaction information using
//       a covergroup named crop_video_config_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_config_transaction_coverage  extends uvm_subscriber #(.T(crop_video_config_transaction ));

  `uvm_component_utils( crop_video_config_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  int min_x;
  int max_x;
  int min_y;
  int max_y;

// Constructor

  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup crop_video_config_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    crop_x: coverpoint coverage_trans.crop_x{
      bins min_bin = {min_x};
      bins max_bin = {max_x};
      bins range1  = {[min_x + 1 : (min_x + (max_x - min_x)/4)]};
      bins range2  = {[(min_x + (max_x - min_x)/4 + 1) : (min_x + (max_x - min_x)/2)]};
      bins range3  = {[(min_x + (max_x - min_x)/2 + 1) : (min_x + 3*(max_x - min_x)/4)]};
      bins range4  = {[(min_x + 3*(max_x - min_x)/4 + 1) : (max_x - 1)]};
    }

    crop_y: coverpoint coverage_trans.crop_y{
      bins min_bin = {min_y};
      bins max_bin = {max_y};
      bins range1  = {[min_y + 1 : (min_y + (max_y - min_y)/4)]};
      bins range2  = {[(min_y + (max_y - min_y)/4 + 1) : (min_y + (max_y - min_y)/2)]};
      bins range3  = {[(min_y + (max_y - min_y)/2 + 1) : (min_y + 3*(max_y - min_y)/4)]};
      bins range4  = {[(min_y + 3*(max_y - min_y)/4 + 1) : (max_y - 1)]};
    }

    crop_width: coverpoint coverage_trans.crop_width{
      bins min_bin = {min_x};
      bins max_bin = {max_x};
      bins range1  = {[min_x + 1 : (min_x + (max_x - min_x)/4)]};
      bins range2  = {[(min_x + (max_x - min_x)/4 + 1) : (min_x + (max_x - min_x)/2)]};
      bins range3  = {[(min_x + (max_x - min_x)/2 + 1) : (min_x + 3*(max_x - min_x)/4)]};
      bins range4  = {[(min_x + 3*(max_x - min_x)/4 + 1) : (max_x - 1)]};
    }

    crop_height: coverpoint coverage_trans.crop_height{
      bins min_bin = {min_y};
      bins max_bin = {max_y};
      bins range1  = {[min_y + 1 : (min_y + (max_y - min_y)/4)]};
      bins range2  = {[(min_y + (max_y - min_y)/4 + 1) : (min_y + (max_y - min_y)/2)]};
      bins range3  = {[(min_y + (max_y - min_y)/2 + 1) : (min_y + 3*(max_y - min_y)/4)]};
      bins range4  = {[(min_y + 3*(max_y - min_y)/4 + 1) : (max_y - 1)]};
    }


    // Define cross coverage
    cross_crop_x_y: cross crop_x, crop_y;
    cross_crop_width_height: cross crop_width, crop_height;
    cross_all: cross crop_x, crop_y, crop_width, crop_height;

    
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
    function new(string name, uvm_component parent, int min_x = 0, int max_x = 1920, int min_y = 0, int max_y = 1080);
    super.new(name, parent);
    this.min_x = min_x;
    this.max_x = max_x;
    this.min_y = min_y;
    this.max_y = max_y;
    crop_video_config_transaction_cg = new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    crop_video_config_transaction_cg.set_inst_name($sformatf("crop_video_config_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    crop_video_config_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

