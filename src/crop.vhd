--------------------------------------------------------------------------------
-- Title       : Image Cropping Module
-- Design      : crop
-- Author      : Mahmoud Amiri
-- Company     : 
-- Description : This VHDL module implements an image cropping function using the
--               AXI Stream protocol. It accepts video or image data streams and
--               configuration parameters to define the cropping region. The module
--               processes each pixel of the incoming stream and outputs the cropped
--               region. The cropping coordinates (X and Y offsets) and dimensions
--               (number of columns and rows) are configurable. Handshaking signals
--               are used for robust data transfer, ensuring the synchronization
--               of incoming and outgoing streams. The module is designed to handle
--               streaming pixel data and is suitable for real-time video or image
--               processing applications.
--
--               The module contains internal logic to track the position of each
--               pixel in the stream. Pixels falling within the specified cropping
--               region are passed to the output, while others are discarded. The
--               output stream adheres to the AXI Stream protocol, making it compatible
--               with other AXI Stream compliant modules.
--
-- Revision    : 1.0
-- Date        : 15.01.2024
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crop is
    port (
        clk : in std_logic;
        rst : in std_logic;
        -- Config
        cfg_x_offset : in std_logic_vector(15 downto 0);
        cfg_y_offset : in std_logic_vector(15 downto 0);
        cfg_cols : in std_logic_vector(15 downto 0);
        cfg_rows : in std_logic_vector(15 downto 0);
        -- Sink
        snk_tvalid : in std_logic;
        snk_tready : out std_logic;
        snk_tdata : in std_logic_vector(23 downto 0);
        snk_tlast : in std_logic;
        snk_tuser : in std_logic;
        -- Source
        src_tvalid : out std_logic;
        src_tready : in std_logic;
        src_tdata : out std_logic_vector(23 downto 0);
        src_tlast : out std_logic;
        src_tuser : out std_logic
    );
end entity crop;

architecture rtl of crop is
    -- Internal signals for position tracking and buffering
    signal x_counter, y_counter : unsigned(15 downto 0) := (others => '0');
    signal x, y : unsigned(15 downto 0) := (others => '0');
    signal can_accept_data_mid : std_logic := '1'; -- Control signal for data acceptance
    signal can_accept_data_out : std_logic := '1'; -- Control signal for data acceptance
    signal cfg_x_offset_r : std_logic_vector(15 downto 0);
    signal cfg_y_offset_r : std_logic_vector(15 downto 0);
    signal cfg_cols_r : std_logic_vector(15 downto 0);
    signal cfg_rows_r : std_logic_vector(15 downto 0);
    signal data_r : std_logic_vector(23 downto 0);
    signal last_r : std_logic;
    signal user_r : std_logic;
    signal valid_r : std_logic;
    signal data_r2 : std_logic_vector(23 downto 0);
    signal last_r2 : std_logic;
    signal user_r2 : std_logic;
    signal valid_r2 : std_logic;
begin
    process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset logic
                x_counter <= (others => '0');
                y_counter <= (others => '0');
                can_accept_data_mid <= '0';
                can_accept_data_out <= '0';
                src_tdata <= (others => '0');
                src_tvalid <= '0';
                src_tlast <= '0';
                src_tuser <= '0';
                data_r <= (others => '0');
                last_r <= '0';
                user_r <= '0';
                valid_r <= '0';
                data_r2 <= (others => '0');
                last_r2 <= '0';
                user_r2 <= '0';
                valid_r2 <= '0';
                x <= (others => '0');
                y <= (others => '0');
                snk_tready <= '1';
            else   
                -- Input Handshaking
                if (snk_tvalid = '1' ) then
                     -- Pixel Position Tracking
                    if snk_tuser = '1' then
                        y_counter <= (others => '0');
                        x_counter <= (others => '0');
                        cfg_x_offset_r <= cfg_x_offset;
                        cfg_y_offset_r <= cfg_y_offset;
                        cfg_cols_r <= cfg_cols;
                        cfg_rows_r <= cfg_rows;
                    elsif snk_tlast = '1' then
                        x_counter <= (others => '0');
                        y_counter <= y_counter + 1;
                    else
                        x_counter <= x_counter + 1;
                    end if;
                end if;
                x <= x_counter;
                y <= y_counter;
                data_r <= snk_tdata;
                last_r <= snk_tlast;
                user_r <= snk_tuser;
                valid_r <= snk_tvalid;
                snk_tready <= can_accept_data_mid;
                
                -- Middle Stage
                -- Check if in Crop Region
                valid_r2 <= '0'; 
                user_r2 <= '0';
                last_r2 <= '0';
                if (valid_r = '1' ) then
                    if ((x >= unsigned(cfg_x_offset_r)) and 
                                      (x < unsigned(cfg_x_offset_r) + unsigned(cfg_cols_r)) and 
                                      (y >= unsigned(cfg_y_offset_r)) and 
                                      (y < unsigned(cfg_y_offset_r) + unsigned(cfg_rows_r))) then
                        if ((x  = unsigned(cfg_x_offset_r)) and (y = unsigned(cfg_y_offset_r))) then 
                            user_r2 <= '1';   --start of frame   
                        end if;
                        
                        if (x + 1 = (unsigned(cfg_x_offset_r) + unsigned(cfg_cols_r))) then 
                            last_r2 <= '1';   --end line        
                        end if;
                        data_r2 <= data_r;
                        valid_r2 <= '1';
                    else
                         data_r2 <= (others=>'0');  
                    end if; 
                end if; 
                can_accept_data_mid <= can_accept_data_out; -- Ready to accept new data 

                -- Output Handshaking
                src_tdata <= data_r2;
                src_tlast <= last_r2;
                src_tuser <= user_r2;
                src_tvalid <= valid_r2;
                can_accept_data_out <= src_tready;
                
            end if;
        end if;
    end process;
end rtl;
