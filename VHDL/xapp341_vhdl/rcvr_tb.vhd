
-- VHDL Test Bench Created from source file rcvr.vhd -- 17:36:24 04/12/2000
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

	COMPONENT rcvr
	PORT(
		rst : IN std_logic;
		clk16x : IN std_logic;
		rxd : IN std_logic;
		rdn : IN std_logic;          
		dout : OUT std_logic_vector(7 downto 0);
		data_ready : OUT std_logic;
		framing_error : OUT std_logic;
		parity_error : OUT std_logic
		);
	END COMPONENT;

	SIGNAL rst :  std_logic;
	SIGNAL clk16x :  std_logic;
	SIGNAL rxd :  std_logic;
	SIGNAL rdn :  std_logic;
	SIGNAL dout :  std_logic_vector(7 downto 0);
	SIGNAL data_ready :  std_logic;
	SIGNAL framing_error :  std_logic;
	SIGNAL parity_error :  std_logic;

BEGIN

	uut: rcvr PORT MAP(
		rst => rst,
		clk16x => clk16x,
		rxd => rxd,
		rdn => rdn,
		dout => dout,
		data_ready => data_ready,
		framing_error => framing_error,
		parity_error => parity_error
	);

process
begin
clk16x <= '0' ;
wait for 10 ns;
clk16x <= '1' ;
wait for 10 ns;
end process ;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
rst <='0','1' after 3 ns,'0' after 25 ns; 
rdn <='1','0' after 2000 ns,'0' after 3000 ns; 
rxd <= '1','0' after 500 ns,'0' after 1000 ns,'1' after 1500 ns,'0' after 2000 ns ;
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
