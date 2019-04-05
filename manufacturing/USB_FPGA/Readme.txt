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
	
	MANUFACTURING
		BOARD ASSEMBLY - files for mounting of the components by automation
		GERBER - board house files that are available at http://batchpcb.com/index.php/Products/88736
		PARTS  - order documents for digikey to make a kit for order
	
	These file contain the sum total of the design output, which are necessary to manufacture in quantity.
	The gerbers go to the board house. The digikey.xls can be used to automate a complete order from Digikey.
	The mill.cnc file is utilized by the board assembly manufacturer to place the parts to board.  