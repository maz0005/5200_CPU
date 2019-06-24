-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: 4 to 1 Mux
-- Note: The clock is needed to assure the correct PC value is saved in Jump and Link Register
--       It'll capture the PC value right before it changes to the JUMP address.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_4TO1 is
  Port (input0, input1, input2, input3 : in std_logic_vector(15 downto 0) := (others => '0');
  sel : in std_logic_vector(1 downto 0);
  output : out std_logic_vector(15 downto 0) := (others => '0')
  );
end MUX_4TO1;

architecture Behavioral of MUX_4TO1 is

begin
 
output <= input0 when sel = "00" else
            input1 when sel = "01" else
            input2 when sel = "10" else
            input3 when sel = "11" else
            (others => '0');
 
end Behavioral;
