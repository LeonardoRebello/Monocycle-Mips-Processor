library ieee;
use ieee.std_logic_1164.all;

entity MONOCYCLE_TOP is
	port(i_CLOCK : in std_logic;  --IN
		  i_RESET : in std_logic); --OUT
end entity MONOCYCLE_TOP;

architecture arch0 of MONOCYCLE_TOP is
signal w_CLOCKNEG                                                                          : std_logic;                 --WIRES
signal w_CLOCKDELAY                                                                        : std_logic;
signal w_MUX_TO_PC                                                                         : std_logic_vector(31 downto 0);
signal w_NEXPC                                                                             : std_logic_vector(31 downto 0);
signal w_INSTRUCTION                                                                       : std_logic_vector(31 downto 0);
signal w_PC4                                                                               : std_logic_vector(31 downto 0);
signal w_JUMPADDRESS                                                                       : std_logic_vector(31 downto 0);
signal w_REGDST, w_JUMP, w_BRANCH, w_MEMREAD, w_MEMTOREG, w_MEMWRITE, w_ALUSRC, w_REGWRITE : std_logic;
signal w_ALUOP                                                                             : std_logic_vector(1 downto 0);
signal w_INSTRUCTIONOUT                                                                    : std_logic_vector(4 downto 0);
signal w_READDATA                                                                          : std_logic_vector(31 downto 0);
signal w_READDATA1                                                                         : std_logic_vector(31 downto 0);
signal w_READDATA2                                                                         : std_logic_vector(31 downto 0);
signal w_SIGNEXTEND                                                                        : std_logic_vector(31 downto 0);
signal w_ALUINPUT                                                                          : std_logic_vector(3 downto 0);
signal w_MUX_ALUOUT                                                                        : std_logic_vector(31 downto 0);
signal w_ALURESULT                                                                         : std_logic_vector(31 downto 0);
signal w_ALUZERO                                                                           : std_logic;
signal w_SHIFTLEFT2VECTOR                                                                  : std_logic_vector(31 downto 0);
signal w_MUX_PC_CONTROL                                                                    : std_logic;
signal w_ALUPC                                                                             : std_logic_vector(31 downto 0);
signal w_MUX_PCOUT                                                                         : std_logic_vector(31 downto 0);
signal w_READDATA_MEMORY                                                                   : std_logic_vector(31 downto 0);

begin

	w_CLOCKNEG <= not i_CLOCK;

	DELAY_CLOCK : entity work.Clock_Delay port map(i_CLOCK => w_CLOCKNEG,
																  i_RESET => i_RESET,
																  o_CLOCK => w_CLOCKDELAY);

	PC : entity work.PC port map (i_NEXTPC => w_MUX_TO_PC,
											i_CLOCK  => w_CLOCKDELAY,
											i_RESET  => i_RESET,		
											o_NEXTPC => w_NEXPC);
												
	INSTRUCTION_MEMORY : entity work.INSTRUCTION_MEMORY port map (i_CLOCK       => w_CLOCKNEG,
																					  i_RESET       => i_RESET,
																					  i_READADDRESS => w_NEXPC,
																					  o_INSTRUCTION => w_INSTRUCTION);
																					  
	CONTROL : entity work.CONTROL port map (i_CLOCK       => i_CLOCK,
														 i_RESET       => i_RESET,
														 i_INSTRUCTION => w_INSTRUCTION(31 downto 26),
														 o_REGDST      => w_REGDST,
														 o_JUMP        => w_JUMP,
														 o_BRANCH      => w_BRANCH,
														 o_MEMREAD     => w_MEMREAD,
														 o_MEMTOREG    => w_MEMTOREG,  
														 o_MEMWRITE    => w_MEMWRITE,
														 o_ALUSRC      => w_ALUSRC,
														 o_REGWRITE    => w_REGWRITE,
														 o_ALUOP       => w_ALUOP);																				  
											
	ADD_4 : entity work.ADD port map (i_DATA01 => w_NEXPC,
												 i_DATA02 => x"00000004",
												 o_RESULT => w_PC4);
	
	JUMPADDRESS : entity work.JUMPADDRESS port map (i_VECTORINSTRUCTION => w_INSTRUCTION(25 downto 0),
																	i_PC4               => w_PC4(31 downto 28), 
																	o_JUMPADDRESS       => w_JUMPADDRESS);
																	 
	MUX_INSTRUCTION : entity work.MUX_INSTRUCTION port map(i_SELECT => w_REGDST,
																			 i_DATA1  => w_INSTRUCTION(20 downto 16),
																			 i_DATA2  => w_INSTRUCTION(15 downto 11),
																			 o_MUXOUT => w_INSTRUCTIONOUT);
																		
	REGISTERS : entity work.REGISTERS port map(i_CLOCK         => w_CLOCKNEG,
															 i_RESET         => i_RESET,
															 i_REGWRITE      => w_REGWRITE,
															 i_READREGISTER1 => w_INSTRUCTION(25 downto 21),
															 i_READREGISTER2 => w_INSTRUCTION(20 downto 16),
															 i_WRITEREGISTER => w_INSTRUCTIONOUT,
															 i_WRITEDATA     => w_READDATA,
															 o_READDATA1     => w_READDATA1,
															 o_READDATA2     => w_READDATA2);
															 
	SIGNEXTEND : entity work.SIGNEXTEND port map(i_VECTOR     => w_INSTRUCTION(15 downto 0),
																o_SIGNEXTEND => w_SIGNEXTEND);
															
	ALU_CONTROL : entity work.ALU_Control port map(i_ALUOP        => w_ALUOP,
																  i_INSTRUCTION  => w_INSTRUCTION(5 downto 0),
																  o_ALUINPUT     => w_ALUINPUT);
																  
	MUX_ALU : entity work.MUX port map(i_SELECT => w_ALUSRC,
												  i_DATA1  => w_READDATA2,
												  i_DATA2  => w_SIGNEXTEND,
												  o_MUXOUT => w_MUX_ALUOUT);
												  
	ALU : entity work.ALU port map(i_DATA1     => w_READDATA1,
											 i_DATA2     => w_MUX_ALUOUT,
											 i_ALUINPUT  => w_ALUINPUT,
											 o_ALURESULT => w_ALURESULT,
											 o_ALUZERO   => w_ALUZERO);
											 
	SHIFT_LEFT_2 : entity work.SHIFT_LEFT_2 port map(i_VECTOR           => w_SIGNEXTEND,
																	 o_SHIFTLEFT2VECTOR => w_SHIFTLEFT2VECTOR);
																	 
	AND_BLOCK : entity work.AND_Block port map(i_DATA01 => w_BRANCH,
															 i_DATA02 => w_ALUZERO,
															 o_RESULT => w_MUX_PC_CONTROL);
															 
	ADD_PC : entity work.ADD port map(i_DATA01 => w_PC4,
												 i_DATA02 => w_SHIFTLEFT2VECTOR,
												 o_RESULT => w_ALUPC);
												 
	MUX_PC : entity work.MUX port map(i_SELECT  => w_MUX_PC_CONTROL,
												  i_DATA1  => w_PC4,
												  i_DATA2  => w_ALUPC, 
												  o_MUXOUT => w_MUX_PCOUT);
												  
	MUX_JUMP : entity work.MUX port map(i_SELECT => w_JUMP,
												   i_DATA1  => w_MUX_PCOUT,
													i_DATA2  => w_JUMPADDRESS,
													o_MUXOUT => w_MUX_TO_PC);
													
	DATA_MEMORY : entity work.DATA_MEMORY port map(i_CLOCK     => w_CLOCKDELAY,
																  i_RESET     => i_RESET,
																  i_MEMWRITE  => w_MEMWRITE,
																  i_MEMREAD   => w_MEMREAD,
																  i_ADDRESS   => w_ALURESULT,
																  i_WRITEDATA => w_READDATA2,
																  o_READDATA  => w_READDATA_MEMORY);
																
	MUX_MEMORY : entity work.MUX port map(i_SELECT => w_MEMTOREG,
													  i_DATA1  => w_ALURESULT,
													  i_DATA2  => w_READDATA_MEMORY,
													  o_MUXOUT => w_READDATA);
end arch0;