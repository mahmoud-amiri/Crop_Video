library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity random_generator_axi is
    Generic (
        LFSR_INIT : unsigned(31 downto 0) := (others=>'1');-- LFSR initialization
        DATA_WIDTH : integer := 32;              -- Width of the random numbers
        UPPER_LIMIT : unsigned(32-1 downto 0) := "11111111111111111111111111111111" -- Upper limit for the random number
    );
    Port (
        clk : in std_logic;
        reset : in std_logic;
        
        -- AXI Stream interface for Random Number Output
        m_axis_tdata : out unsigned(DATA_WIDTH-1 downto 0);  -- Output data (random number)
        m_axis_tvalid : out std_logic;                       -- Valid output data
        m_axis_tready : in std_logic                         -- Ready to accept data
    );
end random_generator_axi;

architecture Behavioral of random_generator_axi is
    signal lfsr : unsigned(DATA_WIDTH-1 downto 0) := LFSR_INIT;  -- LFSR initialization
    signal random_number : unsigned(DATA_WIDTH-1 downto 0);
begin

    -- Random Number Generation Process
    process(clk, reset)
    begin
        if reset = '1' then
            lfsr <= LFSR_INIT;
        elsif rising_edge(clk) then
            -- LFSR feedback polynomial (example: x^32 + x^22 + x^2 + x^1 + 1)
            lfsr <= lfsr(DATA_WIDTH-2 downto 0) & (lfsr(DATA_WIDTH-1) xor lfsr(21) xor lfsr(1) xor lfsr(0));
            -- Limit the random number
            random_number <= lfsr mod (UPPER_LIMIT + 1);
            
        end if;
    end process;

    -- AXI Stream output process for Random Number
    m_axis_tdata <= random_number;
    m_axis_tvalid <= '1' when m_axis_tready = '1' else '0';

end Behavioral;
