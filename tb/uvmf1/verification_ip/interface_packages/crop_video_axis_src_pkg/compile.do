# Tcl do file for compile of crop_video_axis_src interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg/crop_video_axis_src_filelist_hdl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg/crop_video_axis_src_filelist_hvl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg/crop_video_axis_src_filelist_xrtl.f