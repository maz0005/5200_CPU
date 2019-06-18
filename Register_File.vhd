-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Register File

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is 
	Port(RWE : in std_logic := '0';
	   CLK : in std_logic := '0';
		rd, rs, rt : in std_logic_vector(3 downto 0) := (others => '0'); --define registers
		DataIn : in std_logic_vector(15 downto 0) := (others => '0');  --Data to write to rd
		Qs, Qt : out std_logic_vector(15 downto 0) := (others => '0')  --Output of registers rs and rt
		); 

end Register_File;

architecture Behavioral of Register_File is 

	subtype WORD is std_logic_vector(15 downto 0); --Define size of word
	type RF is array (0 to 15) of WORD;  --Define size of register file
	constant ZEROS : RF := (13 => "0000000000110111",14 => "0000000000000000", others => (others => '0'));
	signal RFSignal : RF := ZEROS;

begin

process(CLK) begin  --To sythesize and implement, use RWE instead of CLK and check rising_edge(RWE). 
					--This assumes the signal has been delayed by the contoller.
    if (falling_edge(CLK) and RWE = '1') then 
        RFSignal(to_integer(UNSIGNED(rd))) <= DataIn;
    end if;
	
end process;

Qs <= RFSignal(to_integer(UNSIGNED(rs)));
Qt <= RFSignal(to_integer(UNSIGNED(rt)));

end Behavioral;
