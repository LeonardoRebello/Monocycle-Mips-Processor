library ieee;
use ieee.std_logic_1164.all;

entity MUX_INSTRUCTION is 
	port(i_SELECT : in  std_logic;                     -- IN
		  i_DATA1  : in  std_logic_vector(4 downto 0);
		  i_DATA2  : in  std_logic_vector(4 downto 0);
		  o_MUXOUT : out std_logic_vector(4 downto 0)); -- OUT
end entity MUX_INSTRUCTION;

architecture arch0 of MUX_INSTRUCTION is
begin
	process(i_SELECT, i_DATA1, i_DATA2)
	begin
		case i_SELECT is
			when '0' =>
				o_MUXOUT <= i_DATA1;
			when others =>
				o_MUXOUT <= i_DATA2;
		end case;
	end process;
end arch0;