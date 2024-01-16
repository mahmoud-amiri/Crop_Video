library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity video_generator is
Generic (
        frame_width : natural := 1920;     -- Example image width
        frame_height : natural := 1080     -- Example image height
    );
    port(
        clk : in std_logic;
        reset: in std_logic;
        snk_tdata : out std_logic_vector(23 downto 0);
        snk_tvalid : out std_logic;
        snk_tlast : out std_logic;
        snk_tuser : out std_logic;
        snk_tready : in std_logic  -- signal to indicate if the receiver is ready
    );
end entity video_generator;

architecture behavior of video_generator is

    signal current_row : natural := 0;
    signal current_col : natural := 0;

begin

 video_process: process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
                -- Reset all internal state and output signals
                current_row <= 0;
                current_col <= 0;
                snk_tdata <= (others => '0');
                snk_tvalid <= '0';
                snk_tlast <= '0';
                snk_tuser <= '0';
        elsif snk_tready = '1' then  -- Check if the receiver is ready
            -- Combine row and column information into snk_tdata
            snk_tdata <= std_logic_vector(to_unsigned(current_row, 12)) & std_logic_vector(to_unsigned(current_col, 12));
            
            -- Indicate that the data is valid
            snk_tvalid <= '1';

            -- Use snk_tuser to indicate the start of a new frame
            if current_row = 0 and current_col = 0 then
                snk_tuser <= '1';  -- Set for the first pixel of a new frame
            else
                snk_tuser <= '0';  -- Reset for all other pixels
            end if;

            -- Set snk_tlast for the last pixel of each line
            if current_col = frame_width - 1 then
                snk_tlast <= '1';  -- Set for the last pixel of a line
            else
                snk_tlast <= '0';  -- Reset for all other pixels
            end if;

            -- Update current_row and current_col
            if current_col = frame_width - 1 then
                current_col <= 0;  -- Reset column at the end of a line
                if current_row = frame_height - 1 then
                    current_row <= 0;  -- Reset row at the end of a frame
                else
                    current_row <= current_row + 1;  -- Increment row at the end of a line
                end if;
            else
                current_col <= current_col + 1;  -- Increment column for the next pixel
            end if;
        else
            -- If the receiver is not ready, hold the current state
            snk_tvalid <= '0';
        end if;
    end if;
end process video_process;


end architecture behavior;
