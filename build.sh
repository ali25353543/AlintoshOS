#!/bin/bash
objects="loader.o kmain.o io.o fb.o serial.o gdt.o gdt_s.o idt.o idt_s.o keyboard.o shell.o snake.o"
cflags="-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c"
ldflags="-T link.ld -melf_i386"
for "$a" in "*.c" do
     gcc "$cflags" "$a" -o "${%a}.o"
done
for "$a" in "*.asm" do
     nasm -f elf "$a" -o "${%a}.o"
done
ld "$ldflags" "$objects" -o kernel.elf
qemu-system-x86_64 -kernel kernel.elf
rm -rf *.o
