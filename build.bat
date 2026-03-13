@echo off
:: just for testing
set objects=loader.o kmain.o io.o fb.o serial.o gdt.o gdt_asm.o idt.o idt_asm.o keyboard.o shell.o snake.o
set asflags=-f elf
set cflags=-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
set ldflags=-T link.ld -melf_i386
i686-elf-gcc
if %errorlevel%==9009 (
  echo install i686-elf-tools
  goto :A
) else if %errorlevel%==1 (
  for %a in ( "*.c" ) do (
    i686-elf-gcc %cflags% %a -o %~na.o
  )
)
:A
nasm
if %errorlevel%==9009 (
  echo install nasm
  goto :B
) else if %errorlevel%==1 (
  for %a in ( "*.asm" ) do (
    nasm %asflags% %a -o %a~na.o
  )
)
i686-elf-ld %ldflags% %objects% -o kernel.elf
:B
qemu-system-x86_64 -kernel kernel.elf
if %errorlevel%==9009 (
  echo install qemu
  exit /b 1
)
del /s /q *.o
