library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( clk         : in STD_LOGIC;
			  timer_input : in STD_LOGIC;
			  time_in_us  : out STD_LOGIC_VECTOR (31 downto 0));
end Counter;

architecture Behavioral of Counter is

	constant ClockFrequencyMHz : integer := 50; -- 50 MHz
	
	-- Timer is HIGH signal
	signal timer_is_high : STD_LOGIC := '0';

	signal Ticks        : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
	signal microseconds : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";

	
begin
	process(timer_input)
	begin
		--if rising_edge(timer_input) then
		if timer_input = '1' then
			timer_is_high <= '1';
		--elsif falling_edge(timer_input) then
		else 	
			timer_is_high <= '0';
			time_in_us    <= microseconds;
		end if;
	end process;
	
	process(clk)
	begin
		if rising_edge(Clk) and timer_is_high = '1' then
		
			-- Every us
			if conv_integer(unsigned(Ticks)) = ClockFrequencyMHz - 1 then 
				Ticks        <= x"00000000";
				microseconds <= microseconds + 1;
			else 
				Ticks <= Ticks + 1;
			end if;
		
		end if;
	end process;
end Behavioral;