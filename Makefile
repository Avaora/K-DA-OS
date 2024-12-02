BOOTSRC = bootldr.asm
KERNELSRC = kernel.asm
BOOT = bootldr
KERNEL = kernel
NAME = KDAos
ASMB = fasmg

all : $(NAME)

$(NAME) : $(BOOT) $(KERNEL)
	@echo "=============="
	dd if=./$(BOOT) of=./$(NAME) bs=512 count=1
	@echo "=============="
	dd if=./$(KERNEL) of=./$(NAME) bs=512 count=1 seek=1

$(BOOT) : $(BOOTSRC)
	@echo "=============="
	@echo "assembling bootloader"
	$(ASMB) $(BOOTSRC)

$(KERNEL) : $(KERNELSRC)
	@echo "=============="
	@echo "assembling kernel"
	$(ASMB) $(KERNELSRC)

clean :
	rm -f $(BOOT) $(KERNEL)

fclean : clean
	rm -f $(NAME)

re : fclean all

.PHONY : all clean fclean re
