#!/bin/bash

set -xe

nasm -f elf64 -g numconv.asm

nasm -f elf64 -g include/std.asm
nasm -f elf64 -g include/io.asm
nasm -f elf64 -g include/string.asm
nasm -f elf64 -g include/strconv.asm

ld -o numconv numconv.o include/std.o include/io.o include/string.o include/strconv.o

rm numconv.o include/*.o

gdb numconv
