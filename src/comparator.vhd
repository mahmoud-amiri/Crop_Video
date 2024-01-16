library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        valid : in std_logic;
        x_in : in integer;
        y_in : in integer;
        width_in : in integer;
        height_in : in integer;
        x_out : in integer;
        y_out : in integer;
        width_out : in integer;
        height_out : in integer;
        all_equal : out std_logic
    );
end comparator;

architecture Behavioral of comparator is

component file_writer is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic; -- Enable signal to control when to write to the file
        num1 : in integer;
        num2 : in integer;
        num3 : in integer;
        num4 : in integer
    );
end component;

 signal enable : std_logic :='0';
 signal x_in_r : integer;
 signal y_in_r : integer;
 signal width_in_r : integer;
 signal height_in_r : integer;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            all_equal <= '0';
            enable <= '0';
        elsif rising_edge(clk) then
            enable <= '0';
            if (valid = '1') then
                if (x_in = x_out) and (y_in = y_out) and (width_in = width_out) and (height_in = height_out) then
                    all_equal <= '1';
                else
                    all_equal <= '0';
                    -- File writing operation
                    enable <= '1';
                    x_in_r <= x_in; 
                    y_in_r <= y_in; 
                    width_in_r <= width_in; 
                    height_in_r <= height_in;
                end if;
            end if;
        end if;
    end process;


    file_writer_inst : file_writer
    port map (
        clk => clk,
        reset => reset,
        enable => enable,
        num1 => x_in_r,
        num2 => y_in_r,
        num3 => width_in_r,
        num4 => height_in_r
    );
end Behavioral;
