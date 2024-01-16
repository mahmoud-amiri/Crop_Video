library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
library std;
--use std.textio.all;


entity file_writer is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic; -- Enable signal to control when to write to the file
        num1 : in integer;
        num2 : in integer;
        num3 : in integer;
        num4 : in integer
    );
end file_writer;

architecture Behavioral of file_writer is
     constant c_WIDTH : natural := 12;
     file file_result : text;
     signal file_opened : boolean := false;  -- To track if the file is opened
begin

    process(clk, reset)
    variable v_line     : line;
    variable comma_str : string(1 to 2) := ", ";
    begin
        if rising_edge(clk) then
            if reset = '1' then
                if file_opened then
                    file_close(file_result);
                    file_opened <= false;
                end if;
            elsif (enable = '1') then
                    -- Open the file only if it is not already opened
                 if not file_opened then
                     file_open(file_result, "output.txt", write_mode);
                     file_opened <= true;
                 end if;
                 
                 std.textio.write(v_line, num1);
                 std.textio.write(v_line, comma_str);
                 std.textio.write(v_line, num2);
                 std.textio.write(v_line, comma_str);
                 std.textio.write(v_line, num3);
                 std.textio.write(v_line, comma_str);
                 std.textio.write(v_line, num4);
                 std.textio.writeline(file_result, v_line);
                 --file_close(file_result);
            end if;
       end if;     
    end process;
end Behavioral;
