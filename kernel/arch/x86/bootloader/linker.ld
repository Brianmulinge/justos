ENTRY(_start)

SECTIONS {
    /* The bootloader code */
    .text.boot : {
        *(.text.boot)
    } = 0x7C00

    /* The kernel code */
    .text : {
        *(.text)
    }

    /* The data section */
    .data : {
        *(.data)
    }

    /* The bss section */
    .bss : {
        *(.bss)
    }
}
