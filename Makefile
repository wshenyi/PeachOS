
run: compile
	qemu-system-x86_64 boot.bin

compile:
	nasm -f bin boot.asm -o boot.bin