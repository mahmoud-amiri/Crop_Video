//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains the UVM register adapter for the crop_video_axis_src interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_axis_src2reg_adapter #(
      int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH = 32,
      int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8 = 4,
      int crop_video_axis_src_C_M00_AXIS_START_COUNT = 32
      ) extends uvm_reg_adapter;

  `uvm_object_param_utils( crop_video_axis_src2reg_adapter #(
                           crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH,
                           crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8,
                           crop_video_axis_src_C_M00_AXIS_START_COUNT
                           ))
  
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //--------------------------------------------------------------------
  // new
  //--------------------------------------------------------------------
  function new (string name = "crop_video_axis_src2reg_adapter" );
    super.new(name);
    // pragma uvmf custom new begin
    // UVMF_CHANGE_ME : Configure the adapter regarding byte enables and provides response.

    // Does the protocol the Agent is modeling support byte enables?
    // 0 = NO
    // 1 = YES
    supports_byte_enable = 0;

    // Does the Agent's Driver provide separate response sequence items?
    // i.e. Does the driver call seq_item_port.put() 
    // and do the sequences call get_response()?
    // 0 = NO
    // 1 = YES
    provides_responses = 0;
    // pragma uvmf custom new end

  endfunction: new

  //--------------------------------------------------------------------
  // reg2bus
  //--------------------------------------------------------------------
  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

    crop_video_axis_src_transaction #(
                    .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                    .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                    .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                    ) trans_h = crop_video_axis_src_transaction #(
                             .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
                             .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
                             .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
                             )::type_id::create("trans_h");
    
    // pragma uvmf custom reg2bus begin
    // UVMF_CHANGE_ME : Fill in the reg2bus adapter mapping registe fields to protocol fields.

    //Adapt the following for your sequence item type
    // trans_h.op = (rw.kind == UVM_READ) ? WB_READ : WB_WRITE;
    //Copy over address
    // trans_h.addr = rw.addr;
    //Copy over write data
    // trans_h.data = rw.data;

    // pragma uvmf custom reg2bus end
    
    // Return the adapted transaction
    return trans_h;

  endfunction: reg2bus

  //--------------------------------------------------------------------
  // bus2reg
  //--------------------------------------------------------------------
  virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
    crop_video_axis_src_transaction #(
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
        .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
        ) trans_h;
    if (!$cast(trans_h, bus_item)) begin
      `uvm_fatal("ADAPT","Provided bus_item is not of the correct type")
      return;
    end
    // pragma uvmf custom bus2reg begin
    // UVMF_CHANGE_ME : Fill in the bus2reg adapter mapping protocol fields to register fields.
    //Adapt the following for your sequence item type
    //Copy over instruction type 
    // rw.kind = (trans_h.op == WB_WRITE) ? UVM_WRITE : UVM_READ;
    //Copy over address
    // rw.addr = trans_h.addr;
    //Copy over read data
    // rw.data = trans_h.data;
    //Check for errors on the bus and return UVM_NOT_OK if there is an error
    // rw.status = UVM_IS_OK;
    // pragma uvmf custom bus2reg end

  endfunction: bus2reg

endclass : crop_video_axis_src2reg_adapter

// pragma uvmf custom external begin
// pragma uvmf custom external end

