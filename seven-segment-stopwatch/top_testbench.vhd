LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_testbench IS
END top_testbench;
 
ARCHITECTURE behavior OF top_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         fclk : IN  std_logic;
         beg_number : IN  std_logic_vector(6 downto 0);
         pause : IN  std_logic_vector(9 downto 0);
         bflag : IN  std_logic;
         eflag : INOUT  std_logic;
			iolist_prve_cifre  : out STD_LOGIC_VECTOR (7 downto 0);
			iolist_druge_cifre : out STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal fclk       : std_logic := '0';
   signal beg_number : std_logic_vector(6 downto 0) := (others => '0');
   signal pause      : std_logic_vector(9 downto 0) := (others => '0');
   signal bflag      : std_logic := '0';

	--BiDirs
   signal eflag : std_logic := '1';
	
	--Outputs
	signal iolist_prve_cifre  : STD_LOGIC_VECTOR (7 downto 0) := x"00"; -- raspored pinova za prvu cifru
	signal iolist_druge_cifre : STD_LOGIC_VECTOR (7 downto 0) := x"00"; -- raspored pinova za drugu cifru 

   -- Clock period definitions
   constant ClockFrequencyMHz : integer := 50; -- 50 MHz
   constant ClockPeriod       : time := 1 us / ClockFrequencyMHz;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          fclk => fclk,
          beg_number => beg_number,
          pause => pause,
          bflag => bflag,
          eflag => eflag,
			 iolist_prve_cifre => iolist_prve_cifre,
			 iolist_druge_cifre => iolist_druge_cifre
        );

   -- Clock process definitions
   fclk_process :process
   begin
		fclk <= '0';
		wait for ClockPeriod/2;
		fclk <= '1';
		wait for ClockPeriod/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		beg_number <= "0010111";
		pause 	  <= "0000000001";
		
		bflag <= '1';
		
		wait for 2ms;
		
		bflag <= '0';

      wait;
   end process;

END;
