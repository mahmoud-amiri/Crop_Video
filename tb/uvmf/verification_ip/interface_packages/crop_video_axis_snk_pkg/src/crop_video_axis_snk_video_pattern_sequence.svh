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
    typedef enum {SOLID_COLOR, CHECKERBOARD, GRADIENT, COUNTER} pattern_t;
    
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

  virtual function void generate_counter(ref crop_video_axis_snk_transaction req, int x, int y);
    req.s00_axis_tdata = x & 32'hFFFFFFFF;
  endfunction

  virtual task body();
    int frame_count = 1;  // Number of frames to send

    if (!uvm_config_db#(int unsigned)::get(null, "", "frame_width", frame_width))
      frame_width = 10;//1920;   // Default frame width
    if (!uvm_config_db#(int unsigned)::get(null, "", "frame_height", frame_height))
      frame_height = 10;//1080;  // Default frame height
    if (!uvm_config_db#(pattern_t)::get(null, "", "pattern_type", pattern_type))
      pattern_type = COUNTER;  // Default pattern
    if (!uvm_config_db#(bit [31:0])::get(null, "", "color", color))
      color = 32'hFF00FF00;  // Default color for solid color pattern
    // Construct the transaction
    
    `uvm_info("SEQ", "Starting sequence Video Pattern", UVM_LOW)

    for (int frame = 0; frame < frame_count; frame++) begin
      for (int y = 0; y < frame_height; y++) begin
        for (int x = 0; x < frame_width; x++) begin
          req=crop_video_axis_snk_transaction#(
              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH),
              .crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8(crop_video_axis_snk_C_S00_AXIS_TDATA_WIDTH_8)
              )::type_id::create("req");

          // Select pattern based on the pattern type
          // wait(req.s00_axis_tready);

          case (pattern_type)
            SOLID_COLOR: generate_solid_color(req, color);
            CHECKERBOARD: generate_checkerboard(req, x, y);
            GRADIENT: generate_gradient(req, x, y);
            COUNTER: generate_counter(req, x, y);
          endcase

          req.s00_axis_tvalid = 1'b1;
          req.s00_axis_tlast = (x == frame_width - 1) ? 1'b1 : 1'b0;
          req.s00_axis_tuser = (x == 0 && y == 0) ? 1'b1 : 1'b0;

          // start_item(req);
          // finish_item(req);
          // `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
          start_item(req);
          `uvm_info("SEQ", $sformatf("Starting item: Frame=%0d, X=%0d, Y=%0d, Data=%0h", frame, x, y, req.s00_axis_tdata), UVM_MEDIUM)
          finish_item(req);
          `uvm_info("SEQ", $sformatf("Finished item: Frame=%0d, X=%0d, Y=%0d, Data=%0h", frame, x, y, req.s00_axis_tdata), UVM_MEDIUM)

          // Wait for driver to be ready
          wait_for_tready(req);
        end
      end
      `uvm_info("SEQ", "Sequence completed Video Pattern", UVM_LOW)
    end
  endtask

  virtual task wait_for_tready(crop_video_axis_snk_transaction req);
    forever begin
      if (req.s00_axis_tready == 1'b1) begin
        `uvm_info("SEQ", "tready is high, proceeding to next item", UVM_LOW)
        break;
      end
      else begin
        `uvm_info("SEQ", "tready is low, waiting", UVM_LOW)
        #10;  // Wait for some time before checking again
      end
    end
  endtask


endclass: crop_video_axis_snk_video_pattern_sequence
