library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_LEFT_2 is
	port(i_VECTOR           : in  std_logic_vector(31 downto 0);  -- IN
		  o_SHIFTLEFT2VECTOR : out std_logic_vector(31 downto 0)); -- OUT
end entity SHIFT_LEFT_2;

architecture arch0 of SHIFT_LEFT_2 is
begin
	process(i_VECTOR)
	begin
		o_SHIFTLEFT2VECTOR <= std_logic_vector(shift_left(unsigned(i_VECTOR), 2));
	end process;
end arch0;
