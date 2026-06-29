# Simple NASM Bootloader (x86 16-bit)

A minimal bootloader written in NASM that runs in real mode (BIOS) and prints text using `int 0x10`.

This project is for learning:
- x86 real mode
- BIOS interrupts
- Boot process (MBR)
- Low-level assembly basics

---

## Features

- Boots from MBR (512 bytes)
- Runs in 16-bit real mode
- Uses BIOS video interrupt (`int 0x10`)
- Prints a string on screen
- Infinite loop after execution

---

## Requirements

- NASM (assembler)
- QEMU (emulator)

---

## Installation

### Arch Linux

```bash
sudo pacman -Syu
sudo pacman -S nasm qemu-base qemu-system-x86
```

> If QEMU mirror issues happen:

```bash
sudo pacman -Syy
sudo pacman -S reflector
sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu
```

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install nasm qemu-system-x86
```

### Fedora

```bash
sudo dnf install nasm qemu-system-x86
```

---

## Build & Run

### 1. Assemble bootloader

```bash
nasm -f bin boot.asm -o boot.bin
```

### 2. Create bootable image

```bash
dd if=boot.bin of=boot.img bs=512 count=1
```

### 3. Run in QEMU (i386)

**GUI mode (recommended)**

```bash
qemu-system-i386 -drive format=raw,file=boot.img -display gtk
```

**Alternative display**

```bash
qemu-system-i386 -drive format=raw,file=boot.img -display sdl
```

**VNC mode (headless)**

```bash
qemu-system-i386 -drive format=raw,file=boot.img
```

Then connect:

```bash
vncviewer localhost:5900
```

---

## Expected Output

```
Hello there welcome to pc
```

---

## File Structure

```
bootloader/
├── boot.asm
├── boot.bin        (generated)
├── boot.img        (generated)
└── README.md
```

---

## How It Works

1. BIOS loads the boot sector at memory address `0x7C00`
2. CPU enters 16-bit real mode
3. Execution starts from the beginning of the bootloader
4. Each character is printed using:
   - `mov ah, 0x0e`
   - `int 0x10`
5. An infinite loop keeps the system alive after printing
