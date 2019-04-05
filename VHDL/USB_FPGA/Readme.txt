********************************************************************************************
* Electronic Realization L.L.C.								   *
* Design: Open Hardware Source   USB Configurable Field Programmable Gate Array  	   *
*						USB_FPGA board				   *
* License: TAPR - http://www.tapr.org/OHL						   *
* Engineer: Cy Drollinger								   *
* Date: June 26th, 2012								           *
* Email: cy@elec-real.com								   *
* Address: 313 W. mendenhall #5 Bozeman, MT 59715					   *
* Phone: 406-586-5502									   *
********************************************************************************************

*******************************************
*File Arcitecture with a small description*
*******************************************

FOLDERS:
	VHDL
		FPGA - project files for a 32 bit counter with an upper level 8 bits connected to the LEDS
		TEST_CPLD - The project files within Xilinx ISE to program the CPLD for slave parallel programming
			    of the FPGA through the USB via the FT245R.  
	
		These files are available to provide a starting point for better control of the CPLD in order to 
		provide more functionality of the open source hardware. These files were created in the Xilins ISE 
		environment in order to program the CPLD through Xilinx's Platform cable USB II JTAG programmer.