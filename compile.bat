REM sccz80
SET PATH=c:\z88dk199b;c:\z88dk199b\bin;c:\z88dk199b\lib\;c:\z88dk199b\lib\clibs;c:\z88dk199b\lib\config;C:\Program Files\SDCC\bin 


cls

cd gfx
	apack c screen1.scr screen1.bin
	apack c screen2.scr screen2.bin
	apack c screen3.scr screen3.bin
	apack c screen4.scr screen4.bin
	apack c screen5.scr screen5.bin
	apack c screen6.scr screen6.bin
	move "*.bin" "..\"
cd ..



cd utils
	call loader.bat
	copy "loader.tap" "..\"
	copy "bin2tap.exe" "..\"
	copy /b loader.tap + loadscreen.tap + bank.tap
cd ..



rem BUILD CONSOLIDATED OBJECT FILE
zcc +zx -v -c -clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size --fsigned-char -o objects @zproject.lst

zcc +zx -v -m -zorg=24450 -startup=31 -clib=sdcc_iy objects.o  -o compiled -pragma-include:zpragma.inc

@rem zcc +zx -vn -m -startup=31 -clib=sdcc_iy -SO3 --max-allocs-per-node200000 @zproject.lst -pragma-include:zpragma.inc -o test.bin


@rem bin2tap -o bank06.tap -a 49152 pietro_bros_BANK_06.bin
appmake +zx -b compiled_BANK_06.bin -o bank06.tap --org 49152 --noloader


@rem bin2tap -o lowRAM.tap -a 24450 pietro_bros_CODE.bin
appmake +zx -b compiled_CODE.bin -o lowRAM.tap --org 24450 --noloader


copy /b loader.tap+bank06.tap+lowRAM.tap  output.tap

echo off

@rem  test_CODE.bin  REM BINARY to launch
del zcc_proj.lst
del screen1.bin
del screen2.bin
del screen3.bin
del screen4.bin
del screen5.bin
del screen6.bin
del zcc_opt.def

del loader.tap
del lowRAM.tap
del bank06.tap
del compiled
del compiled_BANK_06.bin
del compiled_CODE.bin
del objects.o

move compiled.map /maps