********************************************************************************************************************************************
Readme File for UARTs Customer Pack

Created: 4/14/00 ALS
Revised: 12/11/00 JLJ (Updated to XPLA3)

********************************************************************************************************************************************
********************************************************************************************************************************************
DISCLAIMER
********************************************************************************************************************************************

THIS DESIGN IS PROVIDED TO YOU "AS IS". XILINX MAKES AND YOU RECEIVE NO WARRANTIES OR CONDITIONS, EXPRESS, IMPLIED,  STATUTORY OR OTHERWISE, AND XILINX SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. This design has not been verified on hardware (as opposed to simulations), and it should be used only as an example design, not as a fully functional core. XILINX does not warrant the performance, functionality, or operation of this Design will meet your requirements, or that the operation of the Design will be uninterrupted or error free, or that defects in the Design will be corrected. Furthermore, XILINX does not warrant or make any representations regarding use or the results of the use of the Design in terms of correctness, accuracy, reliability or otherwise. 

********************************************************************************************************************************************
File Contents
********************************************************************************************************************************************
This zip file contains the following folders:

	\vhdl_source		-- Source VHDL files:
					uart.vhd 	- top level file
					txmit.vhd	- transmit portion of uart
					rcvr.vhd	- 	- receive portion of uart

\vhdl_testfixture		-- VHDL Testbench files. This files only include the testbench behavior, they
				  	 do not instantiate the DUT. This can easily be done in a top-level VHDL 
				   	 file or a schematic. This folder contains the following files:

					txmit_tb.vhd		-- Test bench for txmit.vhd.

					rcvr_tf.vhd		-- Test bench for rcvr.vhd.

********************************************************************************************************************************************
Design Notes
********************************************************************************************************************************************
The UART design was designed from a standard uart function with a read/write microprocessor interface.  It includes  standard framing error, parity control and  overrun detection.  Complete documentation for the design can be found in 
XAPP341 available for download from the Xilinx website.


This design is targeted to the XCR3128XL-7VQ100C CoolRunner XPLA3 CPLD. This is a 3V, 128 macrocell device in a 100 VQFP package. The fitter was allowed to pick the pin-out for the device. 

Please also note that this design has been verified through simulations, but not on actual hardware.

********************************************************************************************************************************************
Technical Support
********************************************************************************************************************************************
Technical support for this design and any other CoolRunner CPLD issues can be obtained as follows:

North American Support
(Mon,Tues,Wed,Fri 6:30am-5pm  
  Thr 6:30am - 4:00pm Pacific Standard Time)
Hotline: 1-800-255-7778 
or (408) 879-5199 
Fax: (408) 879-4442 
Email: hotline@xilinx.com 
 
United Kingdom Support
(Mon,Tues,Wed,Thr 9:00am-12:00pm, 1:00-5:30pm
  Fri 9:00am-12:00pm, 1:00-3:30pm)    
Hotline: +44 1932 820821
Fax: +44 1932 828522 
Email : ukhelp@xilinx.com 
 
France Support
(Mon,Tues,Wed,Thr,Fri 9:30am-12:30pm, 2:00-5:30pm)
Hotline: +33 1 3463 0100 
Fax: +33 1 3463 0959
Email : frhelp@xilinx.com 
 
Germany Support
(Mon,Tues,Wed,Thr 8:00am-12:00pm, 1:00-5:00pm, 
   Fri  8:00am-12:00pm, 1:00pm-3:00pm)
Hotline: +49 89 991 54930 
Fax: +49 89 904 4748 
Email : dlhelp@xilinx.com 
 
Japan Support
(Mon,Tues,Thu,Fri  9:00am -5:00pm ()
 Wed    9:00am -4:00pm)
Hotline: (81)3-3297-9163
Fax:: (81)3-3297-0067
Email: jhotline@xilinx.com
