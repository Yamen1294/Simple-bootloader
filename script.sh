#!/bin/bash

nasm -f bin bootloader.asm -o bootloader.bin
dd if=bootloader.bin of=bootloader.img bs=512 count=1
qemu-system-i386 -drive format=raw,file=bootloader.img