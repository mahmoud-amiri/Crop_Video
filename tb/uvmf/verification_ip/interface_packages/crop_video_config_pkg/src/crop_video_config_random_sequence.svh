//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the crop_video_config transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a crop_video_config_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_config_random_sequence 
  extends crop_video_config_sequence_base ;

  `uvm_object_utils( crop_video_config_random_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

  // ****************************************************************************
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  task body();
  
      // Construct the transaction
      req=crop_video_config_transaction::type_id::create("req");
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "crop_video_config_random_sequence::body()-crop_video_config_transaction randomization failed")
      // Send the transaction to the crop_video_config_driver_bfm via the sequencer and crop_video_config_driver.
      req.crop_x = 0;
      req.crop_y = 0;
      req.crop_width = 10;
      req.crop_height = 10;
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)

  endtask

endclass: crop_video_config_random_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

