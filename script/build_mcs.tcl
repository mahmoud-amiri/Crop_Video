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

set mcs_name final_output
set mcs_dir "."

set bin_dir "./vivado/${projectName}.runs/impl_1/${topModuleName}.bin"
set bit_dir "./vivado/${projectName}.runs/impl_1/${topModuleName}.bit"
set ltx_dir "./vivado/${projectName}.runs/impl_1/${topModuleName}.ltx"

# Get the current time
set current_time [clock seconds]

# Format the time as MMDDYY_HHMM
set formatted_time [clock format $current_time -format {%m%d%y_%H%M}]

# Create a filename with the formatted time
set filename "my_file_${formatted_time}.txt"

# Example usage: creating a file with the generated name
set file [open $filename "w"]
puts $file "This file was created on $formatted_time."
close $file

# Output the filename to the console
puts "File created: $filename"


file copy -force ${bit_dir} ./output/out_${formatted_time}.bit
file copy -force ${ltx_dir} ./output/out_${formatted_time}.ltx
file copy -force ${bin_dir} ./output/out_${formatted_time}.bin
write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit {up 0x00000000 ./output/out_${formatted_time}.bit } -force -file ./output/out_${formatted_time}.mcs

exit
