//----------------------------------------------------------------------
// Created with uvmf_gen version 2020.2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the ALU_in transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a ALU_in_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_axis_snk_video_pattern_sequence #(
      int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH = 32,
      int crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8 = 4
      )
  extends crop_video_axis_snk_sequence_base #(
      .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
      .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
      );

  `uvm_object_param_utils( crop_video_axis_snk_video_pattern_sequence #(
                           crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH,
                           crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8
                           ))

  // pragma uvmf custom class_item_additional begin
    typedef enum {SOLID_COLOR, CHECKERBOARD, GRADIENT} pattern_t;
    
    // Parameters
    rand pattern_t pattern_type;
    rand int unsigned frame_width;
    rand int unsigned frame_height;
    rand bit [31:0] color;
  // pragma uvmf custom class_item_additional end
  
  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

  // ****************************************************************************

  virtual function void generate_solid_color(ref crop_video_axis_snk_transaction req, bit [31:0] color);
    req.s00_axis_tdata = color;
  endfunction

  virtual function void generate_checkerboard(ref crop_video_axis_snk_transaction req, int x, int y);
    req.s00_axis_tdata = ((x % 2) ^ (y % 2)) ? 32'hFFFFFFFF : 32'h00000000;
  endfunction

  virtual function void generate_gradient(ref crop_video_axis_snk_transaction req, int x, int y);
    req.s00_axis_tdata = (x + y) & 32'hFFFFFFFF;
  endfunction

  virtual task body();
    int frame_count = 10;  // Number of frames to send

    if (!uvm_config_db#(int unsigned)::get(null, "", "frame_width", frame_width))
      frame_width = 1920;   // Default frame width
    if (!uvm_config_db#(int unsigned)::get(null, "", "frame_height", frame_height))
      frame_height = 1080;  // Default frame height
    if (!uvm_config_db#(pattern_t)::get(null, "", "pattern_type", pattern_type))
      pattern_type = CHECKERBOARD;  // Default pattern
    if (!uvm_config_db#(bit [31:0])::get(null, "", "color", color))
      color = 32'hFF00FF00;  // Default color for solid color pattern
    // Construct the transaction
    
    

    for (int frame = 0; frame < frame_count; frame++) begin
      for (int y = 0; y < frame_height; y++) begin
        for (int x = 0; x < frame_width; x++) begin
          req=crop_video_axis_snk_transaction#(
              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
              )::type_id::create("req");

          // Select pattern based on the pattern type
          case (pattern_type)
            SOLID_COLOR: generate_solid_color(req, color);
            CHECKERBOARD: generate_checkerboard(req, x, y);
            GRADIENT: generate_gradient(req, x, y);
          endcase

          req.s00_axis_tvalid = 1;
          req.s00_axis_tlast = (x == frame_width - 1) ? 1 : 0;
          req.s00_axis_tuser = (x == 0 && y == 0) ? 1 : 0;

          start_item(req);
          finish_item(req);
          `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
        end
      end
    end
  endtask
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  // task body();
  //   begin
  //     // Construct the transaction
  //     req=crop_video_axis_snk_transaction#(
  //               .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
  //               .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
  //               )::type_id::create("req");
  //     start_item(req);
  //     // Randomize the transaction
  //     if(!req.randomize()) `uvm_fatal("SEQ", "crop_video_axis_snk_video_pattern_sequence::body()-ALU_in_transaction randomization failed")
  //     // set the operation to be a reset
  //     req.op = rst_op;
  //     // Send the transaction to the ALU_in_driver_bfm via the sequencer and ALU_in_driver.
  //     finish_item(req);
  //     `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
  //   end

  // endtask

endclass: crop_video_axis_snk_video_pattern_sequence
