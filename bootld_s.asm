include './inc/80386.inc'
org 0x7E00
start:
	cli
	mov bx, 0x0500
	mov word [es:bx], 0x0017 ;GDT size in bytes - 1
	add bx, 0x2
	mov dword [es:bx], 0x00000500 ;GDT logical address part
	mov bx, 0x0500
	lgdt [bx] ;loading GDTR with size and logical address
	mov bx, 0x0500 ;first entry address for gdt
	mov ax, 0x0000 ;null descriptor entry for first entry
	call set_gdt_entry
	mov bx, 0x0508 ;second entry address for gdt
	mov al, 0x9A ;access bits for kernel code segment
	mov ah, 0x0C ;flag bits for kernel code segment
	call set_gdt_entry
	mov bx, 0x0510 ;third entry address for gdt
	mov al, 0x92 ;access bits for kernel data segment
	mov ah, 0x0C ;flag bits for kenrel data segment
	call set_gdt_entry
	mov eax, cr0
	or al, 0x1
	mov cr0, eax
	hlt

;using flat model for memory and because of that setting
;limit value of entry to 0xFFFFF
;base value of entry to 0x00000000
;access bits in al register
;flag bits in ah register
;before calling set_gdt_entry set bx register for gdt entry address
;set ah for flag bits and al for access bits
set_gdt_entry:
	push bx
	push ax
	push dx
	mov dword [es:bx], 0x0000FFFF ;31 - 0 for base and limit bits
	add bx, 0x4
	mov dl, 0x00 ;39 - 32 for base bits
	mov dh, al ;47 - 40 for access bits
	mov word [es:bx], dx ;47 - 32 for access and base bits
	add bx, 0x2
	shl ah, 0x4 ;shifting flag bits 4 bit left
	add ah, 0xF ;for making space and adding last 4 bits of limit bits
	mov dl, ah ;55 - 48 for flags and limit bits
	mov dh, 0x00 ;63 - 56 for last base bits
	mov word [es:bx], dx ;63 - 48 for base, flags and limit bits
	pop dx
	pop ax
	pop bx
	ret
db 512-($-$$) dup 0
