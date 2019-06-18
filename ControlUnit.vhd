-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Control Unit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is 
	Port(opcode : in std_logic_vector(3 downto 0) := (others => '0');  --Opcode needed to send signals
        DATAIN, ALUIN : out std_logic_vector(1 downto 0) := (others => '0');
		ALUOP : out std_logic_vector(3 downto 0) := (others => '0');
        RWE, MWE, STR, SHIFT, B, JR, J: out std_logic := '0'  --Output signals sent throughout datapath
        );
end entity;

architecture Behavioral of ControlUnit is
begin

            RWE <= '1' when opcode = "0000" or opcode = "0001" or opcode = "0010" 
            or opcode = "0011" or opcode = "0100" or opcode = "0101" or opcode = "0110" 
            or opcode = "1000" or opcode = "1011" else '0';  
            
            MWE <= '1' when opcode = "1100" else '0';
            
            DATAIN <= "10" when opcode = "0000" or opcode = "0001" or opcode = "0010" 
                        or opcode = "0011" or opcode = "0100" or opcode = "0110" else
                       "11" when opcode = "1000" else
                       "01" when opcode = "1011" else 
                       "00"; 

            ALUOP <= "0000" when opcode = "0000" or opcode = "1011" or opcode = "1100" else 
                    "0001" when opcode = "0001" or opcode = "1101" or opcode = "1110" else 
                    "0010" when opcode = "0010" else 
                    "0011" when opcode = "0011" else 
                    "0100" when opcode = "0100" else 
                    "0101" when opcode = "0110" else 
                    "0000";
                    
                    
            ALUIN <= "10" when opcode = "0110"  else
                    "01" when opcode = "1011" or opcode = "1100" else
                    "00";
                    
            STR <= '1' when opcode = "1100" or opcode = "1001" or opcode = "1010" or opcode = "1110" or opcode = "1101" else '0';
            
            SHIFT <= '1' when opcode = "0110" else '0';
            
	        B <= '1' when opcode = "1101" or opcode = "1110" else '0';
	            
	        JR <= '1' when opcode = "1001" or opcode = "1010" else '0';
	        
            J <= '1' when opcode = "0111" or opcode = "1000" or opcode = "1001" or opcode = "1010" else '0';

end Behavioral;
