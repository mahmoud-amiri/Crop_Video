//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an crop_video_axis_src
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class crop_video_axis_src_transaction #(
      int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH = 32,
      int crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8 = 4,
      int crop_video_axis_src_C_M00_AXIS_START_COUNT = 32
      ) extends uvmf_transaction_base;

  `uvm_object_param_utils( crop_video_axis_src_transaction #(
                           crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH,
                           crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8,
                           crop_video_axis_src_C_M00_AXIS_START_COUNT
                           ))

  // rand bit m00_axis_tready ;
  bit m00_axis_tready ;
  bit m00_axis_tvalid ;
  bit m00_axis_tlast ;
  bit m00_axis_tuser ;
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ;
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // constraint m00_axis_tready_c {m00_axis_tready dist { 0:=20, 1:=80 };}
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in crop_video_axis_src_macros.svh

  //*******************************************************************
  // Monitor macro used by crop_video_axis_src_monitor and crop_video_axis_src_monitor_bfm
  // This struct is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_MONITOR_STRUCT
    crop_video_axis_src_monitor_s crop_video_axis_src_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a crop_video_axis_src_monitor_s
  // structure.  The function returns the handle to the crop_video_axis_src_monitor_struct.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by crop_video_axis_src_driver and crop_video_axis_src_driver_bfm
  // to communicate initiator driven data to crop_video_axis_src_driver_bfm.
  // This struct is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_INITIATOR_STRUCT
    crop_video_axis_src_initiator_s crop_video_axis_src_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a crop_video_axis_src_initiator_s
  // structure.  The function returns the handle to the crop_video_axis_src_initiator_struct.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by crop_video_axis_src_driver and crop_video_axis_src_driver_bfm
  // to communicate Responder driven data to crop_video_axis_src_driver_bfm.
  // This struct is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_RESPONDER_STRUCT
    crop_video_axis_src_responder_s crop_video_axis_src_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a crop_video_axis_src_responder_s
  // structure.  The function returns the handle to the crop_video_axis_src_responder_struct.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in crop_video_axis_src_macros.svh
  `crop_video_axis_src_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("m00_axis_tready:0x%x m00_axis_tvalid:0x%x m00_axis_tlast:0x%x m00_axis_tuser:0x%x m00_axis_tdata:0x%x m00_axis_tstrb:0x%x ",m00_axis_tready,m00_axis_tvalid,m00_axis_tlast,m00_axis_tuser,m00_axis_tdata,m00_axis_tstrb);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    crop_video_axis_src_transaction #(
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
        .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
        ) RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.m00_axis_tready == RHS.m00_axis_tready)
            &&(this.m00_axis_tvalid == RHS.m00_axis_tvalid)
            &&(this.m00_axis_tlast == RHS.m00_axis_tlast)
            &&(this.m00_axis_tuser == RHS.m00_axis_tuser)
            &&(this.m00_axis_tdata == RHS.m00_axis_tdata)
            &&(this.m00_axis_tstrb == RHS.m00_axis_tstrb)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    crop_video_axis_src_transaction #(
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH),
        .crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8(crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8),
        .crop_video_axis_src_C_M00_AXIS_START_COUNT(crop_video_axis_src_C_M00_AXIS_START_COUNT)
        ) RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.m00_axis_tready = RHS.m00_axis_tready;
    this.m00_axis_tvalid = RHS.m00_axis_tvalid;
    this.m00_axis_tlast = RHS.m00_axis_tlast;
    this.m00_axis_tuser = RHS.m00_axis_tuser;
    this.m00_axis_tdata = RHS.m00_axis_tdata;
    this.m00_axis_tstrb = RHS.m00_axis_tstrb;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"crop_video_axis_src_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,m00_axis_tready,"m00_axis_tready");
    $add_attribute(transaction_view_h,m00_axis_tvalid,"m00_axis_tvalid");
    $add_attribute(transaction_view_h,m00_axis_tlast,"m00_axis_tlast");
    $add_attribute(transaction_view_h,m00_axis_tuser,"m00_axis_tuser");
    $add_attribute(transaction_view_h,m00_axis_tdata,"m00_axis_tdata");
    $add_attribute(transaction_view_h,m00_axis_tstrb,"m00_axis_tstrb");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

