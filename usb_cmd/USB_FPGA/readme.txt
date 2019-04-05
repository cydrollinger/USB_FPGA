********************************************************************************************
* Electronic Realization L.L.C.								   *
* Design: Open Hardware Source   USB Configurable Field Programmable Gate Array  	   *
*						USB_FPGA board				   *
* License: TAPR - http://www.tapr.org/OHL						   *
* Engineer: Cy Drollinger								   *
* Date: October 7, 2009									   *
* Email: cy@elec-real.com								   *
* Address: 313 W. mendenhall #5 Bozeman, MT 59715					   *
* Phone: 406-586-5502									   *
********************************************************************************************


1. 	Add the USB device driver, WINXP, for the FTDI FT245R. Folder CDM 2.04.16 WHQL 
	certified included in this directory, or root dircetory of this storage media.

2. 	Plug USB_FPGA into the USB port with miniB connection. WINXP assigns a com port to 
	the USB_FGPA board  

3. 	Run a dos prompt command window: usb_command directory needs to opened and the files
	need to be acessable from the command >dir
	
	Directory of XXXXXXXXXXXXXXXX "wherever the folder is being utilized"
	
	xx/xx/xx	xx:xx xx	<DIR>		.
	xx/xx/xx	xx:xx xx	<DIR>		..
	xx/xx/xx	xx:xx xx		       44 bin
	xx/xx/xx	xx:xx xx		      112 clean.bat
	xx/xx/xx	xx:xx xx		       95 clean.txt
	xx/xx/xx	xx:xx xx		   72,668 done_100e.bin
	xx/xx/xx	xx:xx xx		  169,216 done_250e.bin
	xx/xx/xx	xx:xx xx		    1,314 fpga.ucf
	xx/xx/xx	xx:xx xx		    1,474 fpga.vhd
	xx/xx/xx	xx:xx xx		      659 generate.bat
	xx/xx/xx	xx:xx xx		      659 generate_100e.bat
	xx/xx/xx	xx:xx xx		      659 make.txt
	xx/xx/xx	xx:xx xx		      659 make_100e.txt
		          11 File(s)		  247,559 bytes
 			   2 Dir(s)            xxxxxxxxxx bytes free
	XXXXXXXX>

4. 	Copy done_250e.bin file onto the USB port thrugh the Xcom port with command line:
	
	XXXXXXXX>copy done_250e.bin comX
		
		IF the windows has assigned a com port greater than 9 say 10 than
	
	XXXXXXXX>copy done_250e.bin \\.\com10
		
		must include the \\.\ before the appropriate port comXX 

***********
* Results *
***********

The FPGA, a Xilinx Spartan 3E XC3S250E VQ100, has been configured with the bin file, done_250e.bin, 
via the slave parallel mode utilizing the driver from FTDI through the FT245R chip and the CPLD,
Xilinx XC264A VQ100. The result has been the upper 8 bits of a 26 bit counter being output to eight
leds on the USB_FPGA board.

***************
* Development *
***************
An excellent tutorial for this process was written in February's issue of Nuts and Volts 2009,
titled, "FPGA at the Command Line".
	http://nutsvolts.texterity.com/nutsvolts/200902/#pg1


The batch files can be utilized to create any bin file useful to operate the USB_FPGA board.
	Xilinx web pack must be installed onto the PC for the generate file to call each program.
		XST
		ngdbuild
		map
		etc.

	********
	* JTAG *
	********
		Pin 6 TMS
		Pin 5 TDI
		Pin 4 TDP
		Pin 3 TCK
		Pin 2 GND
		PIN 1 VREF

