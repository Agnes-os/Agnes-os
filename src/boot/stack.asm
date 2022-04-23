; Multiboot 2 header for x86 targets
include 'format/format.inc'
FORMAT.ELF

; Base Stack Segment - MUST BE ALIGNED 16B!
section '.bss' writeable align 16
public stack_begin

stack_end:
db 16384 dup(0) ; 16K
stack_begin:
