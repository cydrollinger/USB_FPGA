--    File Name:  rcvr.vhd
--      Version:  1.1
--         Date:  January 22, 2000
--        Model:  Uart Chip
-- Dependencies:  uart.vhd
--
--      Company:  Xilinx
--
--
--   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
--                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
--                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
--                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
--
--                Copyright (c) 2000 Xilinx, Inc.
--                All rights reserved
--

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;

entity rcvr is
port (rst,clk16x,rxd,rdn : in std_logic ;
	dout : out std_logic_vector (7 downto 0) ;
	data_ready : out std_logic ;
	framing_error : out std_logic ;
	parity_error : out std_logic 
) ;
end rcvr ;

architecture v1 of rcvr is

signal rxd1 : std_logic ;
signal rxd2 : std_logic ;
signal clk1x_enable : std_logic ;
signal clkdiv :  unsigned (3 downto 0) ;
signal rsr : unsigned (7 downto 0) ;
signal rbr : unsigned (7 downto 0) ;
signal no_bits_rcvd : unsigned (3 downto 0) ;
signal parity : std_logic ;
signal clk1x : std_logic ;

begin

process (rst,clk16x)
begin
if rst = '1' then
rxd1 <= '1' ;
rxd2 <= '1' ;
elsif clk16x'event and clk16x = '1' then
rxd2 <= rxd1 ;
rxd1 <= rxd ;
end if ;
end process ;

process (rst,clk16x,rxd1,rxd2,no_bits_rcvd)
begin
if rst = '1' or std_logic_vector(no_bits_rcvd) = "1100" then
clk1x_enable <= '0' ;
elsif clk16x'event and clk16x = '1' then
if rxd1 = '0' and rxd2 = '1' then
clk1x_enable <= '1' ;
end if ;
end if ;
end process  ;

process (rst,clk16x,rdn,no_bits_rcvd)
begin
if rst = '1' or rdn = '0' then
data_ready <= '0' ;
elsif clk16x'event and clk16x = '1'  then
if std_logic_vector(no_bits_rcvd) = "1100" then
data_ready <= '1' ;
end if ;
end if ;
end process ;

process (rst,clk16x,clk1x_enable)
begin
if rst = '1' then
clkdiv <= "0000" ;
elsif clk16x'event and clk16x = '1' then
if clk1x_enable = '1' then
clkdiv <= clkdiv + "0001" ;
end if ;
end if ;
end process ;

clk1x <= clkdiv(3) ;

process (clk1x,rst)
begin
if rst = '1' then
rsr <= "00000000" ;
rbr <= "00000000" ;
parity <= '1' ;
framing_error <= '0' ;
parity_error <= '0' ;
elsif clk1x'event and clk1x = '1' then
if std_logic_vector(no_bits_rcvd) >= "0001" and std_logic_vector(no_bits_rcvd) <= "1001" then
rsr(0) <= rxd2 ;
rsr(7 downto 1) <= rsr(6 downto 0) ;
parity <= parity xor rsr(7) ;

elsif std_logic_vector(no_bits_rcvd) = "1010" then
rbr <= rsr ;
elsif parity = '0' then
parity_error <= '1' ;
elsif std_logic_vector(no_bits_rcvd) = "1000" and rxd2 = '0' then
framing_error <= '1' ;
end if ;
end if ;
end process ;

process (rst,clk1x,clk1x_enable,no_bits_rcvd)
begin
if rst = '1' or (std_logic_vector(no_bits_rcvd) = "1100" and clk1x_enable = '0') then
no_bits_rcvd <= "0000" ;
elsif clk1x'event and clk1x = '1' then
if clk1x_enable = '1' then
no_bits_rcvd <= no_bits_rcvd + "0001" ;
end if ;
end if ;
end process ;

dout <= std_logic_vector(rbr) when rdn = '0' else "ZZZZZZZZ" ;

end ;




