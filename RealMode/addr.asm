; ORG 0x7c00

mov ah, 0x0e

mov al, message ; the label is just an offset. that's why we need to declare org in the beginning
int 0x10

mov al, [message]
int 0x10

mov bx, message
add bx, 0x7c00
mov al, [bx]
int 0x10

mov bx, 0x7c00
mov al, [0x7c1f] ; address in little endian
int 0x10

jmp $ ; Jump to the current address (i.e. forever)

message: db 'X'

times 510-($ - $$) db 0
dw 0xAA55