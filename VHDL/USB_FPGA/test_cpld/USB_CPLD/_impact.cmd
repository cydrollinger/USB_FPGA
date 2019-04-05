setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref UserLevel:NOVICE
setPreference -pref svfUseTime:FALSE
setMode -bs
setMode -bs
setCable -port auto
Identify 
identifyMPM 
assignFile -p 1 -file "C:/work/USB_FPGA/VHDL/USB_FPGA/test_cpld/USB_CPLD/CPLD.jed"
assignFile -p 2 -file "C:/Documents and Settings/Cy Drollinger/My Documents/work/Xilinx/USB_FPGA_jtagloader/USB_FPGA_jtagloader/USB_FPGA/usb_fpga.bit"
Program -p 1 -e -defaultVersion 0 
Program -p 2 -defaultVersion 0 
Program -p 2 -defaultVersion 0 
Program -p 1 -e -defaultVersion 0 
Program -p 1 -e -defaultVersion 0 
Program -p 1 -e -defaultVersion 0 
Program -p 2 -defaultVersion 0 
Program -p 1 -e -defaultVersion 0 
Program -p 2 -defaultVersion 0 
Program -p 1 -e -defaultVersion 0 
Program -p 2 -defaultVersion 0 
