ORG 0
BITS 16

jmp 0x7c0:start

start:
    jmp short step1
    nop

times 33 db 0 

step1:
    jmp 0x7c0:step2

step2:
    cli ; CLear Interrupts
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x5c00
    sti ; Enable Interrupts

    mov ah, 0x2 ; 
    mov al, 0x1 ;
    mov ch, 0x0 ;
    mov cl, 0x2 ;
    mov dh, 0x0 ;
    mov bx, buffer
    int 0x13
    jc error
    mov si, buffer
    call print
    jmp $

error:
    mov si, error_message
    call print
    jmp $

print:
    mov ah, 0x0e ; indicate tele-type(tty) mode
    mov bx, 0
.loop:
    lodsb ; load byte into register AL. 'b' stands for byte 
    cmp al, 0
    je .done
    int 0x10 ; call display interrupt
    jmp .loop
.done:
    ret

error_message: db "Fail to load sector!", 0

times 510-($ - $$) db 0
dw 0xAA55

buffer: 
    ; db "Successfully load sector!", 0
