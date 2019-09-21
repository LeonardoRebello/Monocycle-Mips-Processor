library ieee;
use ieee.std_logic_1164.all;

entity AND_Block is
	port(i_DATA01 : in  std_logic;  -- IN
		  i_DATA02 : in  std_logic;
		  o_RESULT : out std_logic); -- OUT
end entity AND_Block;

architecture arch0 of AND_Block is
begin
	process(i_DATA01, i_DATA02)
	begin
		o_RESULT <= i_DATA01 and i_DATA02;
	end process;
end arch0;
		