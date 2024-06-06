# Read Project Configuration
set configFile [open "project_config.txt" r]
set projectName ""
set projectLocation ""
set partNumber ""
set topModuleName ""
set cpuCoreCount ""

while {[gets $configFile line] >= 0} {
    if {[string match "PROJECT_NAME=*" $line]} {
        set projectName [string trim [string range $line 13 end]]
    } elseif {[string match "PROJECT_LOCATION=*" $line]} {
        set projectLocation [string trim [string range $line 17 end]]
    } elseif {[string match "PART_NUMBER=*" $line]} {
        set partNumber [string trim [string range $line 12 end]]
    } elseif {[string match "TOP_MODULE=*" $line]} {
        set topModuleName [string trim [string range $line 11 end]]
    } elseif {[string match "CORE_CNT=*" $line]} {
        set cpuCoreCount [string trim [string range $line 9 end]]
    }
}
close $configFile

set project_folder Vivado

set origin_dir [file dirname [file dirname [info script]]]
cd ${origin_dir}

open_project ./${project_folder}/${projectName}.xpr

update_compile_order -fileset sources_1

reset_project

launch_runs synth_1 -jobs $cpuCoreCount
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs $cpuCoreCount
wait_on_run impl_1

write_hw_platform -fixed -include_bit -force -file ./${project_folder}/${topModuleName}.xsa

exit