library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INSTRUCTION_MEMORY is
	port(i_CLOCK       : in  std_logic;                      -- IN
		  i_RESET       : in  std_logic;
		  i_READADDRESS : in  std_logic_vector(31 downto 0);
		  o_INSTRUCTION : out std_logic_vector(31 downto 0)); -- OUT
end entity INSTRUCTION_MEMORY;

architecture arch0 of INSTRUCTION_MEMORY is
TYPE t_ROMMEMORY is array(0 to 15) of std_logic_vector(31 downto 0);
signal s_ROM : t_ROMMEMORY := (x"2012000a", -- ADDI $s2, $zero, 10
										 x"2013000f", -- ADDI $s3, $zero, 15
										 x"0272a020", -- ADD  $s4, $s3, $s2
	                            x"AEB40000", -- SW   $s4, ($zero)
	                            x"8C160000", -- LW   $s6, ($zero)
	                            x"08100007", -- J    LABEL  
										 x"2017000a", -- ADDI $s7, $zero, 10
														  -- LABEL
										 x"20170014", -- ADDI $s7, $zero, 20
										 x"00000000", x"00000000", x"00000000", x"00000000", 
										 x"00000000", x"00000000", x"00000000", x"00000000");
begin
	process(i_CLOCK, i_RESET, i_READADDRESS)
	begin
		if(i_RESET = '1') then
			o_INSTRUCTION <= s_ROM(0);
		else
			if(rising_edge(i_CLOCK)) then
				o_INSTRUCTION <= s_ROM(to_integer(unsigned(i_READADDRESS)  - 4194304)/ 4); 
				-- 4194304 ou x"00400000", representa o valor inicial dado pelo mars para as instruções
			end if;
		end if;
	end process;
end arch0;
		