 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { crop_video_config_agent }
wave add uvm_test_top.environment.crop_video_config_agent.crop_video_config_agent_monitor.txn_stream -radix string -tag F0
wave group crop_video_config_agent_bus
wave add -group crop_video_config_agent_bus hdl_top.crop_video_config_agent_bus.* -radix hexadecimal -tag F0
wave group crop_video_config_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { crop_video_axis_snk_agent }
wave add uvm_test_top.environment.crop_video_axis_snk_agent.crop_video_axis_snk_agent_monitor.txn_stream -radix string -tag F0
wave group crop_video_axis_snk_agent_bus
wave add -group crop_video_axis_snk_agent_bus hdl_top.crop_video_axis_snk_agent_bus.* -radix hexadecimal -tag F0
wave group crop_video_axis_snk_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { crop_video_axis_src_agent }
wave add uvm_test_top.environment.crop_video_axis_src_agent.crop_video_axis_src_agent_monitor.txn_stream -radix string -tag F0
wave group crop_video_axis_src_agent_bus
wave add -group crop_video_axis_src_agent_bus hdl_top.crop_video_axis_src_agent_bus.* -radix hexadecimal -tag F0
wave group crop_video_axis_src_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

