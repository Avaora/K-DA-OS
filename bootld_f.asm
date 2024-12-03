include './inc/80386.inc'
org 0x7C00
start:
	mov ax, 0x0000
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov ax, 0x0500
	mov bp, ax
	mov ax, 0x7B00
	mov sp, ax
	
	mov ah, 0x2 ;function number
	mov al, 0x1 ;total sector read
	mov ch, 0x0 ;cylinder number
	mov cl, 0x2 ;sector number
	mov dh, 0x0 ;head number
	mov dl, 0x0 ;drive number
	mov bx, 0x0000
	mov es, bx
	mov bx, 0x7E00
	int 13h
	jmp 0x0000:0x7E00

db 510-($-$$) dup 0
dw 0xaa55
