SOURCE=boot.asm
NAME=$(basename ${SOURCE})

all: run

run: compile message
	qemu-system-x86_64 -hda ${NAME}.bin

compile:
	nasm -f bin ${NAME}.asm -o ${NAME}.bin

message: compile
	dd if=./message.txt >> ./${NAME}.bin
	dd if=/dev/zero bs=512 count=1 >> ./${NAME}.bin
