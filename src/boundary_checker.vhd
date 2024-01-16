library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for integer operations

entity boundary_checker is
    Generic (
        image_width : integer;   -- Image width as a generic parameter
        image_height : integer   -- Image height as a generic parameter
    );
    Port (
        clk : in std_logic;                   -- Clock signal
        reset : in std_logic;                 -- Reset signal
        
        x_in : in  integer;                   -- Input x coordinate
        y_in : in  integer;                   -- Input y coordinate
        crop_width_in : in  integer;          -- Input crop width
        crop_height_in : in  integer;         -- Input crop height
        valid_in : in std_logic;              -- Input valid signal
        
        x_out : out  integer;                 -- Output x coordinate
        y_out : out  integer;                 -- Output y coordinate
        crop_width_out : out  integer;        -- Adjusted crop width
        crop_height_out : out  integer;       -- Adjusted crop height
        ready_out : out std_logic;            -- Output ready signal
        valid_out : out std_logic             -- Output valid signal
    );
end boundary_checker;

architecture Behavioral of boundary_checker is
begin

    process(clk, reset)
    begin
        if reset = '1' then
            ready_out <= '0';
            valid_out <= '0';
        elsif rising_edge(clk) then
            if valid_in = '1' then
            
                if (crop_width_in <= 1) then 
                    crop_width_out <= image_width;
                    x_out <= 0;
                else
                     -- Check and adjust crop_width
                    if (x_in + crop_width_in > image_width) then
                        crop_width_out <= image_width - x_in;
                    else
                        crop_width_out <= crop_width_in;
                    end if;
                    -- Pass the input coordinates directly to the output
                    x_out <= x_in;
                end if;
                
                
                if (crop_height_in <= 1) then 
                    crop_height_out <= image_height;
                    y_out <= 0;
                else
                    -- Check and adjust crop_height
                    if (y_in + crop_height_in > image_height) then
                        crop_height_out <= image_height - y_in;
                    else
                        crop_height_out <= crop_height_in;
                    end if;
                    y_out <= y_in;
                end if;
            
                -- Indicate the output is ready
                ready_out <= '1';
                valid_out <= '1';

            else
                ready_out <= '0';
                valid_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
