ORG 0x7c00
BITS 16

start:
  mov ax, 0
  mov ds, ax                          ; set DS to 0 to ensure correct addressing of
                                        ; the message next line
  mov si, message                     ; load the address of the message in `si`
  call print
  jmp $

print:
  mov bx, 0                           ; set the page number to 0
.loop:
  lodsb                               ; copy l'element in `si` and increment the cursor
  cmp al, 0
  je .done                            ; if the current character is 0, return
  call print_char                     ; else print the char
  jmp .loop
.done:
  ret

print_char:
  mov ah, 0eh
  int 0x10
  ret

message: db "C'est le printemps !", 0 ; set the message, 0 means the end of it

times 510-($ - $$) db 0
dw 0xAA55