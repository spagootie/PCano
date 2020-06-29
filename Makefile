all:
	nasm -fbin sound.asm -o sound.bin

run:
	qemu-system-x86_64 sound.bin -soundhw pcspk
