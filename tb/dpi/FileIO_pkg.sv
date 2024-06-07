package FileIO_pkg;
    class FileIO;

    // File handle
        integer file_handle;

        // Constructor
        function new();
            file_handle = 0;
        endfunction

        // Method to open a file
        function void open(string file_name, string mode);
            file_handle = $fopen(file_name, mode);
            if (file_handle == 0) begin
            $display("Error: Failed to open file %s!", file_name);
            end
        endfunction

        // Method to read a line from the file
        function string read_line();
            string line;
            if (!$feof(file_handle)) begin
                if ($fgets(line, file_handle)) begin
                    return line;
                end else begin
                    $display("Error: Failed to read line!");
                    return "";
                end
            end else begin
                return "";
            end
        endfunction

        // Method to write a line to the file
        function void write_line(string line);
            if (file_handle != 0) begin
            $fwrite(file_handle, "%s\n", line);
            end else begin
            $display("Error: File is not open for writing!");
            end
        endfunction

        // Method to close the file
        function void close();
            if (file_handle != 0) begin
            $fclose(file_handle);
            file_handle = 0;
            end else begin
            $display("Error: File is not open!");
            end
        endfunction

        function string read_file();
            string line;
            string content;
            line = "A";
            content = "";
            if (!$feof(file_handle)) begin
                while (line != "") begin
                    if ($fgets(line, file_handle)) begin
                        content = {content, line};
                    end else begin
                        $display("Error: Failed to read line!");
                        return content;
                    end
                end
                return content;
            end else begin
                return content;
            end
        endfunction

    endclass
endpackage

