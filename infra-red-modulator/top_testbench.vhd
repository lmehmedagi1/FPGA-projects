LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_testbench IS
END top_testbench;
 
ARCHITECTURE behavior OF top_testbench IS 

 
    COMPONENT top
    PORT(
         tsone   : IN  std_logic_vector(31 downto 0);
         tsoneH  : IN  std_logic_vector(31 downto 0);
         tszero  : IN  std_logic_vector(31 downto 0);
         tszeroH : IN  std_logic_vector(31 downto 0);
         tp      : IN  std_logic_vector(31 downto 0);
         data    : IN  std_logic_vector(31 downto 0);
         tsstart : IN  std_logic_vector(31 downto 0);
         tstartH : IN  std_logic_vector(31 downto 0);
         bflag   : IN  std_logic;
         eflag   : INOUT  std_logic;
         fclk    : IN  std_logic;
         output  : INOUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal tsone   : std_logic_vector(31 downto 0) := (others => '0');
   signal tsoneH  : std_logic_vector(31 downto 0) := (others => '0');
   signal tszero  : std_logic_vector(31 downto 0) := (others => '0');
   signal tszeroH : std_logic_vector(31 downto 0) := (others => '0');
   signal tp      : std_logic_vector(31 downto 0) := (others => '0');
   signal data    : std_logic_vector(31 downto 0) := (others => '0');
   signal tsstart : std_logic_vector(31 downto 0) := (others => '0');
   signal tstartH : std_logic_vector(31 downto 0) := (others => '0');
   signal bflag   : std_logic := '0';
   signal fclk    : std_logic := '0';

    --BiDirs
   signal output : std_logic := '0';
   signal eflag  : std_logic := '1';

   -- Clock period definitions
   constant ClockFrequencyMHz : integer := 50; -- 50 MHz
   constant ClockPeriod       : time    := 1 us / ClockFrequencyMHz;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          tsone   => tsone,
          tsoneH  => tsoneH,
          tszero  => tszero,
          tszeroH => tszeroH,
          tp      => tp,
          data    => data,
          tsstart => tsstart,
          tstartH => tstartH,
          bflag   => bflag,
          eflag   => eflag,
          fclk    => fclk,
          output  => output
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
	
		tsone   <= x"00000465"; -- 1125 us
		tsoneH  <= x"00000226"; -- 550 us
		tszero  <= x"000008CA"; -- 2250 us
		tszeroH <= x"00000226"; -- 550 us
		tp      <= x"00000019"; -- 25 us
		data    <= x"A52149B6"; 
		tsstart <= x"000034BC"; -- 13500 us
		tstartH <= x"00001194"; -- 4500 us
		
		bflag <= '1';
		
		wait for 10ms;
		
		bflag <= '0';
		
		wait;

   end process;

END;
