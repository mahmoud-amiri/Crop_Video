# Tcl do file for compile of crop_video_config interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg/crop_video_config_filelist_hdl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg/crop_video_config_filelist_hvl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg/crop_video_config_filelist_xrtl.f