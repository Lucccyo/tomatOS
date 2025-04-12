ORG 0x7c00              ; set the origin address memory where the BIOS loads the
                          ; bootloader
BITS 16                 ; specify 16 bits mode

start:
    mov ah, 0eh         ; set the BIOS as output mode
    mov al, 'A'         ; set `A` as character to print
    mov bx, 0           ; set the page number to 0
    int 0x10            ; call the BIOS interrupt 0x10 to display AL on the
                          ; screen

    jmp $               ; infinite loop, halt the execution

times 510-($ - $$) db 0 ; fill the remanining space with zeros to ensure the
                          ; bootloader is 512 bytes
dw 0xAA55               ; signature at the end of the 512 bytes for the BIOS to
                          ; recognise it as a bootable sector
