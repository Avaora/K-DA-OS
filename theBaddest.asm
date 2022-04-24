start:
	call sgmnt.setDSgmnt
	call screen.setVRAM
	call screen.setVideoMode
	call screen.clearVRAM
	call screen.setColor
	
	mov si,msg
	call screen.printString
	jmp $

sgmnt:
	.setDSgmnt:
		mov ax,0x60
		mov ds,ax
		ret

screen:	
	.setVideoMode:
		mov ah,00
		mov al,03
		int 10h
		ret
	.setVRAM:
		mov ax,0xb800
		mov es,ax
		mov bx,0000
		ret
	.setColor:
		mov bx,0001
		mov cx,2000
		mov ah,0x0d
		.lp1:
			mov [es:bx],ah
			add bx,2
			loop .lp1
		ret
	.clearVRAM:
		mov bx,0000
		mov cx,2000
		.lb2:
			mov [es:bx],byte 00
			add bx,2
			loop .lb2
		ret
	
	.printString:
		mov bx,0000
		.lp3:
			lodsb
			mov [es:bx],al
			add bx,2
			cmp al,0
			jne .lp3
		ret
msg db "Kernel Yuklendi",0
db 512-$ dup 0