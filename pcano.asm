clear:
	mov ah, 00h  ; clears the screen and sets the cursor to the first position on the screen
	mov al, 03h
	int 10h
	mov ah, 02h
	mov dl, 0
	int 10h

input:              ; takes user input
	in al, 60h
	cmp al, 44
	je clear
	cmp al, 18
	je lower
	cmp al, 16
	je upper
	cmp al, 17
	je middle
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


lower:            ; lower the note later
	mov cl, 1 
	jmp input

middle:           ; set note to normal pitch
	mov cl, 0
	jmp input

upper:            ; raise the note later
	mov cl, 2
	jmp input

seta:
	mov bx, 4560 
	mov al, 'C'
	jmp playnote

sets: 
	mov bx, 4063	
	mov al, 'D'
	jmp playnote

setd:
	mov bx, 3619
	mov al, 'E'
	jmp playnote

setf:
	mov bx, 3416
	mov al, 'F'
	jmp playnote

setj:
	mov bx, 3043
	mov al, 'G'
	jmp playnote

setk:
	mov bx, 2711
	mov al, 'A'
	jmp playnote

setl:
	mov bx, 2415
	mov al, 'B'
	jmp playnote

setcolon:
	mov bx, 2280
	mov al, 'C'
	jmp playnote

octhigh:         ; raises the note by an octave
	xor dl, dl
	mov ax, bx
	mov bx, 2
	div bx
	mov bx, ax
	mov al, '5'
	jmp portnote	

octlow:         ; lowers the note by an octave
	mov ax, 2
	mul bx
	mov bx, ax
	mov al, '3'
	jmp portnote
	
	
playnote:
	mov ah, 0x0e ; prints the char in al
	int 10h

	mov al, 182 
	out 43h, al	
		
	cmp cl, 2    ; if certain keys were pressed, changes the pitch of the note
	je octlow
	cmp cl, 1
	je octhigh
	mov al, '4'
portnote:
	mov ah, 0x0e ; prints the octave number
	int 10h

	mov ax, bx   ; plays the note
	out 42h, al
	mov al, ah
	out 42h, al
	in al, 61h
	or al, 00000011b
	out 61h, al

	in al, 60h   ; makes it so the note stops when the key is released
	mov dl, al
waitforrelease:
	in al, 60h
	cmp al, dl
	jne stopnote
	jmp waitforrelease

stopnote:            ; turns off the speaker
	in al, 61h
	and al, 11111100b
	out 61h, al
	jmp input

times 510 - ($-$$) db 0 ; bootsector magic number
dw 0xaa55
