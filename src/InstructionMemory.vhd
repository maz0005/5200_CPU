-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Instruction Memory


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is 
generic (BITS : integer := 10);
port (input_address : in std_logic_vector(9 downto 0) := (others => '0');
		output_instruction : out std_logic_vector(15 downto 0) := (others => '0')
		);
end InstructionMemory;

architecture behavioral of InstructionMemory is

	subtype WORD is std_logic_vector(15 downto 0);
	type MEM is array (0 to (2**BITS) - 1) of word;
	constant INSTRUCTIONS : MEM := ("0101000000010010",--(0) LDI reg 0 with 00010010(18)
									"0101000100000010",--(1) LDI reg 1 with 00000010 (2)
									"1100000000010000",--(2) Use store instruction to gave reg0 and reg1 on bus
									"0000001000010000",--(3) ADD reg 0(rt) and reg 1(rs) and store back in reg2
									"1100001000010000",--(4) store instruction to check register 2
									"0101000100000110",--(5) LDI reg1 with 000000110 (6)
									"1100001000010000",--(6) Store ins to check register 1 and regiter 2 contents
									"0001001000010010",--(7) reg2 - reg1 = reg2
									"1100001000000000",--(8) store instruction to check reg 2
									"0010001000010010",--(9) reg2 & reg1 =  reg2 
									"1100001000000000",--(10) store instruction to check reg 2
									"0101000000110110",--(11) LDI reg 0 with 00110110
									"0101000100111110",--(12) LDI reg 1 with 00111110
									"0011001000010000",--(13) reg1 | reg0 =  reg 2
									"1100001000000000",--(14) store instruction to check reg 2
									"0100001000000001",--(15) SLT reg1 has a bigger value than register 0. 
													   --     reg 2 should be set
									"1100001000000000",--(16) store instruction to check register 2
									"0111000000011000",--(17) Jump to instruction (24)
									"1000111111111110",--(18)
									"0000000000000000",--(19)
									"0000000000000000",--(20)
									"0000000000000000",--(21)
									"0000000000000000",--(22)
									"0000000000000000",--(23)
									"0000100001100111",--(24) Where you'll jump from ins (17). Dummy instruction
									"1000111100110010",--(25) Jump to instruction (50) and link to reg15
									"0000000000000000",--(26)
									"0101000000110100",--(27) LDI reg 0 with 00110100
									"0101000100110100",--(28) LDI reg 1 with 00110100
									"1101000100000011",--(29) BEQ instruction Add 3 to PC + 1. Will BRANCH to (33)
									"0000000000000000",--(30) 
                                    "0000000000000000",--(31)
                                    "0000000000000000",--(32)
                                    "0000000000000000",--(33) Will BRANCH here after first BEQ Ins (29)
                                    "0101000000110110",--(34) LDI reg 0 with 00110100
                                    "0101000100110100",--(35) LDI reg 1 with 00110100
                                    "1101000100000100",--(36) Second BEQ. Should Not Branch
                                    "0000000000000000",--(37) PC checked here in test bench
                                    "1110000000010011",--(38) BNE. Should branch. reg0 and reg1 are different 
                                    "0000000000000000",--(39)
                                    "0000000000000000",--(40)
                                    "0000000000000000",--(41)
                                    "0000000000000000",--(42) This is where I check BNE Ins. Should have Branched here
                                    "0101011100100100",--(43) Load reg 7 with 36
                                    "0101101001001010",--(44) Load reg 10 with 74
                                    "1100101001110010",--(45) Store 74 in 36 + 2 in data mem
                                    "1011110001110010",--(46) Load in reg 12 the data at 36 + 2
                                    "1100000011000000",--(47) Put the data in reg12 on Qs bus
                                    "1010110100000000",--(48) HALT Jump to end of program (55)
                                    "0000000000000000",--(49)
									"0000000000010000",--(50) Will JUMP to this address from instruction (24)
									"1001111100000000",--(51) RETURN to instruction (26)
									"0000000000000000",--(52)
									"0000000000000000",--(53)
									"0000000000000000",--(54)
									"1001110100000000",--(55) Keep jumping to this address
									others => (others => '0'));
	signal MEM_S : MEM := INSTRUCTIONS;

begin 

output_instruction <= MEM_S(to_integer(unsigned(input_address)));

end behavioral;
