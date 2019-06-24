

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU_TB is
--  Port ( );
end CU_TB;

architecture Behavioral of CU_TB is
component ControlUnit is 
	Port(opcode : in std_logic_vector(3 downto 0) := (others => '0');  --Opcode needed to send signals
        DATAIN, ALUIN : out std_logic_vector(1 downto 0) := (others => '0');
		ALUOP : out std_logic_vector(2 downto 0) := (others => '0');
        RWE, MWE, STR, SHIFT, B, JR, J: out std_logic := '0'  --Output signals sent throughout datapath
        );
end component;

signal opcodeS : std_logic_vector(3 downto 0) := (others => '0');
signal DATAINS, ALUINS : std_logic_vector(1 downto 0) := (others => '0');
signal ALUOPS : std_logic_vector(2 downto 0) := (others => '0');
signal RWES, MWES, STRS, SHIFTS, BS, JRS, JS: std_logic := '0';  --Output signals sent throughout datapath

begin 

CU : ControlUnit 
    port map(opcode => opcodeS, DATAIN => DATAINS, ALUIN => ALUINS, ALUOP => ALUOPS, RWE => RWES, MWE => MWES, STR => STRS, SHIFT => SHIFTS, B => BS, JR => JRS, J => JS);

process begin 

opcodeS <= "0000";
wait for 5ns;

assert(RWES = '1')
    report("Error with 0000 opcode");

assert(MWES = '0')
    report("Error with 0000 opcode");

assert(DATAINS = "10")
    report("Error with 0000 opcode");

assert(ALUOPS = "000")
    report("Error with 0000 opcode");

assert(ALUINS = "00")
    report("Error with 0000 opcode");

assert(STRS = '0')
    report("Error with 0000 opcode");

assert(SHIFTS = '0')
    report("Error with 0000 opcode");

assert(BS = '0')
    report("Error with 0000 opcode");

assert(JRS = '0')
    report("Error with 0000 opcode");

assert(JS = '0')
    report("Error with 0000 opcode");

opcodeS <= "1100";
wait for 5ns;

assert(RWES = '0')
    report("Error with 1100 opcode");

assert(MWES = '1')
    report("Error with 1100 opcode");

assert(DATAINS = "00")
    report("Error with 1100 opcode");

assert(ALUOPS = "000")
    report("Error with 1100 opcode");

assert(ALUINS = "01")
    report("Error with 1100 opcode");

assert(STRS = '1')
    report("Error with 1100 opcode");

assert(SHIFTS = '0')
    report("Error with 1100 opcode");

assert(BS = '0')
    report("Error with 1100 opcode");

assert(JRS = '0')
    report("Error with 1100 opcode");

assert(JS = '0')
    report("Error with 1100 opcode");

end process;
end Behavioral;
