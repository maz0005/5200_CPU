-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Unsigned Extender

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Unsigned_Extend is
	GENERIC (InputSize : integer := 8;	
         DesiredSize : integer := 16);
    Port(input : in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
    extendedOutput : out std_logic_vector((DesiredSize - 1) downto 0) := (others => '0'));
end Unsigned_Extend;

architecture Behavioral of Unsigned_Extend is

begin

extendedOutput <= std_logic_vector(resize(unsigned(input), DesiredSize));

end Behavioral;
