----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:28 07/08/2009 
-- Design Name: 
-- Module Name:    FPGA - Behavioral 
-- Project Name: 
-- Target Devices: 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA is
    Port ( 
				mclk : in  STD_LOGIC;
				D : out STD_LOGIC_VECTOR(0 to 7)	
			);
	 
end FPGA;

architecture Behavioral of FPGA is

Signal clk_count: STD_LOGIC_VECTOR (29 downto 0):="000000000000000000000000000000";
Constant one: STD_LOGIC_VECTOR (29 downto 0):="000000000000000000000000000001";

begin
-- Author		: Cy Drollinger
-- Date			: ?
-- Description	: one second timer led on 1 sec. off 1 sec. 
counter: process(mclk)
begin
    if mclk'event and mclk='1' then
clk_count <= clk_count + one;
    end if;
end process;

D <= clk_count(29) & clk_count(28) & clk_count(27) & clk_count(26) & clk_count(25) & clk_count(24) & clk_count(23) & clk_count(22);

end Behavioral;

