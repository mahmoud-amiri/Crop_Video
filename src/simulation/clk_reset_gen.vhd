library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_reset_gen is
    Generic ( clk_period : time := 10 ns;        -- Default clock period
              reset_duration : time := 50 ns );  -- Default reset duration
    Port ( clk_out : out  std_logic;
           reset_out : out  std_logic);
end clk_reset_gen;

architecture Behavioral of clk_reset_gen is

signal clk : std_logic := '0';
signal reset : std_logic := '1';

begin

-- Clock process
clk_process : process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-- Reset process
reset_process : process
begin
    reset <= '1';
    wait for reset_duration;
    reset <= '0';
    wait;
end process;

-- Output assignments
clk_out <= clk;
reset_out <= reset;

end Behavioral;
