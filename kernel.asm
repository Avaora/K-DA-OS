include './inc/80386.inc'
org 0x7E00
start:
	cli
	mov bx, 0x0500
	mov word [es:bx], 0x0017 ;GDT size in bytes - 1
	add bx, 0x2
	mov word [es:bx], 0x0500 ;GDT logical address part
	add bx, 0x2
	mov word [es:bx], 0x0000 ;GDT logical address part
	mov bx, 0x0500
	lgdt [bx] ;loading GDTR with size and logical address
	mov bx, 0x0500 ;offset in the global descriptor table
	mov ax, 0x0000 ;null descriptor
	call set_seg_desc
	mov al, 0x9A ;access bits for kernel code segment
	mov ah, 0x0C ;flag bits for kernel code segment
	call set_seg_desc
	mov al, 0x92 ;access bits for kernel data segment
	mov ah, 0x0C ;flag bits for kenrel data segment
	call set_seg_desc
	mov eax, cr0
	or al, 0x1
	mov cr0, eax
	jmp 0x8:kernel

kernel:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov ss, ax
	hlt

;using flat model for memory and because of that setting
;limit value of entry to 0xFFFFF
;base value of entry to 0x00000000
;access bits in al register
;flag bits in ah register
set_seg_desc:
	mov dx, 0xFFFF ;first 16 bits for entry
	mov [es:bx], dx
	add bx, 0x2
	mov dx, 0x0000 ;second 16 bits for entry
	mov [es:bx], dx
	add bx, 0x2
	mov dl, 0x00 ;third 16 bits for entry
	mov dh, al ;third 16 bits for entry
	mov [es:bx], dx
	add bx, 0x2
	shl ah, 0x4 ;shifting 4 bit left
	or ah, 0x0F ;adding last limit byte
	mov dl, ah ;fourth 16 bits for entry
	mov dh, 0x00 ;fourth 16 bits for entry
	mov [es:bx], dx
	add bx, 0x2
	ret
db 512-($-$$) dup 0
