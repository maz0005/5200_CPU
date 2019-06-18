-- Marco A. Zuniga
-- CPU Design Part 4 
-- Component: Datapath


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    port (
	clk : in std_logic := '0';
	pc_value : out std_logic_vector(15 downto 0) := (others => '0');
    --inputInstruction : in std_logic_vector(15 downto 0) := (others => '0');
    instruction : out std_logic_vector(15 downto 0) := (others => '0');
    register_rt_output : out std_logic_vector(15 downto 0) := (others => '0');
    register_rs_output : out std_logic_vector(15 downto 0) := (others => '0'));
end entity;

architecture Behavioral of TOP is

--------------------------------------------Components Needed--------------------------------
component ControlUnit is 
	Port(opcode : in std_logic_vector(3 downto 0) := (others => '0');  --Opcode needed to send signals
        DATAIN, ALUIN : out std_logic_vector(1 downto 0) := (others => '0');
		ALUOP : out std_logic_vector(3 downto 0) := (others => '0');
        RWE, MWE, STR, SHIFT, B, JR, J: out std_logic := '0'  --Output signals sent throughout datapath
        );
end component;

component Register_File is 
	Port(RWE : in std_logic := '0';
	   CLK : in std_logic := '0';
		rd, rs, rt : in std_logic_vector(3 downto 0) := (others => '0'); --define registers
		DataIn : in std_logic_vector(15 downto 0) := (others => '0');  --Data to write to rd
		Qs, Qt : out std_logic_vector(15 downto 0) := (others => '0')  --Output of registers rs and rt
		); 
end component;

component ALU is
	Port(ALUOP : in std_logic_vector(3 downto 0) := (others => '0');    --arithmetic to perform
		operand1 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rs
		operand2 : in std_logic_vector(15 downto 0) := (others => '0');  --data from register rt or an immediate
		output : out std_logic_vector(15 downto 0) := (others => '0');  --Result 
		zero : out std_logic := '0'    --zero flag 
		);
end component;

component MUX_4TO1 is
  Port (input0, input1, input2, input3 : in std_logic_vector(15 downto 0) := (others => '0');
  sel : in std_logic_vector(1 downto 0);
  output : out std_logic_vector(15 downto 0) := (others => '0')
  );
end component;

component MUX_2TO1 is
  GENERIC (InputSize : integer := 4);
  Port (input0, input1: in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
  sel : in std_logic := '0';
  output : out std_logic_vector((InputSize - 1) downto 0) := (others => '0')
  );
end component;


component Unsigned_Extend is
	GENERIC (InputSize : integer := 8;
         DesiredSize : integer := 16);
    Port(input : in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
    extendedOutput : out std_logic_vector((DesiredSize - 1) downto 0) := (others => '0'));
end component;

component Signed_Extend is
	GENERIC (InputSize : integer := 4;
         DesiredSize : integer := 16);
    Port(input : in std_logic_vector((InputSize - 1) downto 0) := (others => '0');
    extendedOutput : out std_logic_vector((DesiredSize - 1) downto 0) := (others => '0'));
end component;

component Concatenate is
 Port (input1 : in std_logic_vector(7 downto 0) := (others => '0');
      input2 : in std_logic_vector(7 downto 0) := (others => '0');
      output : out std_logic_vector(15 downto 0) := (others => '0')
      );
end component;

component PC 
  Port (clk : in std_logic := '0';
      input_address : in std_logic_vector(15 downto 0) := (others => '0'); 
      output : out std_logic_vector(15 downto 0) := (others => '0')
      );
end component;

component InstructionMemory is 
generic (BITS : integer := 10);
port (input_address : in std_logic_vector(9 downto 0) := (others => '0');
		output_instruction : out std_logic_vector(15 downto 0) := (others => '0')
		);
end component;

component Data_Memory is 
generic (BITS : integer := 10);
port (CLK : in std_logic := '0';
        address_bus : in std_logic_vector(9 downto 0) := (others => '0');
		write_enable : in std_logic := '0';
		input_bus : in std_logic_vector(15 downto 0) := (others => '0');
		output_bus : out std_logic_vector(15 downto 0) := (others => '0')
		);
end component;


--Signals related to controller
signal opcodeS : std_logic_vector(3 downto 0) := (others => '0');  --Opcode needed to send signals
signal DATAINS : std_logic_vector(1 downto 0) := (others => '0');
signal ALUINS : std_logic_vector(1 downto 0) := (others => '0');
signal ALUOPS : std_logic_vector(3 downto 0) := (others => '0');
signal RWES : std_logic := '0';
signal MWES : std_logic := '0';
signal STRS : std_logic := '0';
signal SHIFTS : std_logic := '0'; 
signal BS : std_logic := '0';
signal JRS : std_logic := '0';
signal JS : std_logic := '0'; 

--Signals related to Register File
signal rd_RF_S : std_logic_vector(3 downto 0) := (others => '0');
signal DataIn_RF_S : std_logic_vector(15 downto 0) := (others => '0');  --Data to write to rd
signal Qs_RF_S : std_logic_vector(15 downto 0) := (others => '0'); 
signal Qt_RF_S : std_logic_vector(15 downto 0) := (others => '0'); 

--signals related to ALU
signal operand2_ALU_S : std_logic_vector(15 downto 0) := (others => '0');  
signal output_ALU_S : std_logic_vector(15 downto 0) := (others => '0');  --Result 
signal zero_ALU_S : std_logic := '0';    --zero flag 

--signals related to ALU to compute branch address
signal computedBranchS : std_logic_vector(15 downto 0) := (others => '0');
signal zero_branchS : std_logic := '0';

--signals related to 4 to 1 Mux for DataIn of register file
signal output_4to1_Mux_DATAIN : std_logic_vector(15 downto 0) := (others => '0');

--signals related to 4 to 1 Mux for operand1 selection of ALUIN   
signal output_4to1_Mux_ALUIN : std_logic_vector(15 downto 0) := (others => '0');

--signals related to 2 to 1 Mux for rt input
signal output_2to1_Mux_rt : std_logic_vector(3 downto 0) := (others => '0');

--signals related to 2 to 1 Mux for rs input
signal output_2to1_Mux_rs : std_logic_vector(3 downto 0) := (others => '0');

--signals related to 2 to 1 Mux for Branch output
signal BranchSelect : std_logic := '0';
signal output_2to1_Mux_B : std_logic_vector(15 downto 0) := (others => '0');

--signals related to 2 to 1 Mux for JR output
signal output_2to1_Mux_JR : std_logic_vector(15 downto 0) := (others => '0');

--signals related to 2 to 1 Mux for J output
signal output_2to1_Mux_J : std_logic_vector(15 downto 0) := (others => '0');

--signals related to sign extender for first input of DATAIN Mux (Immediate operand)
signal DataIn0Extended : std_logic_vector(15 downto 0) := (others => '0');

--signals related to sign extender for first input of B Mux (signed 4-bit added to PC)
signal branchExtendedS : std_logic_vector(15 downto 0) := (others => '0');

--signals related to unsigned entender for shift amount
signal LSL_Amount_Extended : std_logic_vector(15 downto 0) := (others => '0');

--signals related to concatenate component
signal output_Conc : std_logic_vector(15 downto 0) := (others => '0');

--signals related to PC component
signal PC_zero : std_logic := '0';
signal PC_Updated_S : std_logic_vector(15 downto 0) := (others => '0');
signal PC_Incremented : std_logic_vector(15 downto 0) := (others => '0');

--signals realted to memory
signal inputInstruction : std_logic_vector(15 downto 0) := (others => '0');
signal DataMemOutput_S : std_logic_vector(15 downto 0) := (others => '0');

begin

------------------------------------Major Datapath Components (CU, RF, ALU)---------------------------------
CU_Component : ControlUnit
	Port map(opcode => inputInstruction(15 downto 12), DATAIN => DATAINS, ALUIN => ALUINS, ALUOP 
	=> ALUOPS, RWE => RWES, MWE => MWES, STR => STRS, SHIFT => SHIFTS, B => BS, JR => JRS, J => JS);

RF_Component : Register_File  
--
	Port map(RWE => RWES, CLK => clk, rd => inputInstruction(11 downto 8), rs => output_2to1_Mux_rs, 
	rt => output_2to1_Mux_rt, DataIn => output_4to1_Mux_DATAIN, Qs => Qs_RF_S, Qt => Qt_RF_S); 
	
ALU_MAIN : ALU 
        Port map(ALUOP => ALUOPS, operand1 => output_4to1_Mux_ALUIN, operand2 => Qs_RF_S, output => 
		output_ALU_S, zero => zero_ALU_S);

ALU_PC : ALU 
        Port map(ALUOP => "0000", operand1 => PC_Updated_S, operand2 => "0000000000000001", 
		output => PC_Incremented, zero => PC_zero);

ALU_BRANCH : ALU 
        Port map(ALUOP => "0000", operand1 => PC_Incremented, operand2 => branchExtendedS, 
		output => computedBranchS, zero => zero_branchS);



----------------------------------Start of MUX instantiations--------------------------------------        
DataIn_Mux : MUX_4TO1 
          Port map(input0 => DataIn0Extended, input1 => DataMemOutput_S, input2 => output_ALU_S, 
          input3 => PC_Incremented, sel => DATAINS, output => output_4to1_Mux_DATAIN);

ALUIn_Mux : MUX_4TO1 -- This is where I put (others => '0') instead of branchExtendedS
          Port map(input0 => Qt_RF_S, input1 => branchExtendedS, input2 => DataIn0Extended, 
          input3 => (others => '0'), sel => ALUINS, output => output_4to1_Mux_ALUIN);

rt_MUX: MUX_2TO1
    generic map(InputSize => 4)
  Port map(input0 => inputInstruction(3 downto 0), input1 => inputInstruction(11 downto 8), sel => STRS,
  output => output_2to1_Mux_rt);

rs_MUX: MUX_2TO1
    generic map(InputSize => 4)
  Port map(input0 => inputInstruction(7 downto 4), input1 => inputInstruction(11 downto 8), sel => SHIFTS,
  output => output_2to1_Mux_rs);

BRANCH_MUX: MUX_2TO1
    generic map(InputSize => 16)
  Port map(input0 => PC_Incremented, input1 => computedBranchS, sel => BranchSelect, 
  output => output_2to1_Mux_B);

JR_MUX: MUX_2TO1
    generic map(InputSize => 16)
  Port map(input0 => output_Conc, input1 => Qt_RF_S, sel => JRS, output => output_2to1_Mux_JR);

J_MUX: MUX_2TO1
    generic map(InputSize => 16)
  Port map(input0 => output_2to1_Mux_B, input1 => output_2to1_Mux_JR, sel => JS, 
  output => output_2to1_Mux_J);
  
--------------------------------------------Signed/Unsigned Extending Components---------------------
Immediate_Extended : Signed_Extend
    generic map(InputSize => 8, DesiredSize => 16)
    Port map(input => inputInstruction(7 downto 0), extendedOutput => DataIn0Extended);

BRANCH_EXTENDED : Signed_Extend
    generic map(InputSize => 4, DesiredSize => 16)
    Port map(input => inputInstruction(3 downto 0), extendedOutput => branchExtendedS);

ALUIN_LSL : Unsigned_Extend
    generic map(InputSize => 8, DesiredSize => 16)
    Port map(input => inputInstruction(7 downto 0), extendedOutput => LSL_Amount_Extended); 
    

--------------------------------------------------Concatanate Component------------------------------
ConcatanateComponent : Concatenate
Port map(input1 => PC_Updated_S(15 downto 8), input2 => inputInstruction(7 downto 0), output => output_Conc);

----------------------------------------------------------PC----------------------------------------- 
PC_Component : PC 
Port map(clk => clk, input_address => output_2to1_Mux_J, output => PC_Updated_S);  

-------------------------------------------------MEMORIES------------------------------------------  
InsMem : InstructionMemory 
generic map (BITS => 10)
port map(input_address => PC_Updated_S(9 downto 0), output_instruction => inputInstruction);

DataMem : Data_Memory 
generic map(BITS => 10)
port map(CLK => clk,address_bus => output_ALU_S(9 downto 0),write_enable => MWES,input_bus => Qt_RF_S,output_bus => DataMemOutput_S);

---------------------------------------End of component instantiation-------------------------------
BranchSelect <= (inputInstruction(15) and inputInstruction(14) and not inputInstruction(13) 
and inputInstruction(12) and zero_ALU_S) or (inputInstruction(15) and inputInstruction(14) 
and inputInstruction(13) and not inputInstruction(12) and not zero_ALU_S);

register_rt_output <= Qt_RF_S;
register_rs_output <= Qs_RF_S;
pc_value <= PC_Updated_S;
instruction <= inputInstruction;


end Behavioral;
