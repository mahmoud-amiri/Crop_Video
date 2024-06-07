class video_stream_test extends uvm_test;
  `uvm_component_utils(video_stream_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Configure the sequence parameters
    video_stream_seq seq = video_stream_seq::type_id::create("seq");
    uvm_config_db#(int unsigned)::set(null, "seq", "frame_width", 1280);
    uvm_config_db#(int unsigned)::set(null, "seq", "frame_height", 720);
    uvm_config_db#(int unsigned)::set(null, "seq", "frame_count", 5);
    uvm_config_db#(video_stream_seq::pattern_t)::set(null, "seq", "pattern_type", video_stream_seq::CHECKERBOARD);
    uvm_config_db#(bit [31:0])::set(null, "seq", "color", 32'hFF00FF00); // Example color for solid color pattern

    seq.start(m_sequencer);

    phase.drop_objection(this);
  endtask
endclass
