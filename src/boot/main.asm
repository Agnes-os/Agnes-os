; Entry point
include 'format/format.inc'
FORMAT.ELF

section '.text' executable

extrn stack_begin ; stack.asm
extrn kernel_main       ; C kernel entry point
public _start

_start:
    mov esp, stack_begin ; This is actually the end, but the top.
    call kernel_main
    cli

@l:
    jmp @l
