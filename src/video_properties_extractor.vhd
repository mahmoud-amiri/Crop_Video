library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity video_properties_extractor is
    port(
        clk : in std_logic;
        reset : in std_logic;  -- Added reset signal
        -- AXI Stream input interface
        s_axis_tdata : in std_logic_vector(23 downto 0);
        s_axis_tvalid : in std_logic;
        s_axis_tlast : in std_logic;
        s_axis_tuser : in std_logic;
        -- Video size output
        video_width : out std_logic_vector(15 downto 0); -- Example width size
        video_height : out std_logic_vector(15 downto 0); -- Example height size
        first_pixel_of_frame : out std_logic_vector(23 downto 0); -- First pixel of each frame
        valid   : out std_logic
    );
end entity video_properties_extractor;

architecture behavior of video_properties_extractor is
    signal row_count : natural := 0;
    signal col_count : natural := 0;
    signal video_width_r : std_logic_vector(15 downto 0); 
    signal first_pixel_of_frame_r : std_logic_vector(23 downto 0); 
    signal frame_started : boolean := false;
    signal first_pixel_captured : boolean := false;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- Reset all internal signals to their initial state
                row_count <= 0;
                col_count <= 0;
                video_width <= (others => '0');
                video_width_r <= (others => '0');
                video_height <= (others => '0');
                first_pixel_of_frame <= (others => '0');
                frame_started <= false;
                valid <= '0';
            else
                if s_axis_tvalid = '1' then
                    -- Detect start of a new frame
                    if s_axis_tuser = '1' then
                        row_count <= 0;
                        col_count <= 1;
                        first_pixel_of_frame_r <= s_axis_tdata;
                        frame_started <= true;
                    end if;

                    -- Count columns
                    if s_axis_tlast = '0' then
                        col_count <= col_count + 1;
                    else
                        -- End of a row
                        row_count <= row_count + 1;
                        video_width_r <= std_logic_vector(to_unsigned(col_count + 1, video_width'length));
                        col_count <= 0;
                        
                    end if;

                    
                    -- Update height at the end of the frame
                    valid <= '0';
                    if frame_started and s_axis_tuser = '1' then
                        video_width <= video_width_r;
                        video_height <= std_logic_vector(to_unsigned(row_count, video_height'length));
                        first_pixel_of_frame <= first_pixel_of_frame_r;
                        valid <= '1';
                    end if;
                    
                end if;
            end if;
        end if;
    end process;
end architecture behavior;
