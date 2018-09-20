library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datacell_datapath is

port (
		CLK, rst_n 							: in std_logic;
		
		-- control inputs
		sel_mix, sel_state				: in std_logic_vector (1 downto 0);
		sel_right							: in std_logic;
		load_state							: in std_logic;
		
		-- data in
		in_right, up_in, keybyte		: in std_logic_vector (7 downto 0);
		s0c, s1c, s2c, s3c				: in std_logic_vector (7 downto 0);
		cell_num 							: in std_logic_vector (3 downto 0);
		ROUND									: in std_logic_vector (3 downto 0);
		
		-- state signals
		STT									: out std_logic_vector (7 downto 0)
	);
	
end datacell_datapath;

architecture arc of datacell_datapath is


component mux2input is
generic (N: integer);
port (
	sel : in std_logic;
	I0 : in std_logic_vector(7 downto 0);
	I1 : in std_logic_vector(7 downto 0);
	Y : out std_logic_vector(7 downto 0)
);
end component;

component mux3input is
generic (N: integer);
port (
	sel : in std_logic_vector(1 downto 0);
	I0 : in std_logic_vector(N-1 downto 0);
	I1 : in std_logic_vector(N-1 downto 0);
	I2 : in std_logic_vector(N-1 downto 0);
	Y : out std_logic_vector(N-1 downto 0)
);
end component;

component adder2input is
generic( N : integer);
port (
	I0 : in std_logic_vector(N-1 downto 0);
	I1 : in std_logic_vector(N-1 downto 0);
	Y : out std_logic_vector(N-1 downto 0)
);
end component;


component add_roundkey is
port (
	I0 : in std_logic_vector(7 downto 0);
	I1 : in std_logic_vector(7 downto 0);
	Y : out std_logic_vector(7 downto 0)
);
end component;

component mix_columns is
port (

--INPUT
	cell_num 					: in std_logic_vector (3 downto 0);
	s0c, s1c, s2c, s3c		: in std_logic_vector (7 downto 0);
	
--OUTPUT
	Q								: out std_logic_vector (7 downto 0)
	);
end component;

component reg is
generic( N : integer);
port (
	CLK, rst_n : in std_logic;
	load : in std_logic;
	D : in std_logic_vector(N-1 downto 0);
	Q : out std_logic_vector(N-1 downto 0)
);
end component;

--------------------------------------------------
	signal 	STT_in, STT_out 							: std_logic_vector(7 downto 0);
	signal 	mix_out, selmix_out, 
				selright_out, addround_out 			: std_logic_vector(7 downto 0);

begin

-- REGISTERS
	STT1	: reg generic map(8) port map (CLK => CLK, rst_n => rst_n, load => load_STATE, D => STT_in, Q => STT_out);
	
--STT
	MIX	: mix_columns port map(cell_num => cell_num, s0c => s0c, s1c => s1c, s2c => s2c, s3c => s3c, Q=> mix_out	);
	MUX2	: mux3input generic map(8) port map(sel => sel_mix, I0 => in_right, I1 => mix_out, I2 =>STT_out, Y=>selmix_out);
	AD_K1	: add_roundkey port map( I0 => selmix_out, I1 => keybyte, Y=> addround_out);
	MUX3	: mux2input generic map(8) port map(sel=> sel_right, I0 => in_right, I1 => addround_out, Y=>selright_out);
	MUX4	: mux3input generic map(8) port map(sel=> sel_state, I0 => "00000000", I1 => selright_out, I2 => up_in, Y=>STT_in);
	
	STT<= STT_out;
	
end arc;

