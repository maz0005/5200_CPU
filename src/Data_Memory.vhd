-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Data Memory

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is 
generic (BITS : integer := 10);
port (CLK : in std_logic := '0';
        address_bus : in std_logic_vector(9 downto 0) := (others => '0');
		write_enable : in std_logic := '0';
		input_bus : in std_logic_vector(15 downto 0) := (others => '0');
		output_bus : out std_logic_vector(15 downto 0) := (others => '0')
		);
end Data_Memory;

architecture behavioral of Data_Memory is

	subtype WORD is std_logic_vector(15 downto 0);
	type MEM is array (0 to (2**BITS) - 1) of word;
	constant INSTRUCTIONS : MEM := (others => (others => '0'));
	signal MEM_S : MEM := INSTRUCTIONS;

begin 

process (CLK) begin  --To sythesize and implement,  use write_enable instead of CLK and check rising_edge(write_enable) 
				     --This assumes the signal has been delayed by the contoller to prevent a data hazard.
	if (falling_edge(CLK) and write_enable = '1') then 
		MEM_S(to_integer(unsigned(address_bus))) <= input_bus;
	end if;
	
end process;

output_bus <= MEM_S(to_integer(unsigned(address_bus)));

end behavioral;