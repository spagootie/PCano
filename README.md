# PCano
A simple bootsector program that uses the PC speaker to create notes



RUNNING:

Qemu:

Open a terminal emulator and run the following command:
```
qemu-system-x86-64 pcano.img -soundhw pcspk
```

DOSBox: 

Open DOSBox and boot the image with the following:

```
boot pcano.img
```

USAGE:

Use the keys a, s, d, f, j, k, l, and ; to play notes. 

Use the keys q, w, and e to change between three different octaves.

the Star Wars theme is a, j, f, d, s, ;, j, f, d, s, ;, j, f, d, f, s.

ASSEMBLING:

Use an intel-syntax assembler, preferably NASM, to assemble to raw binary format.
For Linux users, this involves running:

```
nasm -fbin pcano.asm -o pcano.img
```


