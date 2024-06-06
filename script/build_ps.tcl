# Read Project Configuration
set configFile [open "project_config.txt" r]
set projectName ""
set projectLocation ""
set partNumber ""
set topModuleName ""
set cpuCoreCount ""
set proc_name ""


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
    } elseif {[string match "PROCESSOR_NAME=*" $line]} {
        set proc_name [string trim [string range $line 15 end]]
    }
}
close $configFile



setws ./vitis
app create -name ${projectName} -hw ./vivado/${topModuleName}.xsa -proc ${proc_name} -os standalone -lang C++ -template "Empty Application"
importsources -name ${projectName} -path ./sdk/ -linker-script
app build -all
