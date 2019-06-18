-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Program Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
  Port (clk : in std_logic := '0';
        input_address : in std_logic_vector(15 downto 0) := (others => '0'); 
        output : out std_logic_vector(15 downto 0) := (others => '0')
        );
end PC;

architecture Behavioral of PC is

begin

process(CLK) begin
if (rising_edge(CLK)) then 
output <= input_address;
end if;

end process;
end Behavioral;
