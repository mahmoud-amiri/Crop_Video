library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_vec_gen is
    generic (
            UPPER_LIMIT_X : unsigned(32-1 downto 0)  := X"00000780";
            UPPER_LIMIT_Y : unsigned(32-1 downto 0)  := X"00000438";
            UPPER_LIMIT_Width : unsigned(32-1 downto 0)  := X"00000780";
            UPPER_LIMIT_Height : unsigned(32-1 downto 0)  := X"00000438"
            );
    Port (
        clk : in std_logic;
        reset : in std_logic;
        
        -- Output for 4 random numbers
        X : out unsigned(31 downto 0);
        Y : out unsigned(31 downto 0);
        width : out unsigned(31 downto 0);
        height : out unsigned(31 downto 0);
        ready : in std_logic;
        valid : out std_logic
    );
end test_vec_gen;

architecture Behavioral of test_vec_gen is

    -- Signals for AXI Stream interface
    signal m_axis_tready : std_logic := '1';  -- Assuming always ready for simplicity

    -- Signals for random number outputs
    signal random_number1, random_number2, random_number3, random_number4 : unsigned(31 downto 0);

begin

    -- Instantiate the first random number generator
    X_GEN: entity work.random_generator_axi
        generic map (
            LFSR_INIT => X"12345678",
            DATA_WIDTH => 32,
            UPPER_LIMIT => UPPER_LIMIT_X
        )
        port map (
            clk => clk,
            reset => reset,
            m_axis_tdata => random_number1,
            m_axis_tvalid => valid,
            m_axis_tready => ready
        );

    -- Instantiate the second random number generator
    Y_GEN: entity work.random_generator_axi
        generic map (
            LFSR_INIT => X"11144222",
            DATA_WIDTH => 32,
            UPPER_LIMIT => UPPER_LIMIT_Y
        )
        port map (
            clk => clk,
            reset => reset,
            m_axis_tdata => random_number2,
            m_axis_tvalid => open,
            m_axis_tready => ready
        );

    -- Instantiate the third random number generator
    WIDTH_GEN: entity work.random_generator_axi
        generic map (
            LFSR_INIT => X"12587431",
            DATA_WIDTH => 32,
            UPPER_LIMIT => UPPER_LIMIT_WIDTH
        )
        port map (
            clk => clk,
            reset => reset,
            m_axis_tdata => random_number3,
            m_axis_tvalid => open,
            m_axis_tready => ready
        );

    -- Instantiate the fourth random number generator
    HEIGHT_GEN: entity work.random_generator_axi
        generic map (
            LFSR_INIT => X"88883333",
            DATA_WIDTH => 32,
            UPPER_LIMIT => UPPER_LIMIT_HEIGHT
        )
        port map (
            clk => clk,
            reset => reset,
            m_axis_tdata => random_number4,
            m_axis_tvalid => open,
            m_axis_tready => ready
        );

    -- Output connections
    X <= random_number1;
    Y <= random_number2;
    Width <= random_number3;
    Height <= random_number4;

end Behavioral;
