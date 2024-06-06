# Adjusted script to export all block designs in a Vivado project to TCL files,
# with specific paths for the project and output TCL files.

# Define the output directory for the generated TCL files
set output_dir "./bd"

# Ensure the output directory exists, create if it doesn't
if {![file exists $output_dir]} {
    file mkdir $output_dir
}

# Change the current directory to the project directory to ensure paths are resolved correctly
#cd ./vivado

# Get a list of all block designs in the project
set bd_names  [get_bd_designs]

# Check if there are any block designs to export
if {[llength $bd_names] == 0} {
    puts "No block designs found in the project."
    return
}
# Iterate through each block design
foreach bd $block_designs {
    # Construct the output file name based on the block design name
    set output_file [file join $output_dir [get_property NAME $bd].tcl]
    
    # Export the block design to a TCL file
    puts "Exporting block design [get_property NAME $bd] to $output_file"
    write_bd_tcl -bd_name $bd -force $output_file
}
puts "Finished exporting all block designs to TCL files."