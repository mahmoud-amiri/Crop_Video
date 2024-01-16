--------------------------------------------------------------------------------
-- Title       : Image Cropping Module Testbench (top_tb)
-- Author      : Mahmoud Amiri
-- Date        : 15.01.2024
-- Description : This VHDL module, 'top_tb', is a comprehensive testbench for an
--               image cropping module using the AXI Stream protocol. The testbench
--               simulates a complete environment to validate the cropping operation.
--               Key components include:
--               1. Clk_Reset_Gen: Generates synchronized clock and reset signals.
--               2. Random_Test_Vector_Top: Produces random cropping parameters
--                  while ensuring they remain within image boundaries.
--               3. Video_Generator: Simulates an AXI video stream where pixel data
--                  represents [x, y] coordinates (24-bit, 12 bits each).
--               4. Crop Entity (DUT): The core module under test that performs the
--                  cropping operation on the video stream.
--               5. Video_Properties_Extractor: Extracts the properties of the cropped
--                  video for validation purposes.
--               6. Comparator: Compares the expected cropping dimensions with actual
--                  output for result verification and write the errors on Output.txt file.
--
--------------------------------------------------------------------------------

-- [VHDL code starts here...]

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity top_tb is

end entity top_tb;

architecture Behavioral of top_tb is
    constant frame_width: natural:= 1920;
    constant frame_height: natural:= 1080;
    signal clk : std_logic;
    signal snk_tdata : std_logic_vector(23 downto 0);
    signal snk_tvalid : std_logic;
    signal snk_tlast : std_logic;
    signal snk_tuser : std_logic;
    signal snk_tready : std_logic;
    signal src_tdata : std_logic_vector(23 downto 0);
    signal src_tvalid : std_logic;
    signal src_tlast : std_logic;
    signal src_tuser : std_logic;
    signal src_tready : std_logic:='1';
    signal video_width : std_logic_vector(15 downto 0);
    signal video_height : std_logic_vector(15 downto 0);
    signal first_pixel_of_frame : std_logic_vector(23 downto 0);
    signal reset : std_logic;
    signal out_valid : std_logic;
    signal mask : std_logic;
    signal mask_r : std_logic;
    signal mask_r2 : std_logic;
    signal mask_r3 : std_logic;
    signal mask_r4 : std_logic;
    signal mask_r5 : std_logic;
    signal cfg_x_offset, cfg_y_offset, cfg_cols, cfg_rows : std_logic_vector(15 DOWNTO 0);
    signal x_in : integer;
    signal y_in : integer;
    signal width_in : integer;
    signal height_in : integer;
    signal x_in_r : integer;
    signal y_in_r : integer;
    signal width_in_r : integer;
    signal height_in_r : integer;
    signal x_in_r2 : integer;
    signal y_in_r2 : integer;
    signal width_in_r2 : integer;
    signal height_in_r2 : integer;
    signal x_in_r3 : integer;
    signal y_in_r3 : integer;
    signal width_in_r3 : integer;
    signal height_in_r3 : integer;
    signal x_out : integer;
    signal y_out : integer;
    signal width_out : integer;
    signal height_out : integer;
    signal x_out_r : integer;
    signal y_out_r : integer;
    signal width_out_r : integer;
    signal height_out_r : integer;
    signal all_equal : std_logic;
    signal x_rand, y_rand, crop_width_rand, crop_height_rand : integer;
    signal rand_ready : std_logic := '0';
    signal rand_valid : std_logic;
    signal valid_param : std_logic;
    signal start : std_logic;
    
    
    -- Component declaration for clk_reset_gen
    component clk_reset_gen
        Generic ( 
            clk_period : time;
            reset_duration : time
        );
        Port ( 
            clk_out : out  std_logic;
            reset_out : out  std_logic
        );
    end component;
    
    
    component data_controller is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        snk_tuser : in std_logic;
        x_rand : in integer;
        y_rand : in integer;
        crop_width_rand : in integer;
        crop_height_rand : in integer;
        x_out : out integer;
        y_out : out integer;
        width_out : out integer;
        height_out : out integer;
        cfg_x_offset : out std_logic_vector(15 downto 0);
        cfg_y_offset : out std_logic_vector(15 downto 0);
        cfg_cols : out std_logic_vector(15 downto 0);
        cfg_rows : out std_logic_vector(15 downto 0);
        rand_ready : out std_logic;
        out_valid : out std_logic
    );
    end component;

    -- Component declaration for the random_test_vector_top
    component random_test_vector_top
    Generic (
        image_width : integer := frame_width;
        image_height : integer := frame_height
    );
    Port (
        clk : in std_logic;
        reset : in std_logic;
        x_out : out integer;
        y_out : out integer;
        crop_width_out : out integer;
        crop_height_out : out integer;
        ready : in std_logic;
        valid : out std_logic
    );
    end component;
    
    -- Component declarations
    component video_generator
    Generic (
        frame_width : natural := frame_width;     -- Example image width
        frame_height : natural := frame_height     -- Example image height
    );
        port(
            clk : in std_logic;
            reset : in std_logic;
            snk_tdata : out std_logic_vector(23 downto 0);
            snk_tvalid : out std_logic;
            snk_tlast : out std_logic;
            snk_tuser : out std_logic;
            snk_tready : in std_logic
        );
    end component;

    -- Component declaration of the crop entity
    COMPONENT crop
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            cfg_x_offset : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            cfg_y_offset : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            cfg_cols : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            cfg_rows : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            snk_tvalid : IN STD_LOGIC;
            snk_tready : OUT STD_LOGIC;
            snk_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
            snk_tlast : IN STD_LOGIC;
            snk_tuser : IN STD_LOGIC;
            src_tvalid : OUT STD_LOGIC;
            src_tready : IN STD_LOGIC;
            src_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
            src_tlast : OUT STD_LOGIC;
            src_tuser : OUT STD_LOGIC
        );
    END COMPONENT;
    
    component video_properties_extractor
        port(
            clk : in std_logic;
            reset : in std_logic;
            s_axis_tdata : in std_logic_vector(23 downto 0);
            s_axis_tvalid : in std_logic;
            s_axis_tlast : in std_logic;
            s_axis_tuser : in std_logic;
            video_width : out std_logic_vector(15 downto 0);
            video_height : out std_logic_vector(15 downto 0);
            first_pixel_of_frame : out std_logic_vector(23 downto 0);
            valid   : out std_logic
        );
    end component;
    
    component comparator
    Port (
        clk : in std_logic;
        reset : in std_logic;
        x_in : in integer;
        y_in : in integer;
        width_in : in integer;
        height_in : in integer;
        x_out : in integer;
        y_out : in integer;
        width_out : in integer;
        height_out : in integer;
        all_equal : out std_logic;
        valid : in std_logic
    );
    end component;

begin

    -- Instantiate clk_reset_gen    
    clk_reset_generator: clk_reset_gen
    generic map (
        clk_period => 10 ns,       -- Set your desired clock period
        reset_duration => 50 ns    -- Set your desired reset duration
    )
    port map (
        clk_out => clk,
        reset_out => reset
    );
 
       -- Instantiate the Unit Under Test (UUT)
    random_test_vector_gen_inst: random_test_vector_top
        port map (
            clk => clk,
            reset => reset,
            x_out => x_rand,
            y_out => y_rand,
            crop_width_out => crop_width_rand,
            crop_height_out => crop_height_rand,
            ready => rand_ready,
            valid => rand_valid
        );
        
    -- Instantiate video_generator
    video_stream_gen_inst: video_generator
        port map(
            clk => clk,
            reset => reset,
            snk_tdata => snk_tdata,
            snk_tvalid => snk_tvalid,
            snk_tlast => snk_tlast,
            snk_tuser => snk_tuser,
            snk_tready => snk_tready
        );

    -- Instantiate the crop entity
    DUT : crop
        PORT MAP (
            clk => clk,
            rst => reset,
            cfg_x_offset => cfg_x_offset,
            cfg_y_offset => cfg_y_offset,
            cfg_cols => cfg_cols,
            cfg_rows => cfg_rows,
            snk_tvalid => snk_tvalid,
            snk_tready => snk_tready,
            snk_tdata => snk_tdata,
            snk_tlast => snk_tlast,
            snk_tuser => snk_tuser,
            src_tvalid => src_tvalid,
            src_tready => src_tready,
            src_tdata => src_tdata,
            src_tlast => src_tlast,
            src_tuser => src_tuser
        );
        

    --buffer data for compare
    process(clk, reset)
    begin
        if reset = '1' then
           rand_ready <= '0';
           out_valid <= '0';
           mask <= '1';
           mask_r <= '0';
           mask_r2 <= '0';
           mask_r3 <= '0';
           mask_r4 <= '0';
           mask_r5 <= '0';
        elsif rising_edge(clk) then
            rand_ready <= '0';
            out_valid <= '0';
            if(snk_tuser = '1' and snk_tvalid = '1')then
                mask_r <= mask;
                mask_r2 <= mask_r;
                mask_r3 <= mask_r2;
                mask_r4 <= mask_r3;
                mask_r5 <= mask_r4;
                cfg_x_offset <= std_logic_vector(to_unsigned(x_rand, cfg_x_offset'length));
                cfg_y_offset <= std_logic_vector(to_unsigned(y_rand, cfg_y_offset'length));
                cfg_cols <= std_logic_vector(to_unsigned(crop_width_rand, cfg_cols'length));
                cfg_rows <= std_logic_vector(to_unsigned(crop_height_rand, cfg_rows'length));
                x_in <= x_rand;
                y_in <= y_rand;
                width_in <= crop_width_rand;
                height_in <= crop_height_rand;   
                x_in_r <= x_in;
                y_in_r <= y_in;
                width_in_r <= width_in;
                height_in_r <= height_in; 
                x_in_r2 <= x_in_r;
                y_in_r2 <= y_in_r;
                width_in_r2 <= width_in_r;
                height_in_r2 <= height_in_r; 
                x_in_r3 <= x_in_r2;
                y_in_r3 <= y_in_r2;
                width_in_r3 <= width_in_r2;
                height_in_r3 <= height_in_r2;
                x_out_r <= x_out;
                y_out_r <= y_out;
                width_out_r <= width_out;
                height_out_r <= height_out; 
                rand_ready <= '1';
                out_valid <= '1';
            end if;
        end if;
    end process;
    
       
    -- Instantiate video_properties_extractor
    croped_video_size_extractor_inst: video_properties_extractor
        port map(
            clk => clk,
            reset => reset,
            s_axis_tdata => src_tdata,
            s_axis_tvalid => src_tvalid,
            s_axis_tlast => src_tlast,
            s_axis_tuser => src_tuser,
            video_width => video_width,
            video_height => video_height,
            first_pixel_of_frame => first_pixel_of_frame,
            valid  => open--out_valid
        );


    -- Instantiate comparator
    check_result_report_inst: comparator
    port map (
        clk => clk,
        reset => reset,
        x_in => x_in_r3,
        y_in => y_in_r3,
        width_in => width_in_r3,
        height_in => height_in_r3,
        x_out => x_out_r,
        y_out => y_out_r,
        width_out => width_out_r,
        height_out => height_out_r,
        all_equal => all_equal,
        valid => (out_valid and mask_r5)
    );
    
    x_out <= to_integer(unsigned(first_pixel_of_frame(11 downto 0)));
    y_out <= to_integer(unsigned(first_pixel_of_frame(23 downto 12)));
    width_out <= to_integer(unsigned(video_width));
    height_out <= to_integer(unsigned(video_height));

end Behavioral;
