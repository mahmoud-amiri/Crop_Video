package JSONParser_pkg;

    class JSONParser;
        typedef string json_assoc_t[string];
        json_assoc_t json_assoc;
        // Function to remove whitespace from a string
        function string remove_whitespace(string str);
            string temp;
            int i;
            for (i = 0; i < str.len(); i++) begin
                if (str[i] != " " && str[i] != "\n" && str[i] != "\t" && str[i] != "\r\n") begin
                    temp = {temp, str[i]};
                end
            end
            return temp;
        endfunction

        // Function to parse a JSON string and return an associative array
        function json_assoc_t parse_json(string json);
            string key, value;
            int state = 0;  // 0 - expect key, 1 - expect value
            int i;
            json_assoc_t json_assoc_local;
            json = remove_whitespace(json);

            for (i = 0; i < json.len(); i++) begin
                if (json[i] == "{") begin
                    continue;
                end else if (json[i] == "}") begin
                    break;
                end else if (json[i] == "\"") begin
                    i++;
                    while (json[i] != "\"") begin
                        if (state == 0) begin
                            key = {key, json[i]};
                        end else if (state == 1) begin
                            value = {value, json[i]};
                        end
                        i++;
                    end
                    if (state == 0) begin
                        state = 1;
                    end else if (state == 1) begin
                        json_assoc_local[key] = value;
                        key = "";
                        value = "";
                        state = 0;
                    end
                end else if (json[i] == ":") begin
                    continue;
                end else if (json[i] == ",") begin
                    state = 0;
                end
            end

            return json_assoc_local;
        endfunction

        // Function to get the value by key
        function string get_value(string key);
            if (json_assoc.exists(key)) begin
                return json_assoc[key];
            end else begin
                return "";
            end
        endfunction

        // Function to convert associative array to JSON string
        function string assoc_to_json(json_assoc_t assoc);
            string json;
            string key, value;
            json = "{";
            foreach (assoc[key]) begin
                value = assoc[key];
                json = {json, "\"", key, "\":\"", value, "\", "};
            end
            // Remove the trailing comma and space, then add the closing brace
            if (json.len() > 1) begin
                json = json.substr(0, json.len()-3); // remove trailing ", "
            end
            json = {json, "}"};
            return json;
        endfunction

        // Function to set the internal associative array
        function void set_assoc(json_assoc_t assoc);
            json_assoc = assoc;
        endfunction

        // Function to get the internal associative array
        function json_assoc_t get_assoc();
            return json_assoc;
        endfunction

    endclass

endpackage

