all:
	nasm -fbin pcano.asm -o pcano.img

run:
	qemu-system-x86_64 pcano.img -soundhw pcspk
