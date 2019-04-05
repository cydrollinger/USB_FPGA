--    File Name:  txmit.vhd
--      Version:  1.1
--         Date:  January 22, 2000
--        Model:  Transmitter Chip
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

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;

entity txmit is
port (rst,clk16x,wrn : in std_logic ;
	din : in std_logic_vector(7 downto 0) ;
	tbre : out std_logic ;
	tsre : out std_logic ;
	sdo  : out std_logic 
) ;
end txmit ;

architecture v1 of txmit is

signal clk1x_enable : std_logic ;
signal tsr : std_logic_vector (7 downto 0) ;
signal tbr : std_logic_vector (7 downto 0) ;
signal parity :  std_logic ;
signal clkdiv :  unsigned (3 downto 0) ;
signal clk1x :  std_logic ;
signal no_bits_sent :  unsigned (3 downto 0) ;
signal wrn1 :  std_logic ;
signal wrn2 :  std_logic ;

begin

process (rst,clk16x)
begin
if rst = '1' then
wrn1 <= '1' ;
wrn2 <= '1' ;
elsif clk16x'event and clk16x = '1' then
wrn2 <= wrn1 ;
wrn1 <= wrn ;
end if ;
end process ;


process (rst,clk16x)
begin
if rst = '1' then
clk1x_enable <= '0' ;
tbre <= '0' ;
elsif clk16x'event and clk16x = '1' then
if wrn1 = '0' and wrn2 = '1' then 
tbre <= '0' ;
clk1x_enable <= '1' ;
elsif std_logic_vector(no_bits_sent) = "0010" then
tbre <= '1' ;
elsif std_logic_vector(no_bits_sent) = "1101" then
clk1x_enable <= '0' ;
end if ;
end if ;
end process ;

process (rst,wrn)
begin
if rst = '1' then
tbr <= (others => '0') ;
elsif wrn'event and wrn = '0' then
tbr <= din ;
end if ;
end process ;

process (rst,clk16x,clk1x_enable)
begin
if rst = '1' then
clkdiv <=  "0000" ;
elsif clk16x'event and clk16x = '1' then
if clk1x_enable = '1' then
clkdiv <= clkdiv + "0001" ;
end if ;
end if ;
end process ;

clk1x <= clkdiv(3) ;

process (rst,clk1x,no_bits_sent,tbr)
begin
if rst = '1' then 
sdo <= '1' ;
tsre <= '1' ;
tsr <= "00000000" ;
parity <= '1' ;
elsif clk1x'event and clk1x = '1' then
if std_logic_vector(no_bits_sent) = "0001" then
tsr <= tbr ;
tsre <= '0' ;
elsif std_logic_vector(no_bits_sent) = "0010" then
sdo <= '0' ;
elsif std_logic_vector(no_bits_sent) >= "0011" and std_logic_vector(no_bits_sent) <= "1010" then
tsr <= tsr(6 downto 0) & '0' ;
sdo <= tsr(7) ;
parity <= parity xor tsr(7) ;
end if ;
end if ;
end process ;


process (rst,clk1x,clk1x_enable)
begin
if rst = '1' or clk1x_enable = '0' then
no_bits_sent <= "0000" ;
elsif clk1x'event and clk1x = '1' then
if clk1x_enable = '1' then
no_bits_sent <= no_bits_sent + "0001" ;
end if ;
end if ;
end process ;

end ;

 


