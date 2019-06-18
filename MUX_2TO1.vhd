-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: 2 to 1 Mux


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_2TO1 is
  GENERIC (InputSize : integer := 4);
  Port (input0, input1: in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
		sel : in std_logic := '0';
		output : out std_logic_vector((InputSize - 1) downto 0) := (others => '0')
		);
end MUX_2TO1;

architecture Behavioral of MUX_2TO1 is

begin

output <= input0 when sel = '0' else 
		  input1 when sel = '1' else 
		  (others => '0');
			
end Behavioral;