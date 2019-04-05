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
			--Master clock oscillator 50 MHz CTS - CB3
		mclk : in  STD_LOGIC;										--pin 22
		mclk_ce : out  STD_LOGIC;									--pin 70 Logic '0' MCLK high imp. logic '1' MCLK 50 MHz pdf clk_osc
			--Xilinx Spartan 3E VQ100 mode and variant
		Variant : out  STD_LOGIC_VECTOR (2 downto 0);		--pin 34, 33, 30
		Mode : out  STD_LOGIC_VECTOR (2 downto 0);			--pin 42, 39, 36
			--Xilinx Spartan 3E VQ100 
		FPGA_MOSI : out  STD_LOGIC;								--pin 90 this is also CSI_B
--		FPGA_BUSY : in  STD_LOGIC;									--pin 91 if clk is less than 50 MHz than not necessary DS312 pg. 95
		FPGA_INITB : in  STD_LOGIC;								--pin 92
		FPGA_CSO_B : inout STD_LOGIC;								--pin 94
		FPGA_cclk	: out	STD_LOGIC:='0';						--pin 27			  
--		FPGA_done : inout  STD_LOGIC;								--pin 28
		FPGA_prog_B: inout STD_LOGIC;								--pin 99
--		FPGA_HSWAP: out STD_LOGIC;									--pin 24
		FPGA_D: inout STD_LOGIC_VECTOR(7 downto 0);			--pin 89 81 79 78 77 41 40 35

			--Numonyx M25P16
		SPI_flash_HOLD : out  STD_LOGIC;							--pin 76 SPI '1'
		SPI_flash_W : out  STD_LOGIC;								--pin 97	SPI '1'
			--FTDI FT245RL USB to parallel output
--		usb_pwren : inout  STD_LOGIC;								--pin 43
--		usb_wr : in  STD_LOGIC;										--pin 49
		usb_rd : inout STD_LOGIC;									--pin 50
		data : inout  STD_LOGIC_VECTOR (7 downto 0);				--pin 56 53 55 61 52 60 58 64 
--		usb_tx : in  STD_LOGIC;										--pin 67
		usb_rx : in  STD_LOGIC;										--pin 68 when low data ready (FTDI RFX pin#23)
		usb_rst : inout  STD_LOGIC;								--pin 14
			--User I/O
		LEDs : out  STD_LOGIC_VECTOR (8 downto 1);			--pin 1-4 and 6-9
		SW : in 		STD_LOGIC_VECTOR (2 downto 0);			--pin 71, 72, 74 need to be debounced
		N24: inout  STD_LOGIC);										--pin 29
--		J3_2 : inout  STD_LOGIC;									--pin 10		Useable I/O onto the J3 connetion
--		J3_4 : inout  STD_LOGIC;									--pin 11		Stackable into another USB_FPGA board
--		J3_6 : inout  STD_LOGIC;									--pin 12
--		J3_8 : inout  STD_LOGIC;									--pin 13
--		J3_10 : inout  STD_LOGIC;									--pin 14
--    J3_12 : inout  STD_LOGIC;									--pin 15
--		J3_14 : inout  STD_LOGIC;									--pin 16
--		J3_16 : inout  STD_LOGIC;									--pin 17
--		J3_18 : inout  STD_LOGIC;									--pin 18
--		J3_20 : inout  STD_LOGIC;									--pin 19
			  
end CPLD;

architecture Behavioral of CPLD is

component BUFT
port (O : out STD_ULOGIC;
I : in STD_ULOGIC;
T : in STD_ULOGIC);
end component;

		--FPGA Configuration
signal SW_0_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_0_hi normally hi 
signal SW_1_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_1_hi normally hi
signal SW_2_hi			:std_logic;											--CPLD is in a all I/O pullups therefore SW_2_hi normally hi
Signal fpga_timing	: integer range 0 to 256	:=0;
Signal the_bus			:std_logic_vector (7 downto 0);
Signal bus_reg			:std_logic_vector (7 downto 0);
		
		--FTDI USB chip overhead
signal usb_dry 		:std_logic;											--signal is a synchronized and negative version of usb_rx
signal previous_usb_dry 		:std_logic;								--signal is the value of usb_dry one clk earlier
signal previous 		:std_logic;
Signal usb_timing		: integer range 0 to 256	:=5;

begin

--------------------------------------------------------------------------------------------------------------------------------------
-- Author		: Cy Drollinger
-- Date			: 7-16-09
-- Description	: synchronizing asynchronous inpoputs usb data ready line(sub_rx),  SW(0), SW(1), and SW(2)
--------------------------------------------------------------------------------------------------------------------------------------					
--SIGNAL ASSIGNMENT					
					--HARDWARE SYSTEM ON PCB								--TECHNICAL COMMENTS
--------------------------------------------------------------------------------------------------------------------------------------
--Synchronize_inputs: process(mclk)
--begin
--    if rising_edge(mclk) then
--      if usb_rx = '0' then													-- RXF# 	is an active low signal
--usb_dry <= '1';
--		else 
--usb_dry <= '0';
--		end if;
--
--previous <= usb_dry;
--previous_usb_dry <= previous;
--	
--		if SW(0) = '1' then
--SW_0_hi <= '1';
--		else 
--SW_0_hi <= '0';
--		end if;
--		
--		if SW(1) = '1' then
--SW_1_hi <= '1';
--		else 
--SW_1_hi <= '0';
--	 end if;
--	 
--	 if SW(2) = '1' then
--SW_2_hi <= '1';
--		else 
--SW_2_hi <= '0';
--	 end if;
--	end if; 
--end process;

--------------------------------------------------------------------------------------------------------------------------------------
-- Author		: Cy Drollinger
-- Date			: 7-16-09
-- Description	: Upon SW(1) going low the FGPA_prog_b pulses (ONE SHOT) high for two mclks. 
--------------------------------------------------------------------------------------------------------------------------------------					
--SIGNAL ASSIGNMENT					
					--HARDWARE SYSTEM ON PCB								--TECHNICAL COMMENTS
--------------------------------------------------------------------------------------------------------------------------------------
--pulse_prog_b: process (mclk)												--
--begin
--	if rising_edge(mclk) then
--		if SW_1_hi = '0' and FPGA_timing < 22 then
--FPGA_timing <= FPGA_timing + 1;
--			if fpga_timing > 0 and fpga_timing < 21 then 
--fpga_prog_b <= '0';
--			else 
--fpga_prog_b <= '1';															-- fpga_prog_b held low for approx. 400 ns pg 97 DS312
--			end if;
--		else 	if SW_1_hi = '1' then	
--fpga_timing <= 0;
--				end if;
--		end if;		
--	end if;
--	
--end process;

--------------------------------------------------------------------------------------------------------------------------------------
-- Author		: Cy Drollinger
-- Date			: 7-16-09
-- Description	: providing timing for usb_rd through usb_data_rdy Data sheet DSFT245R1 pg. 12 fifo read 
--------------------------------------------------------------------------------------------------------------------------------------					
--SIGNAL ASSIGNMENT					
					--HARDWARE SYSTEM ON PCB								--TECHNICAL COMMENTS
--------------------------------------------------------------------------------------------------------------------------------------
--load_fpga_slave_parallel: process(mclk)								--
--begin
--	if rising_edge(mclk) then
--			if usb_dry = '1' and previous_usb_dry ='0' then --and fpga_initb = '1' then 		
--usb_timing <= 0;
--			elsif usb_timing < 5 then
--usb_timing <= usb_timing + 1;
--			end if;
--
--	case usb_timing is
--					when 0 => 
--usb_rd <='0';
--					when 1 => 
--usb_rd <='0';
--					when 2 =>
--usb_rd <='0';
--					when 3 =>
--usb_rd <='0';
--fpga_cclk <= '1';
--					when 4 =>
--usb_rd <='1';
--fpga_cclk <= '0';
--					when others =>
--		end case;
--	end if;
--end process;

--data_bus: process(mclk)
--begin
--	if rising_edge(mclk) then
--bus_reg <= data;
--	end if;
--end process;
--
--the_bus <= "ZZZZZZZZ" when fpga_done ='1' else bus_reg;
--FPGA_d <= the_bus;
--LEDs <=  not(FPGA_d) when fpga_done = '1' else N24 & N24 & N24 & usb_rst & fpga_initb & SW_2_hi & SW_1_hi & SW_0_hi ;

--N24 <= '1' when SW_2_hi ='1' else 'Z';

--------------------------------------------------------------------------------------------------------------------------------------
-- Author		: Cy Drollinger
-- Date			: 6-18-09
-- Description	: Hardwiring the CPLD for the board configuration of the usb and fpga 
--------------------------------------------------------------------------------------------------------------------------------------					
--SIGNAL ASSIGNMENT					
					--HARDWARE SYSTEM ON PCB								--TECHNICAL COMMENTS
--------------------------------------------------------------------------------------------------------------------------------------					
																										
					--Master clock oscillator 50 MHz CTS - CB3				
mclk_ce <= '1';																--enables the 50 MHz clk					
					-- Xilinx Spartan 3E VQ100 mode and variant
--Mode <= "101";																--DS312 page 67 mode jtag
--Mode <= "111";																--DS312 page 67 mode jtag
--Mode <= "110";																	--DS312 page 67 mode Slave Parallel
--Mode <= "011";																--DS312 page 67 mode BPI down
--Mode <= "010";																--DS312 page 67 mode BPI up
Mode <= "001";																--DS312 page 67 mode SPI
--Mode <= "000";																--DS312 page 67 mode master serial
Variant <= "111";															--DS312 page 78 variant for fast read write spi flash M25P16
--Variant <= "101";																-- Read
--Variant <= "110";															--Read Array
					--Xilinx Spartan 3E Slave Parallel
--fpga_mosi <= '0';
					
					--SPI Flash Serial Mode Numonyx M25P16	Mode 001 Variant 111
fpga_mosi <= 'Z';
fpga_cclk <= 'Z';
fpga_d(0) <= 'Z';
fpga_cso_b <='Z';
LEDs <= not(fpga_d);					
--					FTDI USB PARALLEL
--usb_rst <= SW_0_hi;

end Behavioral;

