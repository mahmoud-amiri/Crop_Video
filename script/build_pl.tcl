# Read Project Configuration
set configFile [open "project_config.txt" r]
set projectName ""
set projectLocation ""
set partNumber ""

while {[gets $configFile line] >= 0} {
    if {[string match "PROJECT_NAME=*" $line]} {
        set projectName [string trim [string range $line 13 end]]
    } elseif {[string match "PROJECT_LOCATION=*" $line]} {
        set projectLocation [string trim [string range $line 18 end]]
    } elseif {[string match "PART_NUMBER=*" $line]} {
        set partNumber [string trim [string range $line 12 end]]
    }
}
close $configFile

# Convert relative project location to absolute if necessary
set absProjectLocation [file normalize $projectLocation]

# Check if the project directory exists and delete it if it does
if {[file exists $absProjectLocation]} {
    file delete -force $absProjectLocation
}

# Create and configure the project
create_project $projectName $absProjectLocation -part $partNumber


# Add HDL Design Sources (both VHDL and Verilog)
set hdlFiles [glob -nocomplain ./hdl/*.{v,vhd,vhdl}]
foreach hdlFile $hdlFiles {
    add_files -norecurse $hdlFile
    # Determine file type based on extension and set it
    if {[string match "*.vhd" $hdlFile] || [string match "*.vhdl" $hdlFile]} {
        set_property FILE_TYPE {VHDL 2008} [get_files $hdlFile] ;# Adjust VHDL version if necessary
    } elseif {[string match "*.v" $hdlFile]} {
        set_property FILE_TYPE {Verilog} [get_files $hdlFile]
    }
}

# Add Simulation Sources
foreach simFile [glob -nocomplain ./sim/*] {
    add_files -fileset sim_1 -norecurse $simFile
}

# Add Constraints
foreach xdcFile [glob -nocomplain ./cons/*.xdc] {
    add_files -fileset constrs_1 -norecurse $xdcFile
}

# Add XCI files from xil_ip
foreach xciFile [glob -nocomplain .xil_ip/*.xci] {
    add_files -norecurse $xciFile
    set_property IP_REPO_PATHS $absProjectLocation/xil_ip [current_project]
}

# Add XCI files from user_ip
foreach xciFile [glob -nocomplain ./user_ip/*.xci] {
    add_files -norecurse $xciFile
    set_property IP_REPO_PATHS $absProjectLocation/user_ip [current_project]
}


# Define the path to the bd directory relative to this script's location
set bdPath [file normalize "./bd"]

# Check if the bd directory exists
if {[file exists $bdPath]} {
    # List all TCL files in the bd directory
    foreach bdTclFile [glob -nocomplain $bdPath/*.tcl] {
        # Extract the base name for the block design from the file name
        set bdName [file tail [file rootname $bdTclFile]]
        
        # Source the TCL file to recreate the block design
        puts "Sourcing BD TCL script for: $bdName"
        source $bdTclFile
        
        # Optional: Save the project after each BD is recreated
        save_project
    }
} else {
    puts "The bd directory does not exist at $bdPath"
}


# Save and close the project
#save_project
close_project 
