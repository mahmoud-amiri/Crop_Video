
// UVM
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

// Common UVMF files
-f ${UVMF_HOME}/common/common_sve.f

// BFM Files
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/crop_video_config_pkg/crop_video_config_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/crop_video_axis_snk_pkg/crop_video_axis_snk_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/crop_video_axis_src_pkg/crop_video_axis_src_pkg_sve.F

// Environment Files
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/crop_video_env_pkg/crop_video_env_pkg_sve.F

// Bench Files
+incdir+./tb/tests
./tb/tests/crop_video_tests_pkg.sv

+incdir+./tb/sequences
./tb/sequences/crop_video_sequences_pkg.sv

+incdir+./tb/parameters
./tb/parameters/crop_video_parameters_pkg.sv

./tb/testbench/hdl_top.sv
./tb/testbench/hvl_top.sv

