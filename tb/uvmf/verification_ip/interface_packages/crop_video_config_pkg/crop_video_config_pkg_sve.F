// UVM
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

// Common UVMF files
-f ${UVMF_HOME}/common/common_sve.f

+incdir+.
-f ${UVMF_VIP_LIBRARY_HOME}/interface_packages/crop_video_config_pkg/crop_video_config_filelist_hdl.f
-f ${UVMF_VIP_LIBRARY_HOME}/interface_packages/crop_video_config_pkg/crop_video_config_filelist_hvl.f
