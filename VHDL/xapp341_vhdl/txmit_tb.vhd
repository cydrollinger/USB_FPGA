
-- VHDL Test Bench Created from source file txmit.vhd -- 16:58:29 04/12/2000
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT txmit
	PORT(
		rst : IN std_logic;
		clk16x : IN std_logic;
		wrn : IN std_logic;
		din : IN std_logic_vector(7 downto 0);          
		tbre : OUT std_logic;
		tsre : OUT std_logic;
		sdo : OUT std_logic
		);
	END COMPONENT;

	SIGNAL rst :  std_logic;
	SIGNAL clk16x :  std_logic;
	SIGNAL wrn :  std_logic;
	SIGNAL din :  std_logic_vector(7 downto 0);
	SIGNAL tbre :  std_logic;
	SIGNAL tsre :  std_logic;
	SIGNAL sdo :  std_logic;

BEGIN

	uut: txmit PORT MAP(
		rst => rst,
		clk16x => clk16x,
		wrn => wrn,
		din => din,
		tbre => tbre,
		tsre => tsre,
		sdo => sdo
	);
process
begin
clk16x <= '1' ;
wait for 10 ns ;
clk16x <= '0' ;
wait for 10 ns ;
end process ;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
rst <='0','1' after 3 ns,'0' after 25 ns ;
din <= "11110000","10101010" after 4000 ns;
wrn <='1','0' after 70 ns,'1' after 270 ns,'0' after 4570 ns,'1' after 4900 ns 
;
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
