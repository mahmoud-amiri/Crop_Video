package server_api_pkg;

    import server_pkg::*;
    import FileIO_pkg::*;
    import JSONParser_pkg::*;

    typedef string json_assoc_t[string];

    class ServerAPI;

        Server srv;
        FileIO file_io;
        JSONParser parser;
        
        int port;
        

        // Constructor
        function new();
            file_io = new();
            parser = new();
        endfunction

        function string escape_json_characters(string json_string);
            string replacements[string];
            string result = "";
            int i;
            replacements["{"] = "#1*";
            replacements["}"] = "#2*";
            replacements["["] = "#3*";
            replacements["]"] = "#4*";
            replacements[":"] = "#5*";
            replacements[","] = "#6*";
            replacements["\""] = "#7*";
            replacements["true"] = "#8*";
            replacements["false"] = "#9*";
            replacements["null"] = "#0*";
            replacements[" "] = "#A*";
            replacements["\n"] = "#B*";
            replacements["\t"] = "#C*";

            // Traverse each character in the json_string
            for (i = 0; i < json_string.len(); i++) begin
                string char = json_string.substr(i, 1);
                if (replacements.exists(char)) begin
                    result = {result, replacements[char]};
                end else begin
                    result = {result, char};
                end
            end

            return result;
        endfunction


    function automatic string unescape_json_characters(string escaped_string);
        string replacements[string];
        string result = "";
        int i;
        int len;
        string fragment;
        
        // Define replacements
        replacements["#1*"] = "{";
        replacements["#2*"] = "}";
        replacements["#3*"] = "[";
        replacements["#4*"] = "]";
        replacements["#5*"] = ":";
        replacements["#6*"] = ",";
        replacements["#7*"] = "\"";
        replacements["#8*"] = "true";
        replacements["#9*"] = "false";
        replacements["#0*"] = "null";
        replacements["#A*"] = " ";
        replacements["#B*"] = "\n";
        replacements["#C*"] = "\t";

        i = 0;
        escaped_string = {" ", escaped_string};
        len = escaped_string.len();
        
        // Process the string
        while (i < len) begin
            // Try to match 4-character fragments first
            if (len - i >= 4) begin
                fragment = escaped_string.substr(i+1, i+4); // substr is 1-based inclusive
                // $display("Checking 4-char fragment: %s", fragment);
                if (replacements.exists(fragment)) begin
                    result = {result, replacements[fragment]};
                    // $display("Matched 4-char fragment: %s -> %s", fragment, replacements[fragment]);
                    i += 4;
                    continue;
                end
            end
            // Try to match 3-character fragments next
            if (len - i >= 3) begin
                fragment = escaped_string.substr(i+1, i+3); // substr is 1-based inclusive
                // $display("Checking 3-char fragment: %s", fragment);
                if (replacements.exists(fragment)) begin
                    result = {result, replacements[fragment]};
                    // $display("Matched 3-char fragment: %s -> %s", fragment, replacements[fragment]);
                    i += 3;
                    continue;
                end
            end
            // If no match, add the current character to result
            fragment = escaped_string.substr(i+1, i+1); // substr is 1-based inclusive
            result = {result, fragment};
            // $display("No match, adding single character: %s", fragment);
            i++;
        end

        return result;
    endfunction



        function json_assoc_t escape_json_keys(json_assoc_t array);
            string key;
            foreach (array[key]) begin
                array[key] = escape_json_characters(array[key]);
            end
            return array;
        endfunction

        function json_assoc_t unescape_json_keys(json_assoc_t array);
            string key;
            foreach (array[key]) begin
                array[key] = unescape_json_characters(array[key]);
            end
            return array;
        endfunction

        
        // Method to initialize the server with a port from a JSON file
        function void init(string json_file, string port_name);
            string content;
            json_assoc_t assoc;
            file_io.open(json_file, "r");
            content = file_io.read_file();
            file_io.close();

            assoc = parser.parse_json(content);
            port = assoc[port_name].atoi(); 
            srv = new(port);
        endfunction

        // Method to start the server
        function void start();
            srv.start();
        endfunction

        // Method to stop the server
        function void stop();
            srv.stop();
        endfunction

        // Method to receive large data
        function json_assoc_t receive();
            json_assoc_t assoc;
            string content;
            int len;
            content = srv.receive_large(1000000);
            $display(content);
            content = unescape_json_characters(content);
            $display(content);
            len = content.len();
            if (len <= 4) begin
                // If the string is too short, return an empty string
                content = "";
            end else begin
                content = content.substr(2, len-2); // 1-based indexing and inclusive
            end
            $display(content);
            assoc = parser.parse_json(content);
            return assoc;
        endfunction

        // Method to send large data
        function void send(json_assoc_t data);
            string content;
            content = parser.assoc_to_json(data);
            srv.send_large(content);
        endfunction

    endclass

endpackage
