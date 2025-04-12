# TomatOS

## Commands
`$ nasm -f bin boot.asm` to compile the `boot.asm` into binary file.
`$ ndisasm boot` prints a disassembly listing of the binary file infile.
`$ qemu-system-x86_64 -hda boot` to execute a virtual machine x86-64 using `boot` as hard disk.

## Blabla
The computer starts in `reel mode`, the initial state of an x86 processor. This is a restricted mode (only 16 bits) where the memory is addressed without protection. It is used at the start of the BIOS to execute the `bootloader`.
A `bootloader` is the first program loaded by the BIOS at startup to initialise devices and load the operating system. It configures the registers, the stack, or the displays, loads the kernel and stores it in memory, and finally switches to `protect mode` (32 bits) or `long mode` (64 bits) and gives it the controls.