# TomatOS

## Commands
`$ nasm -f bin ./boot.asm -o ./boot.bin` to compile the `boot.asm` into binary file.
`$ ndisasm boot.bin` prints a disassembly listing of the binary file infile.
`$ qemu-system-x86_64 -hda boot` to execute a virtual machine x86-64 using `boot` as hard disk.

## Protection ring
It exists mechanisms that protects data from faults and malicious behaviours, with differents level of privileges.

```
++ Kernel
+  Device drivers
-  Device drivers
-- Applications
```

## Bootloader
The computer starts in `reel mode`, the initial state of an x86 processor. This is a restricted mode (only 16 bits) where the memory is addressed without protection. It is used at the start of the BIOS to execute the `bootloader`.
A `bootloader` is the first program loaded by the BIOS at startup to initialise devices and load the operating system. It configures the registers, the stack, or the displays, loads the kernel and stores it in memory, and finally switches to `protect mode` (32 bits) or `long mode` (64 bits) and gives it the controls.

The memory is accessed by a segment and an offset,
- CS Code Segment
- SS Stack Segment
- DS Data Segment
- ES Extra Segment

### Implementing Global Descriptor Table (GDT)

GDT is a datastructure used to define caracteristics of the memory segments and their use in the system.
It defines how the memory segments are organised in the processor, it teaches the processor how to interpret the memory addresses
It is 8 bytes long and contains:
- base: address where the segment begins
- limit: maximum address (<=> the size of the segment)
- flags: defines granularity flags and tells how limits should be interpreted.
- access byte: has its own structure and describes various elements in one code:
```
  _   _ _   _   _    _   _    _
| P | DPL | S | E | DC | RW | A |
```
  - P: `Present bit` -> if the segment is present in memory
  - DPL: `Descriptor Privilege Level` -> CPU privilege level of the segment (from kernel to user application)
  - S: `Scriptor type bit` (define if its system segment or code or data segment)
  - E: `Executable bit` Defines if its executable (code segment) or not (data segment)
  - DC: `Direction bit` if data segment or `Conforming bit` if code segment
  - RW: `Readable bit` or `Writable bit`
  - A: `Accesses bit`, when the CPU accesses the segment, it is sets to one
Each descriptor stores an information about a specific thing (service routine, task, data, code ...).
There is three types of tables:
- Global Descriptor Table
- Local Descriptor Table
- Interrupt Descriptor Table
These tables are only placed into memory once, at boot time, and then edited later when needed.