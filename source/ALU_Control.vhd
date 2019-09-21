library ieee;
use ieee.std_logic_1164.all;

entity ALU_Control is 
	port(i_ALUOP       : in  std_logic_vector(1 downto 0);  -- IN
		  i_INSTRUCTION : in  std_logic_vector(5 downto 0);
		  o_ALUINPUT    : out std_logic_vector(3 downto 0)); -- OUT
end entity ALU_Control;

architecture arch0 of ALU_Control is
begin
	process(i_ALUOP, i_INSTRUCTION)
	begin 
		if i_ALUOP = "00" then
			o_ALUINPUT <= "0010";
			
		elsif i_ALUOP = "01" then
			o_ALUINPUT <= "0110";
		
		elsif i_ALUOP = "10" then
			case i_INSTRUCTION is
				when "100000" =>
					o_ALUINPUT <= "0010";
				when "100010" =>
					o_ALUINPUT <= "0110";
				when "100100" =>
					o_ALUINPUT <= "0000";
				when "100101" =>
					o_ALUINPUT <= "0001";
				when others =>
					o_ALUINPUT <= "0111";
			end case;
		end if;
	end process;
end arch0;
				
		
