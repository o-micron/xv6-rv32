OUTPUT_ARCH("riscv")
ENTRY(_entry)

SECTIONS
{
    /*
     * Single segment: everything in one continuous region
     * starting at 0x80000000 where QEMU's -kernel jumps
     */
    . = 0x80000000;

    /* Single combined segment - everything goes here */
    .text : {
        *(.text)

        . = ALIGN(0x1000);
        *(trampsec)

        . = ALIGN(0x1000);
        PROVIDE(etext = .);
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
        *(.sbss*)

        /* end marks the end of kernel data (used by freemem) */
        PROVIDE(end = .);
    }
}
