----------------------------------------------------------------------------------
-- Company: 		Electronic Realization L.L.C.
-- Engineer: 		Cy Drollinger
-- 
-- Create Date:   10:44:37 07/08/2009 
-- Design Name: 	USB/FPGA Spartan3E Develpoement
-- Module Name:   CPLD - Behavioral 
-- Project Name: 
-- Target Devices: XC2C64A VQ100
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.

library UNISIM;
use UNISIM.VComponents.all;

entity CPLD is
    Port ( 																--CPLD LOCATIONS
					
		SCL_1V8 : inout  STD_LOGIC;			--I2C(0) = SCL I2C(1) = SDA
		SDA_1V8 : inout STD_LOGIC;
		INT_1V8 : inout STD_LOGIC;
		SCL_PI: inout STD_LOGIC;
		SDA_PI: inout STD_LOGIC;
		INT_PI: inout STD_LOGIC;
		DIR: inout STD_LOGIC;
		LEDs : out  STD_LOGIC_VECTOR (8 downto 1);			--pin 1-4 and 6-9
		SW : in 		STD_LOGIC_VECTOR (2 downto 0) 		--pin 71, 72, 74 need to be debounced
		);	  
end CPLD;

architecture Behavioral of CPLD is

Signal enable:  std_logic;

		--FPGA Configuration
--signal SW_0_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_0_hi normally hi 
--signal SW_1_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_1_hi normally hi
--signal SW_2_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_2_hi normally hi

begin

enable <= '1' when DIR = '1' else '0';
SCL_1V8 <= SCL_PI;

SDA_1V8 <= SDA_PI when enable = '0' else 'Z';
--SDA_1V8 <= SW(2) when enable = '0' else 'Z';
SDA_PI <= SDA_1V8 when enable = '1' else 'Z';
--SDA_PI <= sw(2) when enable = '1' else 'Z';

INT_PI <= INT_1V8;

LEDs(1) <= enable;
LEDs(2) <= SCL_1V8;
LEDs(3) <= SDA_1V8;
LEDs(4) <= SDA_PI;
LEDs(5) <= SCL_PI;
LEDs(6) <= INT_PI;


end Behavioral;

