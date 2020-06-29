mov ah, 00h  ; clears the screen and makes the cursor invisible
mov al, 03h
int 10h
mov ah, 01h
mov cx, 2607h
int 10h
mov ah, 02h
mov dl, 0
int 10h

input:              ; takes user input
	in al, 60h
	cmp al, 30
	je seta
	cmp al, 31
	je sets
	cmp al, 32
	je setd
	cmp al, 33
	je setf
	cmp al, 36
	je setj
	cmp al, 37
	je setk
	cmp al, 38
	je setl
	cmp al, 39
	je setcolon
	jmp stopnote	

seta:
	mov bx, 4560 
	jmp playnote

sets: 
	mov bx, 4063	
	jmp playnote

setd:
	mov bx, 3619
	jmp playnote

setf:
	mov bx, 3416
	jmp playnote

setj:
	mov bx, 3043
	jmp playnote

setk:
	mov bx, 2711
	jmp playnote

setl:
	mov bx, 2415
	jmp playnote

setcolon:
	mov bx, 2280
	jmp playnote
	
playnote:
	mov al, 182 ; playing sounds n stuff
	out 43h, al	
	mov ax, bx
	out 42h, al
	mov al, ah
	out 42h, al
	in al, 61h
	or al, 00000011b
	out 61h, al

	in al, 60   ; makes it so the note stops when the key is released
	mov dl, al
waitforrelease:
	in al, 60h
	cmp al, dl
	jne stopnote
	jmp waitforrelease

stopnote:
	in al, 61h
	and al, 11111100b
	out 61h, al
	jmp input

times 510 - ($-$$) db 0 ; bootsector magic number
dw 0xaa55
