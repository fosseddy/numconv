#!/bin/bash

set -xe

nasm -f elf64 -g numconv.asm

for f in ./include/*.asm
do
    nasm -f elf64 -g $f
done

ld -o numconv numconv.o include/*.o

rm numconv.o include/*.o
