; Multiboot 2 header for x86 targets
include 'format/format.inc'
FORMAT.ELF

; Base Stack Segment - MUST BE ALIGNED 16B!
section '.bss' writeable align 16


extrn stack_end
dd 256 dup(0) ; 1K, Stack depth: 256
extrn stack_begin
