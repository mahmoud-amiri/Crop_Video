library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity random_test_vector_top is
    Generic (
        image_width : integer := 1920;     -- Example image width
        image_height : integer := 1080     -- Example image height
    );
    Port (
        clk : in std_logic;
        reset : in std_logic;
        x_out: out integer; 
        y_out :out integer; 
        crop_width_out : out integer;
        crop_height_out : out integer;
        ready : in std_logic;
        valid : out std_logic
    );
end random_test_vector_top;

architecture Behavioral of random_test_vector_top is
    -- Signals for interfacing between test_vec_gen and boundary_checker
    signal X, Y, Width, Height : unsigned(31 downto 0);
    signal valid_in, valid_out, ready_out : std_logic;
    -- Component declarations
    component test_vec_gen
        generic (
            UPPER_LIMIT_X : unsigned(32-1 downto 0);
            UPPER_LIMIT_Y : unsigned(32-1 downto 0);
            UPPER_LIMIT_Width : unsigned(32-1 downto 0);
            UPPER_LIMIT_Height : unsigned(32-1 downto 0)
        );
        port (
            clk : in std_logic;
            reset : in std_logic;
            X : out unsigned(31 downto 0);
            Y : out unsigned(31 downto 0);
            Width : out unsigned(31 downto 0);
            Height : out unsigned(31 downto 0);
            ready : in std_logic;
            valid : out std_logic
        );
    end component;

    component boundary_checker
        generic (
            image_width : integer;
            image_height : integer
        );
        port (
            clk : in std_logic;
            reset : in std_logic;
            valid_in : in std_logic;
            x_in : in  integer;
            y_in : in  integer;
            crop_width_in : in  integer;
            crop_height_in : in  integer;
            ready_out : out std_logic;
            x_out : out  integer;
            y_out : out  integer;
            crop_width_out : out  integer;
            crop_height_out : out  integer;
            valid_out : out std_logic
        );
    end component;

begin
    -- Instantiate test_vec_gen
    test_gen: test_vec_gen
        generic map (
            UPPER_LIMIT_X => to_unsigned(image_width, 32),
            UPPER_LIMIT_Y => to_unsigned(image_height, 32),
            UPPER_LIMIT_Width => to_unsigned(image_width, 32),
            UPPER_LIMIT_Height => to_unsigned(image_height, 32)
        )
        port map (
            clk => clk,
            reset => reset,
            X => X,
            Y => Y,
            Width => Width,
            Height => Height,
            ready => ready,
            valid => valid_in
        );

    -- Instantiate boundary_checker
    boundary_check: boundary_checker
        generic map (
            image_width => image_width,
            image_height => image_height
        )
        port map (
            clk => clk,
            reset => reset,
            valid_in => valid_in,
            x_in => to_integer(unsigned(X)),
            y_in => to_integer(unsigned(Y)),
            crop_width_in => to_integer(unsigned(Width)),
            crop_height_in => to_integer(unsigned(Height)),
            ready_out => open,
            x_out => x_out,
            y_out => y_out,
            crop_width_out => crop_width_out,
            crop_height_out => crop_height_out,
            valid_out => valid
        );

    -- Logic to generate valid_in signal
    -- This can be a simple logic or a more complex one depending on your requirements
--    valid_in <= '1' when not reset else '0';

end Behavioral;
