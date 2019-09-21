library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DATA_MEMORY is
	port(i_CLOCK        : in  std_logic;                      -- IN
		  i_RESET        : in  std_logic;
		  i_MEMWRITE     : in  std_logic;
		  i_MEMREAD      : in  std_logic;
		  i_ADDRESS      : in  std_logic_vector(31 downto 0);
		  i_WRITEDATA    : in  std_logic_vector(31 downto 0);
		  o_READDATA     : out std_logic_vector(31 downto 0)); -- OUT
end entity DATA_MEMORY;

architecture arch0 of DATA_MEMORY is
TYPE t_RAMMEMORY is array (0 to 31) of std_logic_vector(31 downto 0);
signal s_RAM : t_RAMMEMORY := (x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
	x"00000000", x"00000000");
begin
	process(i_CLOCK, i_RESET, i_MEMREAD, i_MEMWRITE, i_ADDRESS)
	begin
		if(i_RESET = '1') then
				s_RAM(0) <= x"00000000"; s_RAM(1) <= x"00000000"; s_RAM(2) <= x"00000000"; s_RAM(3) <= x"00000000";
				s_RAM(4) <= x"00000000"; s_RAM(5) <= x"00000000"; s_RAM(6) <= x"00000000"; s_RAM(7) <= x"00000000";
				s_RAM(8) <= x"00000000"; s_RAM(9) <= x"00000000"; s_RAM(10) <= x"00000000"; s_RAM(11) <= x"00000000";
				s_RAM(12) <= x"00000000"; s_RAM(13) <= x"00000000"; s_RAM(14) <= x"00000000"; s_RAM(15) <= x"00000000";
				s_RAM(16) <= x"00000000"; s_RAM(17) <= x"00000000"; s_RAM(18) <= x"00000000"; s_RAM(19) <= x"00000000";
				s_RAM(20) <= x"00000000"; s_RAM(21) <= x"00000000"; s_RAM(22) <= x"00000000"; s_RAM(23) <= x"00000000";
				s_RAM(24) <= x"00000000"; s_RAM(25) <= x"00000000"; s_RAM(26) <= x"00000000"; s_RAM(27) <= x"00000000";
				s_RAM(28) <= x"00000000"; s_RAM(29) <= x"00000000"; s_RAM(30) <= x"00000000"; s_RAM(31) <= x"00000000";
		else
			if(rising_edge(i_CLOCK)) then
				if(i_MEMREAD = '1') then
					o_READDATA <= s_RAM(to_integer(unsigned(i_ADDRESS)));
				elsif(i_MEMWRITE = '1') then
					s_RAM(to_integer(unsigned(i_ADDRESS))) <= i_WRITEDATA;
					-- 268500992 ou x"10010000" coresponde ao inicio da memória dada pelo MARS
				end if;
			end if;
		end if;
	end process;
end arch0;