library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ADD is
	port(i_DATA01 : in  std_logic_vector(31 downto 0);  -- IN
		  i_DATA02 : in  std_logic_vector(31 downto 0);
		  o_RESULT : out std_logic_vector(31 downto 0)); -- OUT
end entity ADD;

architecture arch0 of ADD is
begin
	process(i_DATA01, i_DATA02)
	begin
		o_RESULT <= i_DATA01 + i_DATA02;
	end process;
end arch0;
