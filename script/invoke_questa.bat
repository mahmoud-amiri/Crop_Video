:: crop_video
@set QUESTA_ROOT=C:\questasim64_2021.1
@set UVMF_HOME=C:\UVMF_2023.4\UVMF_2023.4
cd .\tb\uvmf\project_benches\crop_video\sim
vsim -i -do "do compile.do; do run.do
pause 