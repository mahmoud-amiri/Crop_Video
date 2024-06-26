

quietly set svLibs ""
quietly set extra_vsim_args ""

###################################################################
## Check for additional vsim arguments passed using env var $UVMF_EXTRA_VSIM_ARGS
###################################################################
if {[info exists ::env(UVMF_EXTRA_VSIM_ARGS)]} {
  echo "Adding more args to vsim command"
  quietly set extra_vsim_args $::env(UVMF_EXTRA_VSIM_ARGS)
}

###################################################################
## Specify the shared library
###################################################################
set svLibs [format "-sv_lib %s/../../../dpi/server" $::env(UVMF_PROJECT_DIR)]

##################################################################
## Launch Questa : generate vsim command line and execute
##################################################################
# pragma uvmf custom dut_run_dofile_target begin
# UVMF_CHANGE_ME : Change the UVM_TESTNAME plusarg to run a different test
#quietly set cmd [format "vsim -i -sv_seed random +UVM_TESTNAME=test_top +UVM_VERBOSITY=UVM_HIGH  -permit_unmatched_virtual_intf +notimingchecks -suppress 8887  %s %s -uvmcontrol=all -msgmode both -classdebug -assertdebug  +uvm_set_config_int=*,enable_transaction_viewing,1  -do { set NoQuitOnFinish 1; onbreak {resume}; run 0; do wave.do; set PrefSource(OpenOnBreak) 0; radix hex showbase; } optimized_debug_top_tb" $svLibs $extra_vsim_args]
#quietly set cmd [format "vsim -i -sv_seed random +UVM_TESTNAME=AXI_Stream_pattern_test +UVM_VERBOSITY=UVM_HIGH  -permit_unmatched_virtual_intf +notimingchecks -suppress 8887  %s %s -uvmcontrol=all -msgmode both -classdebug -assertdebug  +uvm_set_config_int=*,enable_transaction_viewing,1 -coverage -cvgperinstance -coverstats -do { set NoQuitOnFinish 1; onbreak {resume}; run 0; do wave.do; set PrefSource(OpenOnBreak) 0; radix hex showbase; } optimized_debug_top_tb" $svLibs $extra_vsim_args]
quietly set cmd [format "vsim -i -sv_seed random +UVM_TESTNAME=AXI_Stream_pattern_test +UVM_VERBOSITY=UVM_HIGH -permit_unmatched_virtual_intf +notimingchecks -suppress 8887 -coverage %s %s -uvmcontrol=all -msgmode both -classdebug -assertdebug +uvm_set_config_int=*,enable_transaction_viewing,1 -do { set NoQuitOnFinish 1; onbreak {resume}; run -all; do wave.do; set PrefSource(OpenOnBreak) 0; radix hex showbase; coverage save -onexit coverage.ucdb; } optimized_debug_top_tb" $svLibs $extra_vsim_args]

# pragma uvmf custom dut_run_dofile_target end
eval $cmd


##################################################################
## Coverage report generation
##################################################################
## Merge the coverage databases
#vcover merge -details merged_coverage.ucdb coverage_*.ucdb
#
## Generate coverage report
#vcover report - -html -output coverage_report merged_coverage.ucdb
coverage report -html -output coverage_report