PROJECT(agnes-boot ASM)

# Our assembler for this project is in the vendor directory:
set(CMAKE_ASM_FASMG_COMPILER "${CMAKE_SOURCE_DIR}/vendor/fasmg/core/fasmg.x64")
ENABLE_LANGUAGE(ASM_FASMG)


set(ENV{INCLUDE} "${CMAKE_SOURCE_DIR}/vendor/fasmg/packages/x86/include")
message("$ENV{INCLUDE}")
add_library(boot multiboot.asm)
SET_TARGET_PROPERTIES(boot PROPERTIES PREFIX "")
