--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:40:16 09/18/2018
-- Design Name:   
-- Module Name:   D:/Repository/XILINX/aesdataunit/ttb.vhd
-- Project Name:  aesdataunit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dataunit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ttb IS
END ttb;
 
ARCHITECTURE behavior OF ttb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dataunit
    PORT(
         CLK : IN  std_logic;
         rst_n : IN  std_logic;
         keywords : IN  std_logic_vector(127 downto 0);
         in0 : IN  std_logic_vector(7 downto 0);
         in1 : IN  std_logic_vector(7 downto 0);
         in2 : IN  std_logic_vector(7 downto 0);
         in3 : IN  std_logic_vector(7 downto 0);
         key_lenght : IN  std_logic_vector(1 downto 0);
         enc : IN  std_logic;
			ROUND : OUT  std_logic_vector(3 downto 0);
         data_out0, data_out1,
			data_out2, data_out3 : out std_logic_vector (7 downto 0);
			valid_out							: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal keywords : std_logic_vector(127 downto 0) := (others => '0');
   signal in0 : std_logic_vector(7 downto 0) := (others => '0');
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal in2 : std_logic_vector(7 downto 0) := (others => '0');
   signal in3 : std_logic_vector(7 downto 0) := (others => '0');
   signal key_lenght : std_logic_vector(1 downto 0) := (others => '0');
   signal enc : std_logic := '0';

 	--Outputs
	signal data_out0, data_out1,
			data_out2, data_out3				: std_logic_vector (7 downto 0);
	signal ROUND : std_logic_vector(3 downto 0);
	signal valid_out							: std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dataunit PORT MAP (
          CLK => CLK,
          rst_n => rst_n,
          keywords => keywords,
          in0 => in0,
          in1 => in1,
          in2 => in2,
          in3 => in3,
			 ROUND => ROUND,
          key_lenght => key_lenght,
          enc => enc,
          data_out0 => data_out0,
          data_out1 => data_out1,
          data_out2 => data_out2,
          data_out3 => data_out3,
			 valid_out => valid_out
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

		rst_n <= '1';
		enc <= '1';
		keywords <= X"09cf4f3c" & X"ABF71588" & X"28AED2A6" &X"2B7E1516";
		
		in0 <= X"32"; in1 <= X"43"; in2 <= X"F6"; in3 <= X"A8";
		wait for 60 ns;
		in0 <= X"88"; in1 <= X"5A"; in2 <= X"30"; in3 <= X"8D";
		wait for 20 ns;
		in0 <= X"31"; in1 <= X"31"; in2 <= X"98"; in3 <= X"A2";
		wait for 20 ns;
		in0 <= X"E0"; in1 <= X"37"; in2 <= X"07"; in3 <= X"34";
		wait for 110 ns;
		keywords <= X"2a6c7605" & X"23a33939" & X"88542cb1" &X"a0fafe17";
		wait for 120 ns;
		keywords <= X"7359f67f" & X"5935807a" & X"7a96b943" &X"f2c295f2";
		wait for 140 ns;
		keywords <= X"6D7A883B" & X"1E237E44" & X"4716FE3E" &X"3D80477D";
		wait for 140 ns;
		keywords <= X"DB0BAD00" & X"b671253B" & X"A8525B7F" &X"EF44A541";
		wait for 140 ns;
		keywords <= X"11F915BC" & X"CAF2B8BC" & X"7C839D87" &X"D4D1C6F8";
		wait for 140 ns;
		keywords <= X"CA0093FD" & X"DBF98641" & X"110B3EFD" &X"6D88A37A";
		wait for 140 ns;
		keywords <= X"4EA6DC4F" & X"84A64FB2" & X"5F5FC9F3" &X"4E54F70E";
		wait for 140 ns;
		keywords <= X"7F8D292F" & X"312BF560" & X"B58DBAD2" &X"EAD27321";
		wait for 140 ns;
		keywords <= X"575C006E" & X"28D12941" & X"19FADC21" &X"AC7766F3";
		wait for 140 ns;
		keywords <= X"B6630CA6" & X"E13F0CC8" & X"C9EE2589" &X"D014F9A8";
		wait for 140 ns;

--		wait for 30 ns;
--		in0 <= X"88"; in1 <= X"5A"; in2 <= X"30"; in3 <= X"8D";
--		wait for 10 ns;
--		in0 <= X"31"; in1 <= X"31"; in2 <= X"98"; in3 <= X"A2";
--		wait for 10 ns;
--		in0 <= X"E0"; in1 <= X"37"; in2 <= X"07"; in3 <= X"34";
--		wait for 55 ns;
--		keywords <= X"2a6c7605" & X"23a33939" & X"88542cb1" &X"a0fafe17";
--		wait for 60 ns;
--		keywords <= X"7359f67f" & X"5935807a" & X"7a96b943" &X"f2c295f2";
--		wait for 70 ns;
--		keywords <= X"6D7A883B" & X"1E237E44" & X"4716FE3E" &X"3D80477D";
--		wait for 70 ns;
--		keywords <= X"DB0BAD00" & X"b671253B" & X"A8525B7F" &X"EF44A541";
--		wait for 70 ns;
--		keywords <= X"11F915BC" & X"CAF2B8BC" & X"7C839D87" &X"D4D1C6F8";
--		wait for 70 ns;
--		keywords <= X"CA0093FD" & X"DBF98641" & X"110B3EFD" &X"6D88A37A";
--		wait for 70 ns;
--		keywords <= X"4EA6DC4F" & X"84A64FB2" & X"5F5FC9F3" &X"4E54F70E";
--		wait for 70 ns;
--		keywords <= X"7F8D292F" & X"312BF560" & X"B58DBAD2" &X"EAD27321";
--		wait for 70 ns;
--		keywords <= X"575C006E" & X"28D12941" & X"19FADC21" &X"AC7766F3";
--		wait for 70 ns;
--		keywords <= X"B6630CA6" & X"E13F0CC8" & X"C9EE2589" &X"D014F9A8";
--		wait for 70 ns;

      wait;
   end process;

END;
