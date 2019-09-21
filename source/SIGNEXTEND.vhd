library ieee;
use ieee.std_logic_1164.all;

entity SIGNEXTEND is
	port(i_VECTOR     : in  std_logic_vector(15 downto 0);  -- IN
		  o_SIGNEXTEND : out std_logic_vector(31 downto 0)); -- OUT
end entity SIGNEXTEND;

architecture arch0 of SIGNEXTEND is
begin
	process(i_VECTOR)
	begin
		o_SIGNEXTEND(15 downto 0) <= i_VECTOR;
		o_SIGNEXTEND(31 downto 16) <= (31 downto 16 => i_VECTOR(15));
	end process;
end arch0;