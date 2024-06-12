onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider crop_video_config_agent
add wave -noupdate /uvm_root/uvm_test_top/environment/crop_video_config_agent/crop_video_config_agent_monitor/txn_stream
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/clk
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/rst
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/crop_x
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/crop_y
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/crop_width
add wave -noupdate -group crop_video_config_agent_bus /hdl_top/crop_video_config_agent_bus/crop_height
add wave -noupdate -divider crop_video_axis_snk_agent
add wave -noupdate /uvm_root/uvm_test_top/environment/crop_video_axis_snk_agent/crop_video_axis_snk_agent_monitor/txn_stream
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/clk
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/rst
add wave -noupdate -group crop_video_axis_snk_agent_bus -radix unsigned /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tdata
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tstrb
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tlast
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tvalid
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tuser
add wave -noupdate -group crop_video_axis_snk_agent_bus /hdl_top/crop_video_axis_snk_agent_bus/s00_axis_tready
add wave -noupdate -divider crop_video_axis_src_agent
add wave -noupdate /uvm_root/uvm_test_top/environment/crop_video_axis_src_agent/crop_video_axis_src_agent_monitor/txn_stream
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/clk
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/rst
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_aclk
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_aresetn
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tready
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tvalid
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tlast
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tuser
add wave -noupdate -expand -group crop_video_axis_src_agent_bus -radix unsigned /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tdata
add wave -noupdate -expand -group crop_video_axis_src_agent_bus /hdl_top/crop_video_axis_src_agent_bus/m00_axis_tstrb
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/C_M_AXIS_TDATA_WIDTH
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/C_M_AXIS_FIFO_DEPTH
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/wr_en
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/full
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/data_in
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/last_in
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/user_in
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_ACLK
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_ARESETN
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TDATA
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TVALID
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TREADY
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TSTRB
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TLAST
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/M_AXIS_TUSER
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/mem_data
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/mem_user
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/mem_last
add wave -noupdate -group M -radix unsigned /hdl_top/crop_vid_inst/M00_AXIS_inst/wr_ptr
add wave -noupdate -group M -radix unsigned /hdl_top/crop_vid_inst/M00_AXIS_inst/rd_ptr
add wave -noupdate -group M -radix unsigned /hdl_top/crop_vid_inst/M00_AXIS_inst/fifo_cnt
add wave -noupdate -group M /hdl_top/crop_vid_inst/M00_AXIS_inst/empty
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/C_S_AXIS_TDATA_WIDTH
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/empty
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_ACLK
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_ARESETN
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TREADY
add wave -noupdate -group S -radix unsigned /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TDATA
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TSTRB
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TLAST
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TVALID
add wave -noupdate -group S /hdl_top/crop_vid_inst/S00_AXIS_inst/S_AXIS_TUSER
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/crop_x
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/crop_y
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/crop_width
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/crop_height
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/clk
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/resetn
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tready
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tdata
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tstrb
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tlast
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tvalid
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/s00_axis_tuser
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tvalid
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tdata
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tstrb
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tlast
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tuser
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/m00_axis_tready
add wave -noupdate -expand -group top -radix unsigned /hdl_top/crop_vid_inst/data_in
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/user_in
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/last_in
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/empty
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/read_en
add wave -noupdate -expand -group top -radix unsigned /hdl_top/crop_vid_inst/data_out
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/user_out
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/last_out
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/wr_en
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/full
add wave -noupdate -expand -group top -radix unsigned /hdl_top/crop_vid_inst/x
add wave -noupdate -expand -group top -radix unsigned /hdl_top/crop_vid_inst/y
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/cropping
add wave -noupdate -expand -group top -radix unsigned /hdl_top/crop_vid_inst/cropped_data
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/cropped_valid
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/cropped_last
add wave -noupdate -expand -group top /hdl_top/crop_vid_inst/cropped_user
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {239257 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 402
configure wave -valuecolwidth 129
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {166670 ps} {311844 ps}
