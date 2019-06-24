-- Marco A. Zuniga
-- CPU Design Part 3 
-- Component: Register File Test Bench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity RF_TB is
   -- Port();
end RF_TB;

architecture Behavioral of RF_TB is

signal RWE_S : std_logic := '0';
signal rd_S : std_logic_vector(3 downto 0) := (others => '0');
signal rs_S : std_logic_vector(3 downto 0) := (others => '0');
signal rt_S : std_logic_vector(3 downto 0) := (others => '0');

signal DataIn_S : std_logic_vector(15 downto 0) := (others => '0');  --Data to write to rd
signal Qs_S : std_logic_vector(15 downto 0) := (others => '0'); 
signal Qt_S : std_logic_vector(15 downto 0) := (others => '0');  --Output of registers rs and rt

component Register_File is 
	Port(RWE : in std_logic := '0';
		rd, rs, rt : in std_logic_vector(3 downto 0) := (others => '0'); --define registers
		DataIn : in std_logic_vector(15 downto 0) := (others => '0');  --Data to write to rd
		Qs, Qt : out std_logic_vector(15 downto 0) := (others => '0')  --Output of registers rs and rt
		); 
end component;
begin

RF1 : Register_File
    port map(RWE => RWE_S, rd => rd_S, rs => rs_S, rt => rt_S, DataIn => DataIn_S, Qs => Qs_S, Qt => Qt_S);

process begin
WriteAddressAsData: for i in 0 to 15 loop
DataIn_S <= std_logic_vector(to_unsigned(i, 16));
rd_S <= std_logic_vector(to_unsigned(i, 4));
wait for 5 ns;
RWE_S <= '1', '0' after 2 ns;
wait for 5 ns; 
end loop;

ReadEachAddress: for i in 0 to 15 loop
rs_S <= std_logic_vector(to_unsigned(i, 4));
rt_S <= std_logic_vector(to_unsigned(i, 4));

wait for 5 ns;
    assert(Qs_S = std_logic_vector(to_unsigned(i, 16)))
        report "Address and data don't equal";
end loop;

WriteInvertedAddressAsData: for i in 0 to 15 loop
DataIn_S <= not std_logic_vector(to_unsigned(i, 16));
rd_S <= std_logic_vector(to_unsigned(i, 4));
wait for 5 ns;
RWE_S <= '1', '0' after 2 ns;
wait for 5 ns; 
end loop;

ReadEachInvertedData: for i in 0 to 15 loop
rs_S <= std_logic_vector(to_unsigned(i, 4));
rt_S <= std_logic_vector(to_unsigned(i, 4));

wait for 5 ns;
    assert(Qs_S = not std_logic_vector(to_unsigned(i, 16)))
        report "Address and data don't equal";
end loop;


WriteAddressAsData2: for i in 0 to 15 loop
DataIn_S <= std_logic_vector(to_unsigned(i, 16));
rd_S <= std_logic_vector(to_unsigned(i, 4));
wait for 5 ns;
RWE_S <= '1', '0' after 2 ns;
wait for 5 ns; 
end loop;

ReadEachAddress2: for i in 0 to 15 loop
rs_S <= std_logic_vector(to_unsigned(i, 4));
rt_S <= std_logic_vector(to_unsigned(i, 4));

wait for 5 ns;
    assert(Qs_S = std_logic_vector(to_unsigned(i, 16)))
        report "Address and data don't equal";
end loop;

end process;

end Behavioral;
