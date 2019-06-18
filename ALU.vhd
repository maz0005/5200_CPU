-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	Port(ALUOP : in std_logic_vector(3 downto 0) := (others => '0');    --arithmetic to perform
		operand1 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rs
		operand2 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rt or an immediate
		output : out std_logic_vector(15 downto 0) := (others => '0');  --Result 
		zero : out std_logic := '0'    --zero flag 
		);
end ALU;

architecture Behavioral of ALU is 
signal output_S : std_logic_vector(15 downto 0) := (others => '0');

begin

process (ALUOP, operand1, operand2) begin

case ALUOP is 

	when "0000" =>    --ADD
		output_S <= std_logic_vector(SIGNED(operand1) + SIGNED(operand2));
		--output_S <= std_logic_vector(to_signed(to_integer(SIGNED(operand1)) + to_integer(SIGNED(operand2)), 16));
		
	when "0001" =>   --SUB
		output_S <= std_logic_vector(SIGNED(operand1) - SIGNED(operand2));
		
	when "0010" =>   --AND
		output_S <= operand1 and operand2;
		
	when "0011" =>   --OR
		output_S <= operand1 or operand2;
		
	when "0100" =>   --SLT(Set Less Than)
		if SIGNED(operand2) < SIGNED(operand1) then 
			output_S <= (0 => '1', others => '0');
		else
			output_S <= (others => '0');
		end if;
		
	when "0110" =>  --LSL(Logical Shift Left)
		--output_S <= std_logic_vector(shift_left(UNSIGNED(operand2), to_integer(UNSIGNED(operand1))));
		output_S <= std_logic_vector(unsigned(operand2) sll to_integer(UNSIGNED(operand1)));
		
	when others =>
	   output_S <= (others => '0');
	end case;

end process;

zero <= '1' when output_S = x"0000" else '0';
output <= output_S;

end Behavioral;
