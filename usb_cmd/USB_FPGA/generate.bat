rem Makefile to compile and download a simple VHDL program


rem program.ngc: fpga.vhd
	echo run -ifn fpga.vhd -ifmt VHDL -ofn  program -p xc3s250e-4-vq100 -opt_mode Speed -opt_level 1 | xst

rem program.ngd: program.ngc fpga.ucf
	ngdbuild -p xc3s250e-4-vq100 -uc fpga.ucf program.ngc

rem program.ncd: fpga.ngd
	map -detail -pr b program.ngd

rem parout.ncd: program.ncd
	par program.ncd parout.ncd program.pcf

rem load_program.bit: parout.ncd
	bitgen -g StartUpClk:CClk -g CRC:Enable  parout.ncd load_program.bit program.pcf

rem load_program.bin: load_program.bit
	promgen -w -p bin -o load_program.bin -u 0 load_program.bit





