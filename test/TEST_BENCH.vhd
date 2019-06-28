-- Marco A. Zuniga
-- CPU Design Part 4
-- Component: Test bench 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TEST_BENCH is
--  Port ( );
end TEST_BENCH;

architecture Behavioral of TEST_BENCH is

component TOP is
    port (
	clk : in std_logic := '0';
	pc_value : out std_logic_vector(15 downto 0) := (others => '0');
    instruction : out std_logic_vector(15 downto 0) := (others => '0');
    register_rt_output : out std_logic_vector(15 downto 0) := (others => '0');
    register_rs_output : out std_logic_vector(15 downto 0) := (others => '0'));
end component;



signal clk_S : std_logic := '0';
signal pc_value_S : std_logic_vector(15 downto 0) := (others => '0');
signal register_rt_output_S : std_logic_vector(15 downto 0) := (others => '0');
signal register_rs_output_S : std_logic_vector(15 downto 0) := (others => '0');
signal instruction_S : std_logic_vector(15 downto 0) := (others => '0'); 

begin 
MAIN: TOP 
-- inputInstruction => inputInstruction_S,
  port map(clk => clk_S, pc_value => pc_value_S, instruction => instruction_S, register_rt_output => register_rt_output_S, register_rs_output 
  => register_rs_output_S); 


process begin   --Note: All instructions can be found hardcoded in the instruction memory.

--Instruction: "0101000000010010"; --LDI reg 0 with 00010010(18)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "0101000100000010"; --LDI reg 1 with 00000010 (2)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100000000010000"; --Use store instruction to gave reg0 and reg1 on bus   
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000010010")  --Check register 0
        report ("First load immediate didn't pass."); 
assert(register_rs_output_S = "0000000000000010")  --Check register 1
         report ("Second load immediate didn't pass.");
--Instruction: "0000001000010000";  --add reg 0(rt) and reg 1(rs) and store back in reg2
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000010000";  --store instruction to check register 2
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000010100")  --Check register 2. Should be 10100(20)
        report ("Addition instruction didn't pass.");
        

	
--Instruction: "0101000100000110"; --LDI reg1 with 000000110 (6)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000010000"; --Store ins to check register 1 and regiter 2 contents
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rs_output_S = "0000000000000110")  --Check register 1. Should be 6. register 0 
        report ("LDI instruction with 6 didn't pass."); 
	
--Instruction: "0001001000010010";  --reg2 - reg1 =  reg2
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000000000";   --store instruction
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000001110")  --Check register 2. Should be 20 - 6 = 14
        report ("Subtract instruction didn't pass.");

--Instruction: "0010001000010010";  --reg2 & reg1 =  reg2  (0000000000001110 & 0000000000000110)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000000000";   --store instruction
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000000110")  
        report ("AND instruction didn't pass.");

--Instruction: "0101000000110110"; --LDI reg 0 with 00110110
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "0101000100111110"; --LDI reg 1 with 00111110
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "0011001000010000";  --reg1 | reg0 =  reg2  ( 00111110 | 00110110)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000000000";  --store instruction
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000111110")  
        report ("OR instruction didn't pass.");

	
--Instruction: "0100001000000001";  --SLT reg1 has a bigger value than register 0. r2 should be set
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--Instruction: "1100001000000000"; --store instruction
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(register_rt_output_S = "0000000000000001")  
        report ("SLT instruction didn't pass.");


--Instruction: "0111000000011000";  --JUMP to PC[15:8] & "00011000"
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000011000")    -- Should be the address from the JUMP instruction
	report ("PC is not the expected value after JUMP instruction");


--Instruction: "1000111100011110";  --JUMP to PC[15:8] & "00011110" and store PC + 1 in register 15
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000110010")    -- Should be the address from the JUMP instruction
	report ("PC is not the expected value after JUMP and link register instruction");

       
--Instruction: "1001111100000000"; --JR instruction
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000011010")    -- Should be the address from the JUMP instruction
      report ("PC is not the expected value after JUMP register instruction");


--Instruction:"0101000000110100"; --LDI reg 0 with 00110100
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--inputInstruction_S <= "0101000100110100"; --LDI reg 1 with 00110100
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;

--Instruction: "1101000100000011"; --BEQ instruction Add 3 to PC + 1 (0000000011110100)
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000100001")  
	report ("PC is not the expected value after BEQ instruction when both registers equal");


--Instruction: "0101000000110100"; --LDI reg 0 with 00110100
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
--inputInstruction_S <= "0101000100110100"; --LDI reg 1 with 00110100
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;

--Instruction: "1101000100000100"; --BEQ instruction Add 3 to PC + 1 
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000100101")  
	report ("PC is not the expected value after BEQ instruction when both registers not equal");

--Instruction: "1110000000010011"; --BNE instruction Should add 3 to 38 + 1
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;
wait for 10 ns;
assert(pc_value_S = "0000000000101010")  
	report ("PC is not the expected value after BNE instruction");


clk_S <= '1', '0' after 5 ns; --Load reg 9 with 36
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  --Load reg 10 with 74
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; --45 Store 74 in 36 + 2 in data mem
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  --Load in reg 12 the data at 36 + 2
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  ----Put the data in reg12 on Qs bus
wait for 10 ns;

assert(pc_value_S = "0000000000101111")  --Make sure the appropriate instructions have been executed
	report ("PC is not correct after STORE and LOAD instructions.");
assert(register_rs_output_S = "0000000001001010")  
	report ("The store and load instructions didn't operate correctly.");


--Instruction: "1010110100000000"
clk_S <= '1', '0' after 5 ns;  --Keep clocking to be sure you've halted
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;
clk_S <= '1', '0' after 5 ns;  
wait for 10 ns;
clk_S <= '1', '0' after 5 ns; 
wait for 10 ns;

assert(pc_value_S = "0000000000110111")  --PC value should have remained the same
report ("PC is not correct after HALT instruction.");

wait;
end process;

end Behavioral;
