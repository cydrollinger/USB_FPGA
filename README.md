![ER_LOGO](/Docs/github.png)

> Electronic Realization L.L.C.								  
> Design: Open Hardware Source   USB Configurable Field Programmable Gate Array  	  
>						USB_FPGA board				   
> License: TAPR - http://www.tapr.org/OHL						   
> Engineer: Cy Drollinger								   
> Date: June 26th, 2012								           
> Email: cy@elec-real.com								   
> Address: 2023 Stadium Dr Suite 2B #210 Bozeman, MT 59715				   
> Phone: 406-539-8117									   

**NOTE:**
 This design has been tested and functions as specified. The design is provided gratis, so, please 
 think critically while utilizing and or redesigning. Open electronic circuitry can be dangerous due 
 to easily shorting circuits which generates immediate and intense heat resulting in fire. Conversation is
 welcome to improve this design and repository, but, be advised ER is a professional design house and
 monetary compensation is required for additional work toward this design enabling your success.			   
	 
![USB_FPGA](/IMG_0864.JPG)

**PURPOSE:**

>**File Arcitecture with a terse description**

* FOLDERS:
	* CDM 2.04.16 WHQL Certified (FTDI.com)
		* WINXP drivers necessary to implement USB configuration of the FPGA (older)
	* CDM 2.04.16 WHQL Certified (FTDI.com)
		* WINXP drivers necessary to implement USB configuration of the FPGA (newer)
	
	* USB_CMD/USB_FPGA: - batch files converting a text document of VHDL into a binary for programming the XC3S250E
		* bin
		* clean
		* clean
		* done_100e.bin
		* done_250e.bin
		* fpga
		* fpga
		* generate
		* generate_100e
		* make
		* make_100e
		* readme
		
	* DOCS/USB_FPGA:
		* may 27 - The goals at the start of the design and the resources utilized 
		* pcb_prob_soulutions - keeping track of flaws and there solutions
		* pds_3an - documentation of the power distribution system designed for the FPGA
		* usb power design - caluculations utilized for the resistor dividers for the LTC3544
	* EAGLE/USB_FPGA:
		* LIBRARY - eagle library files of the electronic parts used in the design
		* eagle.epf - the configuration file of Eaagle Cadsoft for the USB FPGA Open source hardware
		* usb_fpga.sch - Schematic file	
		* usbfpga.brd - board file
		* USB_FPGA.cam - the cam job configuration used to create the gerbers from Eagle 5.10.
	* LICENSE:
		* TAPR_Ope_Hardware_License_v1.0.odt
		* TAPR_Ope_Hardware_License_v1.0.pdf
		* TAPR_Ope_Hardware_License_v1.0.txt
	* MANUFACTURING/USB_FPGA:
		* BOARD ASSEMBLY - files for mounting of the components by automation
		* GERBER - board house files that are available at https://oshpark.com/shared_projects/*XIW354rK
		* PARTS  - order documents for digikey to make a kit for order
	* VHDL/USB_FPGA:
		* FPGA - project files for a 32 bit counter with an upper level 8 bits connected to the LEDS
		* TEST_CPLD - The project files within Xilinx ISE to program the CPLD for slave parallel programming
			    * of the FPGA through the USB via the FT245R.  
	
