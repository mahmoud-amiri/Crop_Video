//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the crop_video_axis_src package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the crop_video_axis_src_configuration class.
//
  `define crop_video_axis_src_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } crop_video_axis_src_configuration_s;

  `define crop_video_axis_src_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function crop_video_axis_src_configuration_s to_struct();\
    crop_video_axis_src_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( crop_video_axis_src_configuration_struct );\
  endfunction

  `define crop_video_axis_src_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(crop_video_axis_src_configuration_s crop_video_axis_src_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = crop_video_axis_src_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the crop_video_axis_src_transaction class.
//
  `define crop_video_axis_src_MONITOR_STRUCT typedef struct packed  { \
  bit m00_axis_tready ; \
  bit m00_axis_tvalid ; \
  bit m00_axis_tlast ; \
  bit m00_axis_tuser ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ; \
     } crop_video_axis_src_monitor_s;

  `define crop_video_axis_src_TO_MONITOR_STRUCT_FUNCTION \
  virtual function crop_video_axis_src_monitor_s to_monitor_struct();\
    crop_video_axis_src_monitor_struct = \
            { \
            this.m00_axis_tready , \
            this.m00_axis_tvalid , \
            this.m00_axis_tlast , \
            this.m00_axis_tuser , \
            this.m00_axis_tdata , \
            this.m00_axis_tstrb  \
            };\
    return ( crop_video_axis_src_monitor_struct);\
  endfunction\

  `define crop_video_axis_src_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(crop_video_axis_src_monitor_s crop_video_axis_src_monitor_struct);\
            {\
            this.m00_axis_tready , \
            this.m00_axis_tvalid , \
            this.m00_axis_tlast , \
            this.m00_axis_tuser , \
            this.m00_axis_tdata , \
            this.m00_axis_tstrb  \
            } = crop_video_axis_src_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the crop_video_axis_src_transaction class.
//      Also update the comments in the driver BFM.
//
  `define crop_video_axis_src_INITIATOR_STRUCT typedef struct packed  { \
  bit m00_axis_tready ; \
  bit m00_axis_tvalid ; \
  bit m00_axis_tlast ; \
  bit m00_axis_tuser ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ; \
     } crop_video_axis_src_initiator_s;

  `define crop_video_axis_src_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function crop_video_axis_src_initiator_s to_initiator_struct();\
    crop_video_axis_src_initiator_struct = \
           {\
           this.m00_axis_tready , \
           this.m00_axis_tvalid , \
           this.m00_axis_tlast , \
           this.m00_axis_tuser , \
           this.m00_axis_tdata , \
           this.m00_axis_tstrb  \
           };\
    return ( crop_video_axis_src_initiator_struct);\
  endfunction

  `define crop_video_axis_src_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(crop_video_axis_src_initiator_s crop_video_axis_src_initiator_struct);\
           {\
           this.m00_axis_tready , \
           this.m00_axis_tvalid , \
           this.m00_axis_tlast , \
           this.m00_axis_tuser , \
           this.m00_axis_tdata , \
           this.m00_axis_tstrb  \
           } = crop_video_axis_src_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the crop_video_axis_src_transaction class.
//      Also update the comments in the driver BFM.
//
  `define crop_video_axis_src_RESPONDER_STRUCT typedef struct packed  { \
  bit m00_axis_tready ; \
  bit m00_axis_tvalid ; \
  bit m00_axis_tlast ; \
  bit m00_axis_tuser ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH-1:0] m00_axis_tdata ; \
  bit [crop_video_axis_src_C_M00_AXIS_TDATA_WIDTH_8-1:0] m00_axis_tstrb ; \
     } crop_video_axis_src_responder_s;

  `define crop_video_axis_src_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function crop_video_axis_src_responder_s to_responder_struct();\
    crop_video_axis_src_responder_struct = \
           {\
           this.m00_axis_tready , \
           this.m00_axis_tvalid , \
           this.m00_axis_tlast , \
           this.m00_axis_tuser , \
           this.m00_axis_tdata , \
           this.m00_axis_tstrb  \
           };\
    return ( crop_video_axis_src_responder_struct);\
  endfunction

  `define crop_video_axis_src_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(crop_video_axis_src_responder_s crop_video_axis_src_responder_struct);\
           {\
           this.m00_axis_tready , \
           this.m00_axis_tvalid , \
           this.m00_axis_tlast , \
           this.m00_axis_tuser , \
           this.m00_axis_tdata , \
           this.m00_axis_tstrb  \
           } = crop_video_axis_src_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
