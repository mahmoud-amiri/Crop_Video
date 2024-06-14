

##################################################################
## ENVIRONMENT VARIABLES
##################################################################
quietly set ::env(UVMF_VIP_LIBRARY_HOME) ../../../verification_ip
quietly set ::env(UVMF_PROJECT_DIR) ..

## Using VRM means that the build is occuring several more directories deeper underneath
## the sim directory, need to prepend some more '..'
if {[info exists ::env(VRM_BUILD)]} {
  quietly set ::env(UVMF_VIP_LIBRARY_HOME) "../../../../../$::env(UVMF_VIP_LIBRARY_HOME)"
  quietly set ::env(UVMF_PROJECT_DIR) "../../../../../$::env(UVMF_PROJECT_DIR)"
}
quietly set ::env(UVMF_VIP_LIBRARY_HOME) [file normalize $::env(UVMF_VIP_LIBRARY_HOME)]
quietly set ::env(UVMF_PROJECT_DIR) [file normalize $::env(UVMF_PROJECT_DIR)]
quietly echo "UVMF_VIP_LIBRARY_HOME = $::env(UVMF_VIP_LIBRARY_HOME)"
quietly echo "UVMF_PROJECT_DIR = $::env(UVMF_PROJECT_DIR)"


###################################################################
## HOUSEKEEPING : DELETE FILES THAT WILL BE REGENERATED
###################################################################
file delete -force *~ *.ucdb vsim.dbg *.vstf *.log work *.mem *.transcript.txt certe_dump.xml *.wlf covhtmlreport VRMDATA
file delete -force design.bin qwave.db dpiheader.h visualizer*.ses
file delete -force veloce.med veloce.wave veloce.map tbxbindings.h edsenv velrunopts.ini
file delete -force sv_connect.*

###################################################################
## COMPILE C CODE AND CREATE SHARED LIBRARY
###################################################################
# Compile the C code to create a DLL for DPI
#exec gcc -c -o $env(UVMF_PROJECT_DIR)/../../../dpi/server.o $env(UVMF_PROJECT_DIR)/../../../dpi/server.c
#exec gcc -shared -o $env(UVMF_PROJECT_DIR)/../../../dpi/server.dll $env(UVMF_PROJECT_DIR)/../../../dpi/server.o

###################################################################
## COMPILE PACKAGES
###################################################################

vlog -sv $env(UVMF_PROJECT_DIR)/../../../dpi/server_pkg.sv
vlog -sv $env(UVMF_PROJECT_DIR)/../../../dpi/FileIO_pkg.sv
vlog -sv $env(UVMF_PROJECT_DIR)/../../../dpi/JSONParser_pkg.sv
vlog -sv $env(UVMF_PROJECT_DIR)/../../../dpi/server_api_pkg.sv

###################################################################
## COMPILE DUT SOURCE CODE
###################################################################
vlib work 
# pragma uvmf custom dut_compile_dofile_target begin
# UVMF_CHANGE_ME : Add commands to compile your dut here, replacing the default examples
vlog -sv -timescale 1ps/1ps -suppress 2223,2286  $env(UVMF_PROJECT_DIR)/../../../../hdl/M00_AXIS.v
vlog -sv -timescale 1ps/1ps -suppress 2223,2286  $env(UVMF_PROJECT_DIR)/../../../../hdl/S00_AXIS.v
vlog -sv -timescale 1ps/1ps -suppress 2223,2286  $env(UVMF_PROJECT_DIR)/../../../../hdl/crop_vid.v
# pragma uvmf custom dut_compile_dofile_target end

###################################################################
## COMPILE UVMF BASE/COMMON SOURCE CODE
###################################################################
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286  +incdir+$env(UVMF_HOME)/uvmf_base_pkg -F $env(UVMF_HOME)/uvmf_base_pkg/uvmf_base_pkg_filelist_hdl.f
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286  +incdir+$env(UVMF_HOME)/uvmf_base_pkg -F $env(UVMF_HOME)/uvmf_base_pkg/uvmf_base_pkg_filelist_hvl.f


###################################################################
## UVMF INTERFACE COMPILATION
###################################################################
do $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_config_pkg/compile.do
do $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg/compile.do
do $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_src_pkg/compile.do

###################################################################
## UVMF ENVIRONMENT COMPILATION
###################################################################
do $env(UVMF_VIP_LIBRARY_HOME)/environment_packages/crop_video_env_pkg/compile.do

###################################################################
## UVMF BENCHES COMPILATION
###################################################################
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286 +incdir+$env(UVMF_PROJECT_DIR)/tb/parameters $env(UVMF_PROJECT_DIR)/tb/parameters/crop_video_parameters_pkg.sv
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286 +incdir+$env(UVMF_PROJECT_DIR)/tb/sequences $env(UVMF_PROJECT_DIR)/tb/sequences/crop_video_sequences_pkg.sv
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286 +incdir+$env(UVMF_PROJECT_DIR)/tb/tests $env(UVMF_PROJECT_DIR)/tb/tests/crop_video_tests_pkg.sv

vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286 +incdir+$env(UVMF_PROJECT_DIR)/tb/testbench -F $env(UVMF_PROJECT_DIR)/tb/testbench/top_filelist_hdl.f
vlog -sv -timescale 1ps/1ps -suppress 2223 -suppress 2286  +incdir+$env(UVMF_PROJECT_DIR)/tb/testbench -F $env(UVMF_PROJECT_DIR)/tb/testbench/top_filelist_hvl.f

###################################################################
## OPTIMIZATION
###################################################################
#vopt  hvl_top hdl_top   -o optimized_batch_top_tb
#vopt  +acc   hvl_top hdl_top   -o optimized_debug_top_tb

vopt +cover=sbfec +acc -o optimized_batch_top_tb hvl_top hdl_top
vopt +cover=sbfec +acc -o optimized_debug_top_tb hvl_top hdl_top