start:
	mov ax,0x0090
	mov ss,ax
	mov ax,4096
	mov sp,ax
	call sgmnt.setDSgmnt
	call screen.setVRAM
	call screen.setVideoMode
	call screen.clearVRAM
	call screen.setColor
	
	
	mov si,msg
	call screen.initialize
	
	mov ah,02 ;fonksiyon numarası
	mov al,1 ;toplam okunacak sector sayısı
	mov ch,0 ;cylinder numarası
	mov cl,2 ;sector numarası
	mov dh,0 ;head numarası
	mov dl,0 ;drive numarası
	mov bx,0x60
	mov es,bx
	mov bx,0
	int 13h
	jmp 0x0060:0

sgmnt:
	.setDSgmnt:
		mov ax,0x07c0
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
	.initialize:
		call screen.printString
		ret
	
msg db "K/DA OS Baslatiliyor",0	
db 510-$ dup 0
dw 0xaa55
