//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the crop_video_config package.
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
//      the crop_video_config_configuration class.
//
  `define crop_video_config_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } crop_video_config_configuration_s;

  `define crop_video_config_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function crop_video_config_configuration_s to_struct();\
    crop_video_config_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( crop_video_config_configuration_struct );\
  endfunction

  `define crop_video_config_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(crop_video_config_configuration_s crop_video_config_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = crop_video_config_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the crop_video_config_transaction class.
//
  `define crop_video_config_MONITOR_STRUCT typedef struct packed  { \
  bit [16-1:0] _crop_x ; \
  bit [16-1:0] _crop_y ; \
  bit [16-1:0] _crop_width ; \
  bit [16-1:0] _crop_height ; \
     } crop_video_config_monitor_s;

  `define crop_video_config_TO_MONITOR_STRUCT_FUNCTION \
  virtual function crop_video_config_monitor_s to_monitor_struct();\
    crop_video_config_monitor_struct = \
            { \
            this._crop_x , \
            this._crop_y , \
            this._crop_width , \
            this._crop_height  \
            };\
    return ( crop_video_config_monitor_struct);\
  endfunction\

  `define crop_video_config_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(crop_video_config_monitor_s crop_video_config_monitor_struct);\
            {\
            this._crop_x , \
            this._crop_y , \
            this._crop_width , \
            this._crop_height  \
            } = crop_video_config_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the crop_video_config_transaction class.
//      Also update the comments in the driver BFM.
//
  `define crop_video_config_INITIATOR_STRUCT typedef struct packed  { \
  bit [16-1:0] _crop_x ; \
  bit [16-1:0] _crop_y ; \
  bit [16-1:0] _crop_width ; \
  bit [16-1:0] _crop_height ; \
     } crop_video_config_initiator_s;

  `define crop_video_config_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function crop_video_config_initiator_s to_initiator_struct();\
    crop_video_config_initiator_struct = \
           {\
           this._crop_x , \
           this._crop_y , \
           this._crop_width , \
           this._crop_height  \
           };\
    return ( crop_video_config_initiator_struct);\
  endfunction

  `define crop_video_config_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(crop_video_config_initiator_s crop_video_config_initiator_struct);\
           {\
           this._crop_x , \
           this._crop_y , \
           this._crop_width , \
           this._crop_height  \
           } = crop_video_config_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the crop_video_config_transaction class.
//      Also update the comments in the driver BFM.
//
  `define crop_video_config_RESPONDER_STRUCT typedef struct packed  { \
  bit [16-1:0] _crop_x ; \
  bit [16-1:0] _crop_y ; \
  bit [16-1:0] _crop_width ; \
  bit [16-1:0] _crop_height ; \
     } crop_video_config_responder_s;

  `define crop_video_config_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function crop_video_config_responder_s to_responder_struct();\
    crop_video_config_responder_struct = \
           {\
           this._crop_x , \
           this._crop_y , \
           this._crop_width , \
           this._crop_height  \
           };\
    return ( crop_video_config_responder_struct);\
  endfunction

  `define crop_video_config_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(crop_video_config_responder_s crop_video_config_responder_struct);\
           {\
           this._crop_x , \
           this._crop_y , \
           this._crop_width , \
           this._crop_height  \
           } = crop_video_config_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
