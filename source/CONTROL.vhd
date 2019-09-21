library ieee;
use ieee.std_logic_1164.all;

entity CONTROL is
	port(i_CLOCK       : in  std_logic;                    -- IN
		  i_RESET       : in  std_logic;
		  i_INSTRUCTION : in  std_logic_vector(5 downto 0);
		  o_REGDST      : out std_logic;                    -- OUT
		  o_JUMP        : out std_logic;
		  o_BRANCH      : out std_logic;
		  o_MEMREAD     : out std_logic;
		  o_MEMTOREG    : out std_logic;  
		  o_MEMWRITE    : out std_logic;
		  o_ALUSRC      : out std_logic;
		  o_REGWRITE    : out std_logic;
		  o_ALUOP       : out std_logic_vector(1 downto 0));
end entity CONTROL;

architecture arch0 of CONTROL is
begin
	process(i_CLOCK, i_RESET)
	begin
	
		if(i_RESET = '1') then
			o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
						o_MEMWRITE <= '0'; o_ALUSRC <= '0'; o_REGWRITE <= '0'; o_ALUOP <= "00";
		else
			if(rising_edge(i_CLOCK)) then
				case i_INSTRUCTION is
					--INSTRUCTION R
					when "000000" =>
						o_REGDST <= '1'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '0'; o_REGWRITE <= '1'; o_ALUOP <= "10";
					--INSTRUCTION LW
					when "100011" =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '1'; o_MEMTOREG <= '1'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '1'; o_REGWRITE <= '1'; o_ALUOP <= "00";
					--INSTRUCTION SW
					when "101011" =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '1'; o_ALUSRC <= '1'; o_REGWRITE <= '0'; o_ALUOP <= "00";
					--INSTRUCTION JUMP
					when "000010" =>
						o_REGDST <= '0'; o_JUMP <= '1'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '0'; o_REGWRITE <= '0'; o_ALUOP <= "00";
					--INSTRUCTION ADDI
					when "001000" =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '1'; o_REGWRITE <= '1'; o_ALUOP <= "00";
					--INSTRUCTION LUI
					when "001111" => 
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '1'; o_REGWRITE <= '1'; o_ALUOP <= "10";
					--INSTRUCTION ORI
					when "001101" =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '0'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '1'; o_REGWRITE <= '1'; o_ALUOP <= "10";
					--INSTRUCTION BEQ
					when "000100" =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '1'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '0'; o_REGWRITE <= '0'; o_ALUOP <= "10";
					when others =>
						o_REGDST <= '0'; o_JUMP <= '0'; o_BRANCH <= '1'; o_MEMREAD <= '0'; o_MEMTOREG <= '0'; 
							o_MEMWRITE <= '0'; o_ALUSRC <= '0'; o_REGWRITE <= '0'; o_ALUOP <= "01";
					end case;
			end if;
		end if;
	end process;
end arch0;