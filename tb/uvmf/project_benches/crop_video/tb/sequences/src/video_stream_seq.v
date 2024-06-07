class video_stream_seq extends uvm_sequence #(video_seq_item);
  `uvm_object_utils(video_stream_seq)

  // Define pattern types as an enumeration
  typedef enum {SOLID_COLOR, CHECKERBOARD, GRADIENT} pattern_t;
  
  // Parameters
  rand pattern_t pattern_type;
  rand int unsigned frame_width;
  rand int unsigned frame_height;
  rand int unsigned frame_count;
  rand bit [31:0] color;

  // Constructor
  function new(string name = "video_stream_seq");
    super.new(name);
  endfunction

  // Generate solid color pattern
  virtual function void generate_solid_color(ref video_seq_item req, bit [31:0] color);
    req.tdata = color;
  endfunction

  // Generate checkerboard pattern
  virtual function void generate_checkerboard(ref video_seq_item req, int x, int y);
    req.tdata = ((x % 2) ^ (y % 2)) ? 32'hFFFFFFFF : 32'h00000000;
  endfunction

  // Generate gradient pattern
  virtual function void generate_gradient(ref video_seq_item req, int x, int y);
    req.tdata = (x + y) & 32'hFFFFFFFF;
  endfunction

  virtual task body();
    video_seq_item req;

    if (!uvm_config_db#(int unsigned)::get(this, "", "frame_width", frame_width))
      frame_width = 1920;   // Default frame width
    if (!uvm_config_db#(int unsigned)::get(this, "", "frame_height", frame_height))
      frame_height = 1080;  // Default frame height
    if (!uvm_config_db#(int unsigned)::get(this, "", "frame_count", frame_count))
      frame_count = 10;     // Default frame count

    for (int frame = 0; frame < frame_count; frame++) begin
      for (int y = 0; y < frame_height; y++) begin
        for (int x = 0; x < frame_width; x++) begin
          req = video_seq_item::type_id::create("req");

          // Select pattern based on the pattern type
          case (pattern_type)
            SOLID_COLOR: generate_solid_color(req, color);
            CHECKERBOARD: generate_checkerboard(req, x, y);
            GRADIENT: generate_gradient(req, x, y);
          endcase

          req.tvalid = 1;
          req.tlast = (x == frame_width - 1) ? 1 : 0;
          req.tuser = (x == 0 && y == 0) ? 1 : 0;

          start_item(req);
          finish_item(req);
        end
      end
    end
  endtask
endclass
