library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity top is
    Port ( fclk       : in  STD_LOGIC;
           beg_number : in  STD_LOGIC_VECTOR (6 downto 0);
           pause      : in  STD_LOGIC_VECTOR (9 downto 0); -- in ms
           bflag      : in  STD_LOGIC;
           eflag      : inout  STD_LOGIC;
			  iolist_prve_cifre  : out STD_LOGIC_VECTOR (7 downto 0);
			  iolist_druge_cifre : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

	-- Component
	component seven_segment is
		Port ( fclk   : in  STD_LOGIC;
             number : in  STD_LOGIC_VECTOR (3 downto 0); -- jer je max broj 9
				 iolist : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	constant ClockFrequencyMHz : integer := 50; -- 50 MHz
	
	signal first_digit  : STD_LOGIC_VECTOR (3 downto 0) := x"0"; -- jedinica
	signal second_digit : STD_LOGIC_VECTOR (3 downto 0) := x"0"; -- desetica

begin

	prva_cifra  : seven_segment port map (fclk => fclk, number => first_digit,  iolist => iolist_prve_cifre);
	druga_cifra : seven_segment port map (fclk => fclk, number => second_digit, iolist => iolist_druge_cifre);

	process(fclk)
	
		variable vrijeme : integer:=0; -- microseconds
		variable ticks   : integer:=0; -- clock ticks
		variable broj    : integer:=0; -- beg number
		variable period  : integer:=0; -- pause
		
	begin
		if rising_edge(fclk) then
		
			if bflag = '1' and eflag = '1' then
				
				eflag <= '0';
				
				broj    := to_integer(unsigned(beg_number));
				period  := to_integer(unsigned(pause)) * 1000; -- in us
				
				first_digit  <= std_logic_vector(to_unsigned(broj mod 10, first_digit'length));
				second_digit <= std_logic_vector(to_unsigned(broj/10, second_digit'length));
				
				vrijeme := 0;
				ticks   := 0;
				
			end if;
			
			if broj > 0 then
				ticks := ticks + 1;
			
				if ticks = ClockFrequencyMHz then 
					ticks         := 0;
					vrijeme       := vrijeme + 1;
					
					if vrijeme = period then 
						broj := broj - 1;
						
						first_digit  <= std_logic_vector(to_unsigned(broj mod 10, first_digit'length));
						second_digit <= std_logic_vector(to_unsigned(broj/10, second_digit'length));
				
				
						vrijeme := 0;
					end if;
					
				end if;
				
				
				
			else
				eflag <= '1';
			end if;

		
		end if;
	end process;

end Behavioral;

