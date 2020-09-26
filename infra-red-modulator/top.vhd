library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
    Port ( tsone   : in  STD_LOGIC_VECTOR (31 downto 0);
           tsoneH  : in  STD_LOGIC_VECTOR (31 downto 0);
           tszero  : in  STD_LOGIC_VECTOR (31 downto 0);
           tszeroH : in  STD_LOGIC_VECTOR (31 downto 0);
           tp      : in  STD_LOGIC_VECTOR (31 downto 0);
           data    : in  STD_LOGIC_VECTOR (31 downto 0);
           tsstart : in  STD_LOGIC_VECTOR (31 downto 0);
           tstartH : in  STD_LOGIC_VECTOR (31 downto 0);
           bflag   : in  STD_LOGIC;
           eflag   : inout  STD_LOGIC; 
           fclk    : in  STD_LOGIC;
    		  output  : inout STD_LOGIC);
end top;

architecture Behavioral of top is

constant ClockFrequencyMHz : integer := 50; -- 50 MHz

signal txdata : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
signal dsize  : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";

begin

process(fclk)

	variable vrijemeZnaka  : integer:=0; -- vrijeme tsone ili tszero    
	variable vrijemeH      : integer:=0; -- vrijeme tsoneH ili tszeroH
	variable vrijemeTPpola : integer:=0; -- vrijeme tp/2
	variable vrijeme       : integer:=0; -- microseconds
	variable ticks         : integer:=0; -- clock ticks
	variable idx           : integer:=0; -- indeks trenutnog bita
	
	variable TPpola : integer := 0;

begin
	if rising_edge(fclk) then

		if bflag = '1' and eflag = '1' then
			dsize  <= x"00000021";
			txdata <= data;
			eflag  <= '0';
			
			output <= '0';
			
			vrijemeZnaka := conv_integer(unsigned(tsstart));
			vrijemeH     := conv_integer(unsigned(tstartH));
			
			idx := 0;
			TPpola := conv_integer(unsigned(tp))/2;
			
			-- reset vrijeme
			vrijeme       := 0;
			vrijemeTPpola := 0;
			ticks         := 0;
			
		end if;
		
		if dsize > 0 then
		
			ticks := ticks + 1;
		
			if ticks = ClockFrequencyMHz then 
				ticks         := 0;
				vrijeme       := vrijeme + 1;
				vrijemeTPpola := vrijemeTPpola + 1;
				
				if vrijeme < vrijemeZnaka then
					if vrijeme < vrijemeH then
						if vrijemeTPpola >= TPpola then
							output <= not output;
							vrijemeTPpola := 0;
						end if;
					else 
						output <= '0';
					end if;
				elsif idx < 32 then 
					if txdata(31-idx) = '1' then
						vrijemeZnaka := conv_integer(unsigned(tsone));
						vrijemeH     := conv_integer(unsigned(tsoneH));
					else 
						vrijemeZnaka := conv_integer(unsigned(tszero));
						vrijemeH     := conv_integer(unsigned(tszeroH));
					end if;
					idx := idx + 1;
					dsize <= dsize - 1; 
					vrijeme := 0;
				else 
					dsize <= dsize - 1;
				end if;
			end if;
		else 
			eflag <= '1';
		end if;

	end if;
end process;

end Behavioral;