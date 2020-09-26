library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timer is
    Port ( Clk   : in  STD_LOGIC;
			  delay : in  STD_LOGIC_VECTOR (31 downto 0);
           width : in  STD_LOGIC_VECTOR (31 downto 0);
           timer_output : out STD_LOGIC := '0');
end Timer;

architecture Behavioral of Timer is

	constant ClockFrequencyMHz : integer := 50; -- 50 MHz
	
	-- Signal for counting clock periods
	signal Ticks        : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
	-- Counter
	signal microseconds : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
	-- One shot mode
	signal generated     : STD_LOGIC := '0';
	signal delay_is_over : STD_LOGIC := '0'; 
begin
	process(Clk)
	begin
		if rising_edge(Clk) and generated = '0' then
		
			-- Special case
			if delay = "00000000" then
				delay_is_over <= '1';
				timer_output  <= '1';
			end if;
			
			-- Every us
			if conv_integer(unsigned(Ticks)) = ClockFrequencyMHz - 2 then 
				Ticks        <= x"00000000";
				microseconds <= microseconds + 1;
				
				if microseconds = delay and delay_is_over = '0' then
					delay_is_over <= '1';
					microseconds  <= x"00000000";
					timer_output  <= '1';
				end if;
				
				if microseconds = width and delay_is_over = '1' then
					timer_output <= '0';
					generated    <= '1'; 
				end if;
				
			else 
				Ticks <= Ticks + 1;
			end if;
		
		end if;
	end process;
end Behavioral;