ORG 0
BITS 16

jmp 0x7c0:start

start:
    cli ; CLear Interrupts
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti ; Enable Interrupts

    mov si, message
    call print
    jmp $

print:
    mov ah, 0x0e
    mov bx, 0
.loop:
    lodsb ; load byte into register AL. 'b' stands for byte 
    cmp al, 0
    je .done
    int 0x10 ; call display interrupt
    jmp .loop
.done:
    ret

message: db "Hello World!", 0

times 510-($ - $$) db 0
dw 0xAA55