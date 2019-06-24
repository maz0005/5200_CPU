-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Concatenate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Concatenate is
 Port (input1 : in std_logic_vector(7 downto 0) := (others => '0');
      input2 : in std_logic_vector(7 downto 0) := (others => '0');
      output : out std_logic_vector(15 downto 0) := (others => '0')
      );
end Concatenate;

architecture Behavioral of Concatenate is
begin

process (input1, input2) begin 
output(15 downto 0) <= input1(7 downto 0) & input2(7 downto 0);
end process;

end Behavioral;
