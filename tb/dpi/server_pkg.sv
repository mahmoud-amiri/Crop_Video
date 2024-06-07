package server_pkg;

    import "DPI-C" function void sv_start_server(input int port);
    import "DPI-C" function void sv_stop_server();
    import "DPI-C" function int sv_handshake();
    import "DPI-C" function void sv_send_large_data(input string json_str);
    import "DPI-C" function string sv_receive_large_data(input int max_attempts);
    import "DPI-C" function void sv_send_data(input string json_str);
    import "DPI-C" function void sv_receive_data(input string json_str);

    class Server;
        int port;
        string received_data;

        function new(int port);
            this.port = 8081;//port;
        endfunction

        task start();
            sv_start_server(port);
            $display("Server started on port %0d", port);
            if (sv_handshake()) begin
                $display("Handshake successful");
            end else begin
                $display("Handshake failed");
                sv_stop_server();
            end
        endtask

        task stop();
            sv_stop_server();
            $display("Server stopped on port %0d", port);
        endtask

        task send(string data);
            sv_send_data(data);
        endtask

        task receive(output string data);
            sv_receive_data(data);
            this.received_data = data;
        endtask

        function string get_received_data();
            return received_data;
        endfunction


        task send_large(string data);
            sv_send_large_data(data);
        endtask

        function string receive_large(int max_attempts);
            return sv_receive_large_data(max_attempts);
        endfunction
    endclass

endpackage