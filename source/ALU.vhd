library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ALU is 
	port(i_DATA1     : in  std_logic_vector(31 downto 0); -- IN
		  i_DATA2     : in  std_logic_vector(31 downto 0);
		  i_ALUINPUT  : in  std_logic_vector(3 downto 0);  -- OUT
		  o_ALURESULT : out std_logic_vector(31 downto 0);
		  o_ALUZERO   : out std_logic);
end entity ALU;

architecture arch0 of ALU is
signal s_RESULT : std_logic_vector(31 downto 0);
begin
	process(i_DATA1, i_DATA2, i_ALUINPUT)
	begin
		case i_ALUINPUT is 
			when "0010" =>
				s_RESULT <= i_DATA1 + i_DATA2;
			when "0110" =>
				s_RESULT <= i_DATA1 - i_DATA2;
			when "0000" => 
				s_RESULT <= i_DATA1 and i_DATA2;
			when "0001" =>
				s_RESULT <= i_DATA1 or i_DATA2;
			when others =>
				if i_DATA1 < i_DATA2 then
					s_RESULT <= x"00000001";
				else
					s_RESULT <= x"00000000";
				end if;
		end case;
	end process;
	o_ALUZERO <= '1' when s_RESULT = x"00000000" else '0';
	o_ALURESULT <= s_RESULT;
end arch0;