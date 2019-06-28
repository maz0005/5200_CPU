-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Control Unit Test Bench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_TB is
--  Port ( );
end ControlUnit_TB;

architecture Behavioral of ControlUnit_TB is
signal opcode_S : std_logic_vector(3 downto 0) := (others => '0');
signal RWE_S, MWE_S, ALUIN_S, STR_S, SHIFT_S, B_S, JR_S, J_S : std_logic := '0';

component ControlUnit is 
Port(opcode : in std_logic_vector(3 downto 0) := (others => '0');  --Opcode needed to send signals
RWE, MWE, ALUIN, STR, SHIFT, B, JR, J : out std_logic := '0'  --Output signals sent through datapath
);
end component;

begin
ControlUnit1 : ControlUnit
    Port map(opcode => opcode_S, RWE => RWE_S, MWE => MWE_S, ALUIN => ALUIN_S, 
    STR => STR_S, SHIFT => SHIFT_S, B => B_S, JR => JR_S, J => J_S);

process begin

opcode_S <= "0000"; --ADD
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "0001";  --SUB
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";


opcode_S <= "0010"; --AND
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";


opcode_S <= "0011";  --OR
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "0100";  --SLT
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";
        

opcode_S <= "0101";  --LDI
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "0110";  --LSL
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '1')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "0111";  --J
wait for 5 ns;

    assert(RWE_S = '0')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(JR_S = '0')
        report "Unexpected JR signal for 0000";
    assert(J_S = '1')
        report "Unexpected J signal for 0000";

opcode_S <= "1000";   --JLR
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(JR_S = '0')
        report "Unexpected JR signal for 0000";
    assert(J_S = '1')
        report "Unexpected J signal for 0000";

opcode_S <= "1001";  --JR
wait for 5 ns;

    assert(RWE_S = '0')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '1')
        report "Unexpected STR signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(JR_S = '1')
        report "Unexpected JR signal for 0000";
    assert(J_S = '1')
        report "Unexpected J signal for 0000";

opcode_S <= "1011";  --LDR
wait for 5 ns;

    assert(RWE_S = '1')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "1100";  --STR
wait for 5 ns;

    assert(RWE_S = '0')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '1')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '1')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '0')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

opcode_S <= "1101";  --BEQ
wait for 5 ns;

    assert(RWE_S = '0')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '1')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";


opcode_S <= "1110";  --BNE
wait for 5 ns;

    assert(RWE_S = '0')
        report "Unexpected RWE signal for 0000";
    assert(MWE_S = '0')
        report "Unexpected MWE signal for 0000"; 
    assert(STR_S = '0')
        report "Unexpected STR signal for 0000";
    assert(SHIFT_S = '0')
        report "Unexpected SHIFT signal for 0000";
    assert(B_S = '1')
        report "Unexpected B signal for 0000";
    assert(J_S = '0')
        report "Unexpected J signal for 0000";

end process;

end Behavioral;
