library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX_4TO1_TB is
--  Port ( );
end MUX_4TO1_TB;

architecture Behavioral of MUX_4TO1_TB is

component MUX_4TO1 is
  Port (input0, input1, input2, input3 : in std_logic_vector(15 downto 0) := (others => '0');
  sel : in std_logic_vector(1 downto 0);
  output : out std_logic_vector(15 downto 0) := (others => '0')
  );
end component;

signal input0S : std_logic_vector(15 downto 0) := (others => '0');
signal input1S : std_logic_vector(15 downto 0) := (others => '0');
signal input2S : std_logic_vector(15 downto 0) := (others => '0');
signal input3S : std_logic_vector(15 downto 0) := (others => '0');
signal selS : std_logic_vector(1 downto 0);
signal outputS : std_logic_vector(15 downto 0) := (others => '0');

begin

MUX : MUX_4TO1
 port map(input0 => input0S, input1 => input1S, input2 => input2S, input3 => input3S, sel => selS, output => outputS);

process begin 



input0S <= "0101010101010101";
input1S <= "1010101010101010";
input2S <= "1111111111111111";
input3S <= "0000000000000000";

selS <= "00";

wait for 5ns;

assert(outputS = "0101010101010101");
    report("11 didn't select correct input");

selS <= "11";

wait for 5ns;

assert(outputS = "0000000000000000");
    report("11 didn't select correct input");

selS <= "10";

wait for 5ns;

assert(outputS = "1111111111111111");
    report("11 didn't select correct input");

selS <= "01";

wait for 5ns;

assert(outputS = "1010101010101010");
    report("11 didn't select correct input");

selS <= "00";

wait for 5ns;

assert(outputS = "0101010101010101");
    report("11 didn't select correct input");
 
wait;
end process;

end Behavioral;
