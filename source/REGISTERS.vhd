library ieee;
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;

entity REGISTERS is
	port(i_CLOCK         : in std_logic;                       -- IN
		  i_RESET         : in std_logic;
		  i_REGWRITE      : in  std_logic;
		  i_READREGISTER1 : in  std_logic_vector(4 downto 0);
		  i_READREGISTER2 : in  std_logic_vector(4 downto 0);
		  i_WRITEREGISTER : in  std_logic_vector(4 downto 0);
		  i_WRITEDATA     : in  std_logic_vector(31 downto 0);
		  o_READDATA1     : out std_logic_vector(31 downto 0);  -- OUT
		  o_READDATA2     : out std_logic_vector(31 downto 0));
end entity REGISTERS;

architecture arch0 of REGISTERS is 
TYPE r_REGISTERS is array (0 to 31) of std_logic_vector(31 downto 0);
signal s_REGISTERS : r_REGISTERS := (x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"10008000", x"7FFFEFFC", x"00000000", x"00000000");
	-- Coletado do mips os registradores
begin
	process(i_CLOCK, i_REGWRITE, i_RESET)
	begin
		if(i_RESET = '1') then
				s_REGISTERS(0) <= x"00000000"; s_REGISTERS(1) <= x"00000000"; s_REGISTERS(2) <= x"00000000"; 
				s_REGISTERS(3) <= x"00000000"; s_REGISTERS(4) <= x"00000000"; s_REGISTERS(5) <= x"00000000"; 
				s_REGISTERS(6) <= x"00000000"; s_REGISTERS(7) <= x"00000000"; s_REGISTERS(8) <= x"00000000";
				s_REGISTERS(9) <= x"00000000"; s_REGISTERS(10) <= x"00000000"; s_REGISTERS(11) <= x"00000000";
				s_REGISTERS(12) <= x"00000000"; s_REGISTERS(13) <= x"00000000"; s_REGISTERS(14) <= x"00000000";
				s_REGISTERS(15) <= x"00000000"; s_REGISTERS(16) <= x"00000000"; s_REGISTERS(17) <= x"00000000";
				s_REGISTERS(18) <= x"00000000"; s_REGISTERS(19) <= x"00000000"; s_REGISTERS(20) <= x"00000000";
				s_REGISTERS(21) <= x"00000000"; s_REGISTERS(22) <= x"00000000"; s_REGISTERS(23) <= x"00000000";
				s_REGISTERS(24) <= x"00000000"; s_REGISTERS(25) <= x"00000000"; s_REGISTERS(26) <= x"00000000";
				s_REGISTERS(27) <= x"00000000"; s_REGISTERS(28) <= x"10008000"; s_REGISTERS(29) <= x"7FFFEFFC";
				s_REGISTERS(30) <= x"00000000"; s_REGISTERS(31) <= x"00000000";
		else
			if(rising_edge(i_CLOCK)) then
				if(i_REGWRITE = '1') then
					s_REGISTERS(to_integer(unsigned(i_WRITEREGISTER))) <= i_WRITEDATA;
				end if;
				o_READDATA1 <= s_REGISTERS(to_integer(unsigned(i_READREGISTER1)));
				o_READDATA2 <= s_REGISTERS(to_integer(unsigned(i_READREGISTER2)));
				end if;
			end if;
	end process;
end arch0;
