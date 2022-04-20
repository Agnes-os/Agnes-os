; Entry point
include 'format/format.inc'
FORMAT.ELF

section '.text' executable

extrn stack_begin ; stack.asm
public _start

_start:
    mov esp, stack_begin ; This is actually the end, but the top.
    cli

@l:
    jmp @l
