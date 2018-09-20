library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mix_columns is
port (

--INPUT
	cell_num 					: in std_logic_vector (3 downto 0);
	s0c, s1c, s2c, s3c		: in std_logic_vector (7 downto 0);
	
--OUTPUT
	Q								: out std_logic_vector (7 downto 0)
	);
end mix_columns;

architecture arc of mix_columns is

component xtime is
	port (
			a			: in std_logic_vector (7 downto 0);
			q			: out std_logic_vector (7 downto 0)
			);
end component;

component mul03 is
	port (
			a			: in std_logic_vector (7 downto 0);
			q			: out std_logic_vector (7 downto 0)
			);
end component;

signal xs0c, xs1c, xs2c, xs3c							: std_logic_vector (7 downto 0);
signal mul03s0c, mul03s1c, mul03s2c, mul03s3c	: std_logic_vector (7 downto 0);

begin

	MUL0: mul03 port map (a => s0c, q=> mul03s0c);
	MUL1: mul03 port map (a => s1c, q=> mul03s1c);
	MUL2: mul03 port map (a => s2c, q=> mul03s2c);
	MUL3: mul03 port map (a => s3c, q=> mul03s3c);
	
	X0: xtime port map (a => s0c, q=> xs0c);
	X1: xtime port map (a => s1c, q=> xs1c);
	X2: xtime port map (a => s2c, q=> xs2c);
	X3: xtime port map (a => s3c, q=> xs3c);
	
	q <= 	(xs0c xor mul03s1c xor s2c xor s3c) when cell_num="0000" or cell_num="0001" or cell_num="0010" or cell_num="0011" else 
			(s0c xor xs1c xor mul03s2c xor s3c) when cell_num="0100" or cell_num="0101" or cell_num="0110" or cell_num="0111" else 
			(s0c xor s1c xor xs2c xor mul03s3c) when cell_num="1000" or cell_num="1001" or cell_num="1010" or cell_num="1011" else
			(mul03s0c xor s1c xor s2c xor xs3c);

end arc;

