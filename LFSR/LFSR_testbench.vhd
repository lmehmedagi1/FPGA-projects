LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY LFSR_testbench IS
END LFSR_testbench;
 
ARCHITECTURE behavior OF LFSR_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LFSR
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic;
	
	-- Outputs for testing
	signal test_outputs       : std_logic_vector(14 downto 0) := (others => '0');
	signal generated_sequence : std_logic_vector(14 downto 0) := "010010010010010";

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LFSR PORT MAP (
          reset => reset,
          clk => clk,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	
	-- Reset process
	reset_process :process
   begin
		reset <= '0';
		wait for 150 ns;
		reset <= '1';
		wait for 5 ns;
   end process;
	

   -- Stimulus process
   stim_proc: process
   begin		
		
		-- Read 15 values
		for I in 0 to 14 loop
			wait for 10 ns;
			test_outputs(I) <= output;
		end loop;


		-- test the outputs after reset
		for I in 0 to 14 loop
			wait for 10 ns;
			ASSERT (test_outputs(I) = output and output = generated_sequence(I)) report "Greska!" severity warning;
		end loop;


      wait;
   end process;

END;
