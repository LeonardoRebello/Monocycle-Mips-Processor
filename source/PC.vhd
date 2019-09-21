library ieee;
use ieee.std_logic_1164.all;

entity PC is
	port(i_NEXTPC : in  std_logic_vector(31 downto 0);  -- IN
		  i_CLOCK  : in  std_logic;
		  i_RESET  : in  std_logic;
		  o_NEXTPC : out std_logic_vector(31 downto 0)); -- OUT
end entity PC;

architecture arch0 of PC is
begin
	process(i_RESET, i_CLOCK)
	begin
		if i_RESET = '1' then
				o_NEXTPC <= x"00400000";
		else
			if(rising_edge(i_CLOCK)) then
				o_NEXTPC <= i_NEXTPC;
			end if;
		end if;	
	end process;
end arch0;