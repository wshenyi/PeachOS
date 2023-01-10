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

    mov word[ss:0x00], handle_zero
    mov word[ss:0x02], cs
    
    int 0x0   ; Method 1: directly call interrupt handle_zero
    mov ax, 0
    div ax    ; Method 2: trigger exception to call handle_zero
    
    jmp $

handle_zero:
    mov si, message
    call print
    iret

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

message: db "Process divide 0 exception!", 0

times 510-($ - $$) db 0
dw 0xAA55