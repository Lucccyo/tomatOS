[ORG 0x7c00]
[BITS 16] ; generate code for real mode

CODE_OFFSET equ 0x8 ; offset of code segment
DATA_OFFSET equ 0x10 ; offset of data segment

start:
  cli ; clear interrupts
  mov ax, 0x7c0
  mov ds, ax
  mov es, ax
  mov ax, 0x00
  mov ss, ax
  mov sp, 0x7c00
  sti ; enables interrupts

load_PM:
  cli
  lgdt[gdt_descriptor]
  mov eax, cr0  ; load control register `cr0` in eax
  or al, 1      ; set the first bit of `cr0` to 1 -> enables protected mode
  mov cr0, eax
  jmp CODE_OFFSET:PModeMain

;GDT Implementation
gdt_start:
  dd 0x0
  dd 0x0

  ; Code segment descriptor -> 0x8
  dw 0xFFFF    ;Limit
  dw 0x0000    ;Base
  db 0x00      ;Base
  db 10011010b ;Access byte (P, DPL, ...)
  db 11001111b ;Flags
  db 0x00      ;Base

  ; Data segment descriptor -> 0x10
  dw 0xFFFF    ;Limit
  dw 0x0000    ;Base
  db 0x00      ;Base
  db 10010010b ;Access byte (P, DPL, ...)
  db 11001111b ;Flags
  db 0x00      ;Base

gdt_end:

gdt_descriptor:
  dw gdt_end - gdt_start - 1 ; Size of GDT -1
  dd gdt_start

[BITS 32] ; generate code for protected mode
PModeMain:
  mov ax, DATA_OFFSET
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov ss, ax
  mov gs, ax
  mov ebp, 0x9c00 ;address far enough for the stack to not overflow on the bootloader
  mov esp, ebp

  in al, 0x92
  or al, 2
  out 0x92, al
  jmp $

times 510-($ - $$) db 0
dw 0xAA55