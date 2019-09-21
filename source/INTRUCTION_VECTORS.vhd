library ieee;
use ieee.std_logic_1164.all;

entity INTRUCTION_VECTORS is
	port(i_INSTRUCTION : in std_logic_vector(31 downto 0);
		  o_INSTRUCTION_25_TO_0 : out std_logic_vector(25 downto 0);
		  o_INSTRUCTION_31_TO_26 : out std_logic_vector(5 downto 0);
		  o_INSTRUCTION_25_TO_21 : out std_logic_vector(4 downto 0);
		  o_INSTRUCTION_20_TO_16 : out std_logic_vector(4 downto 0);
		  o_INSTRUCTION_15_TO_11 : out std_logic_vector(4 downto 0);
		  o_INSTRUCTION_15_TO_0 : out std_logic_vector(15 downto 0);
		  o_INSTRUCTION_5_TO_0 : out std_logic_vector(5 downto 0));
end entity INTRUCTION_VECTORS;

architecture arch0 of INTRUCTION_VECTORS is
begin
	process(i_INSTRUCTION)
	begin
	o_INSTRUCTION_25_TO_0 <= i_INSTRUCTION(25 downto 0);
	o_INSTRUCTION_31_TO_26 <= i_INSTRUCTION(31 downto 26);
	o_INSTRUCTION_25_TO_21 <= i_INSTRUCTION(25 downto 21);
	o_INSTRUCTION_20_TO_16 <= i_INSTRUCTION(20 downto 16);
	o_INSTRUCTION_15_TO_11 <= i_INSTRUCTION(15 downto 11);
	o_INSTRUCTION_15_TO_0 <= i_INSTRUCTION(15 downto 0);
	o_INSTRUCTION_5_TO_0 <= i_INSTRUCTION(5 downto 0);
	end process;
end arch0;