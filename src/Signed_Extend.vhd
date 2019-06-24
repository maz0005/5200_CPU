-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Signed Extender

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Signed_Extend is
	GENERIC (InputSize : integer := 4;
         DesiredSize : integer := 16);
    Port(input : in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
    extendedOutput : out std_logic_vector((DesiredSize - 1) downto 0) := (others => '0'));
end Signed_Extend;

architecture Behavioral of Signed_Extend is
begin

extendedOutput <= std_logic_vector(resize(signed(input), DesiredSize));

end Behavioral;