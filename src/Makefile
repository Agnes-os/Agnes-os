#CC 		 	= 	clang
CFLAGS		?= 	-fno-stdlib -m32 -Wall -Wextra -pedantic -O2 -ffreestanding
LDFLAGS 	?= 	-T linker.ld
AS		 	= 	fasmg
ASFLAGS		?=  -n
#MAKE		?=	bmake

COBJS		=
ASOBJS		=	multiboot.o stack.o

ROOTDIR     != echo `pwd`/..
INCLUDE		=  $(ROOTDIR)/vendor/fasmg/core/examples/x86/include


kernel: boot

$(ASOBJS):
	INCLUDE=$(INCLUDE) $(AS) $(ASFLAGS) $(.PREFIX).asm $(.PREFIX).o
	
boot: $(ASOBJS)

clean:
	@rm -f *.o
