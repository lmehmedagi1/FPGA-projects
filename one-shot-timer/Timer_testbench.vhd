LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Timer_testbench IS
END Timer_testbench;
 
ARCHITECTURE behavior OF Timer_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Timer
    PORT(
         Clk : IN  std_logic;
         delay : IN  std_logic_vector(31 downto 0);
         width : IN  std_logic_vector(31 downto 0);
         timer_output : OUT  std_logic
        );
    END COMPONENT;
    
	-- Set up clock for testing
   constant ClockFrequencyMHz : integer := 50; -- 50 MHz
   constant ClockPeriod       : time := 1 us / ClockFrequencyMHz;

   --Inputs
   signal Clk : std_logic := '0';
   signal delay : std_logic_vector(31 downto 0) := (others => '0');
   signal width : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal timer_output : std_logic := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Timer
		  PORT MAP (
          Clk => Clk,
          delay => delay,
          width => width,
          timer_output => timer_output
        );

   -- Clock process definitions
   Clk <= not Clk after ClockPeriod / 2;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		delay <= x"00000064"; 
		width <= x"00000032";
      wait for 10 us;	
		
		ASSERT (timer_output = '0') report "Greska!" severity warning;
		
		wait for 100 us;
		
		ASSERT (timer_output = '1') report "Greska, impuls se nije generisao na vrijeme!" severity warning;
		
		wait for 60 us;
		
		ASSERT (timer_output = '0') report "Greska, impuls nije ispravne sirine!" severity warning;

      wait;
   end process;

END;
