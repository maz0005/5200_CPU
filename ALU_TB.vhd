-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: ALU Test Bench


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavioral of ALU_TB is
signal ALUOP_S : std_logic_vector(2 downto 0) := (others => '0');    --arithmetic to perform
signal operand1_S : std_logic_vector(15 downto 0) := (others => '0');  --data from register rs
signal operand2_S : std_logic_vector(15 downto 0) := (others => '0');  --data from register rt or an immediate
signal output_S : std_logic_vector(15 downto 0) := (others => '0');  --Result 
signal zero_S : std_logic := '0';    --zero flag 

component ALU is
	Port(ALUOP : in std_logic_vector(2 downto 0) := (others => '0');    --arithmetic to perform
		operand1 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rs
		operand2 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rt or an immediate
		output : out std_logic_vector(15 downto 0) := (others => '0');  --Result 
		zero : out std_logic := '0'    --zero flag 
		);
end component;

begin
ALU1 : ALU
    Port map(ALUOP => ALUOP_S, operand1 => operand1_S, operand2 => operand2_S, output => output_S, zero => zero_S);


process begin 

ALUOP_S <= "000"; --ADD two positive operands
operand1_S <= "0001001000100010"; --4642
operand2_S <= "0000000000100010";  --34
wait for 5 ns;
    assert (output_S = "0001001001000100") --4676
        report "Adder didn't compute correctly in ALU test bench.";
                
ALUOP_S <= "001"; --Subtract same operands 
wait for 5 ns;
    assert (output_S = "0001001000000000") --4608
        report "Subtractor didn't compute correctly in ALU test bench.";

ALUOP_S <= "000"; --ADD two negative operands
operand1_S <= "1111111111111101"; --  -3
operand2_S <= "1111111111110111";  --  -9
wait for 5 ns;
    assert (output_S = "1111111111110100") --  -12
        report "Adder didn't compute correctly with two neg numbers in ALU test bench.";
        
ALUOP_S <= "001"; --Subtract same operands 
wait for 5 ns;
    assert (output_S = "0000000000000110") --6
        report "Subtractor didn't compute correctly with two neg numbers in ALU test bench.";
               
               
ALUOP_S <= "010"; --Use AND to clear bits in operand1
operand1_S <= "1111111111111111";   
operand2_S <= "1101111011111101";   --Clear specific bits
wait for 5 ns;
    assert (output_S = "1101111011111101")
        report "ANDing computation was not computed succesfully in ALU test bench.";

        
ALUOP_S <= "011"; --Use OR to set bits in operand1
operand1_S <= "1001001100111011";   
operand2_S <= "0000100000000100";   --Set specific bits
wait for 5 ns;
    assert (output_S = "1001101100111111")
        report "ORing computation was not computed succesfully in ALU test bench.";

        
ALUOP_S <= "100"; --Use SLT(Set Less Than)
operand1_S <= "0000000000000100";   
operand2_S <= "0000100000000100";   --Set specific bits
wait for 5 ns;
     assert (output_S = "0000000000000001")
        report "SLT computation was not computed succesfully in ALU test bench.";

        
ALUOP_S <= "100"; --Use SLT(Set Less Than)
operand1_S <= "0010000000000100";   
operand2_S <= "0000100000000100";   --Set specific bits
wait for 5 ns;
     assert (output_S = "0000000000000000")
        report "SLT computation was not computed succesfully in ALU test bench.";

        
ALUOP_S <= "101"; --Use LSL(Logical Shift Left)
operand1_S <= "0000000000000001";   
operand2_S <= "0000000000000100";   --Shift left 4 times
wait for 5 ns;
     assert (output_S = "0000000000010000")
        report "LSL computation was not computed succesfully in ALU test bench.";

                
end process;
end Behavioral;
