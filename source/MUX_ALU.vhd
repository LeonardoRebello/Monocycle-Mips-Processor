library ieee;
use ieee.std_logic_1164.all;

entity MUX_ALU is 
	port(i_ALUSRC              : in  std_logic;
		  i_READDATA2           : in  std_logic_vector(31 downto 0);
		  i_INSTRUCTIONEXTENDED : in  std_logic_vector(31 downto 0);
		  o_ALUDATA2            : out std_logic_vector(31 downto 0));
end entity MUX_ALU;

architecture arch0 of MUX_ALU is
begin
	process(i_ALUSRC, i_READDATA2, i_INSTRUCTIONEXTENDED)
	begin
		case i_ALUSRC is
			when '0' =>
				o_ALUDATA2 <= i_READDATA2;
			when others =>
				o_ALUDATA2 <= i_INSTRUCTIONEXTENDED;
		end case;
	end process;
end arch0;