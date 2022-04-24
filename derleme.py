from os import *
while True:
	print("1-bootloaderı derle")
	print("2-kernelı derle")
	print("3-her ikisinide derle")
	print("4-bootloaderı floppy disk imajına yaz")
	print("5-kernelı floppy disk imajına yaz")
	print("6-her iki dosyayıda floppy disk imajına yaz")
	print("="*20)
	sec = int(input("derlemek istediğiniz seçeneği giriniz: "))


	if sec == 1:
		print("="*20,"\n")
		system("fasm popstar.asm popstar")
		print("bootloader derlendi")
		print("="*20,"\n")
	elif sec == 2:
		print("="*20,"\n")
		system("fasm theBaddest.asm theBaddest")
		print("kernel derlendi")
		print("="*20,"\n")
	elif sec == 3:
		print("="*20,"\n")
		system("fasm popstar.asm popstar")
		print("bootloader derlendi")
		print("="*20)
		system("fasm theBaddest.asm theBaddest")
		print("kernel derlendi")
		print("="*20,"\n")
	elif sec == 4:
		print("="*20,"\n")
		system("dd if=/home/raava/kdaOS/popstar of=/home/raava/kdaOS/os bs=512 count=1")
		print("="*20,"\n")
	elif sec == 5:
		print("="*20,"\n")
		system("dd if=/home/raava/kdaOS/theBaddest of=/home/raava/kdaOS/os bs=512 count=1 seek=1")
		print("="*20,"\n")
	elif sec == 6:
		print("="*20,"\n")
		system("dd if=/home/raava/kdaOS/popstar of=/home/raava/kdaOS/os bs=512 count=1")
		print("="*20)
		system("dd if=/home/raava/kdaOS/theBaddest of=/home/raava/kdaOS/os bs=512 count=1 seek=1")
		print("="*20,"\n")
		
	else :
		print("hatalı giriş yapıldı")
		print("="*20,"\n")

