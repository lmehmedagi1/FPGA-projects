library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity seven_segment is
    Port ( fclk   : in  STD_LOGIC;
           number : in  STD_LOGIC_VECTOR (3 downto 0); -- jer je max broj 9
           iolist : out STD_LOGIC_VECTOR (7 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is

begin

	process(fclk)
	begin
		if rising_edge(fclk) then
			case number is
				 when "0000" => iolist <= "10000001"; -- "0"     
				 when "0001" => iolist <= "11001111"; -- "1" 
				 when "0010" => iolist <= "10010010"; -- "2" 
				 when "0011" => iolist <= "10000110"; -- "3" 
				 when "0100" => iolist <= "11001100"; -- "4" 
				 when "0101" => iolist <= "10100100"; -- "5" 
				 when "0110" => iolist <= "10100000"; -- "6" 
				 when "0111" => iolist <= "10001111"; -- "7" 
				 when "1000" => iolist <= "10000000"; -- "8"     
				 when "1001" => iolist <= "10000100"; -- "9" 
				 when others => iolist <= "11111111";
			 end case;
		end if;
	end process;
	
end Behavioral;

