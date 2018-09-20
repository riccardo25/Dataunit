library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity dataunit_control is

port (
		CLK, rst_n 							: in std_logic;

		-- data inputs

		--STT									: in std_logic_vector (7 downto 0);
		ROUND									: in std_logic_vector (3 downto 0);
		key_lenght							: in std_logic_vector (1 downto 0);
		enc									: in std_logic;
		-- data outputs

		sel_mix, sel_state				: out std_logic_vector (1 downto 0);
		sel_round, sel_right				: out std_logic;
		br0_sel, br1_sel, 
		br2_sel, br3_sel					: out std_logic_vector (1 downto 0);
		load_round, load_state			: out std_logic
	);

end dataunit_control;

architecture arc of dataunit_control is


	type statetype is (	INIT, LOAD0, LOAD1, LOAD2, LOAD3,
								SUBSHIFT0, SUBSHIFT1, SUBSHIFT2, SUBSHIFT3, SUBSHIFT4, SUBSHIFT5,
								MIXADD, FINALSTEP,
								UNLOAD0, UNLOAD1, UNLOAD2, UNLOAD3 );
	signal state, nextstate : statetype;

begin

	--FSM
	state <= 	INIT 	when rst_n = '0' else nextstate when rising_edge(CLK);
	
	process (state, ROUND, key_lenght)
	begin
	
		case state is

			when INIT =>
				nextstate <= LOAD0;
			when LOAD0 =>
				nextstate <= LOAD1;
			when LOAD1 =>
				nextstate <= LOAD2;
			when LOAD2 =>
				nextstate <= LOAD3;
			when LOAD3 =>
				nextstate <= SUBSHIFT0;
			when SUBSHIFT0 =>
				nextstate <= SUBSHIFT1;
			when SUBSHIFT1 =>
				nextstate <= SUBSHIFT2;
			when SUBSHIFT2 =>
				nextstate <= SUBSHIFT3;
			when SUBSHIFT3 =>
				nextstate <= SUBSHIFT4;
			when SUBSHIFT4 =>
				nextstate <= SUBSHIFT5;
			when SUBSHIFT5 =>
			
				if(key_lenght = "00" and ROUND = "1010") then --10
					nextstate <= FINALSTEP;
				elsif (key_lenght = "01" and ROUND = "1100") then --12
					nextstate <= FINALSTEP;
				elsif (key_lenght = "10" and ROUND = "1110") then --14
					nextstate <= FINALSTEP;
				else
					nextstate <= MIXADD;
				end if;
			
			when MIXADD =>
				nextstate <= SUBSHIFT0;
			when FINALSTEP =>
				nextstate <= UNLOAD0;
			when UNLOAD0 =>
				nextstate <= UNLOAD1;
			when UNLOAD1 =>
				nextstate <= UNLOAD2;
			when UNLOAD2 =>
				nextstate <= UNLOAD3;
			when UNLOAD3 =>
				nextstate <= INIT;
			when others =>
				nextstate <= INIT;
		end case;
	end process;
	
		sel_round	<= '0' when state=INIT else
							'1';
							
		sel_mix		<= "00" when state=LOAD3 else
							"01" when state=MIXADD else
							"10";
							
		sel_state	<= "00" when state=INIT else
							"01" when state=LOAD0 or state=LOAD1 or state=LOAD2 or state=LOAD3 or state=MIXADD or state=FINALSTEP or state=UNLOAD0 or state=UNLOAD1 or state=UNLOAD2 or state=UNLOAD3  else
							"10";
		
		sel_right	<= '0' when state=LOAD0 or state=LOAD1 or state=LOAD2 or state=UNLOAD0 or state=UNLOAD1 or state=UNLOAD2 or state=UNLOAD3 else
							'1';
		
		load_round	<= '1' when state=INIT or state=LOAD3 or state=MIXADD else
							'0';
		
		load_state	<=	'1';
		
		br0_sel 	<= "11" when state=SUBSHIFT3 else
						"10" when state=SUBSHIFT4 else
						"01" when state=SUBSHIFT5 else
						"00";
						
		br1_sel 	<= "00" when state=SUBSHIFT3 else
						"11" when state=SUBSHIFT4 else
						"10" when state=SUBSHIFT5 else
						"01";
		 
		br2_sel	<= "01" when state=SUBSHIFT3 else
						"00" when state=SUBSHIFT4 else
						"11" when state=SUBSHIFT5 else
						"10";
						
		br3_sel	<= "10" when state=SUBSHIFT3 else
						"01" when state=SUBSHIFT4 else
						"00" when state=SUBSHIFT5 else
						"11";

end arc;



