library ieee;
use ieee.std_logic_1164.all;

entity Clock_Delay is
	generic (w_N  : natural := 3);
	port(i_CLOCK  : in std_logic;   -- IN
		  i_RESET  : in std_logic;
		  o_CLOCK  : out std_logic); -- OUT
end entity Clock_Delay;

architecture arch0 of Clock_Delay is
begin
	process(i_CLOCK)
		variable TEMP : integer range 0 to w_N := 0;
		begin 
			if(i_RESET = '1') then
				o_CLOCK <= '1';
				TEMP := 0;
			else
				if(rising_edge(i_CLOCK)) then
					if(TEMP < (w_N / 2)) then
						o_CLOCK <= '0';
						TEMP := TEMP + 1;
					else
						o_CLOCK <= '1';
						if(TEMP = (w_N - 1)) then
							TEMP := 0;
						else
							TEMP := TEMP + 1;
						end if;
					end if;
				end if;
			end if;
	end process;
end arch0;