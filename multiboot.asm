; Multiboot 2 header for x86 targets
include 'format/format.inc'
FORMAT.ELF

MULTIBOOT_MAGIC     = 0xE85250D6
MULTIBOOT_ARCH      = 0             ; 32 bit protected mode
MULTIBOOT_HDRLEN    = multiboot_header_end - multiboot_header_begin
MULTIBOOT_CHKSUM    = 0x100000000 - (MULTIBOOT_MAGIC + (multiboot_header_end - multiboot_header_begin))


section '.multiboot' align 4

multiboot_header_begin:
magic       dd MULTIBOOT_MAGIC
arch        dd MULTIBOOT_ARCH
hdr_len     dd MULTIBOOT_HDRLEN
checksum    dd MULTIBOOT_CHKSUM
multiboot_header_end:
