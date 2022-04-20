; Multiboot header for x86 targets
include 'format/format.inc'
FORMAT.ELF

;Multiboot 2
MULTIBOOT_MAGIC     = 0xE85250D6
MULTIBOOT_ARCH      = 0             ; 32 bit protected mode
MULTIBOOT_HDRLEN    = multiboot_header_end - multiboot_header_begin
MULTIBOOT_CHKSUM    = 0x100000000 - (MULTIBOOT_MAGIC + (multiboot_header_end - multiboot_header_begin))

;Multiboot 1
MULTIBOOT1_MAGIC    = 0x1BADB002
MULTIBOOT1_FLAGS    = 0x0
MULTIBOOT1_CHKSUM   = 0x100000000 - (MULTIBOOT1_MAGIC + MULTIBOOT1_FLAGS)

section '.multiboot' align 4

multiboot_header_begin:
magic       dd MULTIBOOT_MAGIC
arch        dd MULTIBOOT_ARCH
hdr_len     dd MULTIBOOT_HDRLEN
checksum    dd MULTIBOOT_CHKSUM
multiboot_header_end:

multiboot1_header_begin:
magic1      dd MULTIBOOT1_MAGIC
flags       dd MULTIBOOT1_FLAGS
checksum1   dd MULTIBOOT1_CHKSUM
multiboot1_header_end:
