LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Counter_testbench IS
END Counter_testbench;
 
ARCHITECTURE behavior OF Counter_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         clk : IN  std_logic;
         timer_input : IN  std_logic;
         time_in_us : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal timer_input : std_logic := '0';

 	--Outputs
   signal time_in_us : std_logic_vector(31 downto 0);

   -- Set up clock for testing
   constant ClockFrequencyMHz : integer := 50; -- 50 MHz
   constant ClockPeriod       : time := 1 us / ClockFrequencyMHz;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          clk => clk,
          timer_input => timer_input,
          time_in_us => time_in_us
        );

   -- Clock process definitions
   clk <= not clk after ClockPeriod / 2;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		timer_input <= '0';
		wait for 50 us;
		timer_input <= '1';
		wait for 50 us;
		timer_input <= '0';
      wait for 50 us;	

		ASSERT (time_in_us = x"00000032") report "Greska!" severity warning;

   end process;

END;
