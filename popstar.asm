include '/Users/korra/fasmlib/80386.inc'
org 0x7c00
start:
	mov ax,0x1f00
	mov ss,ax
	mov ax,0x0fff
	mov sp,ax
	call segment.set_segments
	call segment.set_vram
	call screen.set_video_mode
	call screen.clear_vram
	call screen.set_color
	
	
	mov si,msg
	call screen.print_f
	
	mov ah,0x2 ;fonksiyon numarası
	mov al,0x1 ;toplam okunacak sector sayısı
	mov ch,0x0 ;cylinder numarası
	mov cl,0x2 ;sector numarası
	mov dh,0x0 ;head numarası
	mov dl,0x0 ;drive numarası
	mov bx,0x1000
	mov es,bx
	mov bx,0x0000
	int 13h
	jmp 0x1000:0000

segment:
	.set_segments:
		push ax
		mov ax,0x1000
		mov ds,ax
		mov es,ax
		pop ax
		ret
	.set_vram:
		push ax
		mov ax,0xb800
		mov gs,ax
		mov di,0x0000
		pop ax
		ret
screen:	
	.set_video_mode:
		push ax
		mov ah,0x0
		mov al,0x3
		int 10h
		pop ax
		ret
	.set_color:
		push ax
		push di
		push cx
		mov di,0x1
		mov ah,0x0c
		mov cx,0x7d0
		.set_color.loop:
			mov [gs:di],ah
			add di,2
			loop .set_color.loop
		pop cx
		pop di
		pop ax
		ret
	.clear_vram:
		push di
		push cx
		mov di,0x0
		mov cx,0x7d0
		.clear_vram.loop:
			mov byte [gs:di],0x0
			add di,2
			loop .clear_vram.loop
		pop cx
		pop di
		ret
	.print_f:
		push ax
		push bx
		push dx
		.cond:
			lodsb
			cmp al,0x0
			je .end
			cmp al,0x5c
			je .cond2
			mov [gs:di],al
			add di,2
			jmp .cond
		.cond2:
			lodsb
			cmp al,0x6e
			je .new_line
			jmp .cond
		.new_line:
			xor dx,dx
			mov [gs:di],dl
			add di,2
			mov ax,di
			mov bx,0xa0
			div bx
			cmp dx,0x0
			jne .new_line
			jmp .cond
		.end:
			pop dx
			pop bx
			pop ax
			ret
msg db "K/DA OS Baslatiliyor",0	
db 510-($-$$) dup 0
dw 0xaa55
