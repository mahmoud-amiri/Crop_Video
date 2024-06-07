linux:
make 

windows:
gcc -I ./ -L ./ -fPIC -shared -o server.dll server.c -lws2_32 -lcjson
gcc -I ./ -L ./ -o server.exe server.c -lws2_32 -lcjson 