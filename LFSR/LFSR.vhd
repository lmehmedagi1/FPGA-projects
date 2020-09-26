library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFSR is
    Port ( reset  : in  STD_LOGIC;
           clk    : in  STD_LOGIC;
           output : out  STD_LOGIC);
end LFSR;

architecture Behavioral of LFSR is
	signal r_curr, r_next : std_logic_vector(7 downto 0) := "01100101"; 
	signal bit_zero       : std_logic := '0';
	signal curr_output    : std_logic := '0';
	constant SEED         : std_logic_vector(7 downto 0) := "01100101";

begin

	-- change output when clock changes
	process(clk, reset)
	begin
		if reset = '1' then
			r_curr <= SEED;
		end if;
		
		if	rising_edge(clk) then
			output <= curr_output;
			r_curr <= r_next;
		end if;
	end process;
	
	-- update next state
	bit_zero <= r_curr(1) xor (r_curr(5) xor r_curr(7));
	r_next <= r_curr(6 downto 0) & bit_zero;  
	
	-- output update
	curr_output <= r_curr(4) xor r_curr(7);

end Behavioral;

