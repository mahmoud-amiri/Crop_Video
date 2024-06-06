@set QUESTA_ROOT=C:\questasim64_2021.1
@set UVMF_HOME=C:\UVMF_2023.4\UVMF_2023.4
C:\Python27\python C:\UVMF_2023.4\UVMF_2023.4\scripts\yaml2uvmf.py crop_video_config_interface.yaml crop_video_axis_snk_interface.yaml crop_video_axis_src_interface.yaml crop_video_predictor.yaml crop_video_environment.yaml crop_video_bench.yaml -d ../uvmf
pause