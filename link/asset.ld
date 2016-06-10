OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
          "elf32-littlearm")
OUTPUT_ARCH(arm)

MEMORY
{
 code_region (rx)   : ORIGIN = 0x00008000, LENGTH = 0x00ff8000
 rodata_region (r)  : ORIGIN = 0x01000000, LENGTH = 0x0f000000
 data_region (rw)   : ORIGIN = 0x20000000, LENGTH = 0x10000000
}

SECTIONS
{
  .text             :
    {
        *(.text)
    } > code_region
  .rodata           :
    {
        *(.rodata*)
        KEEP (*(SORT_NONE(.init)))
        KEEP (*(SORT_NONE(.fini)))
        KEEP (*(.eh_frame))
    } > rodata_region
  .data             :
    {
        __init_array_start = .;
        KEEP (*(SORT(.init_array.*)))
        KEEP (*(.init_array ))
        __init_array_end = .;
        KEEP (*(SORT(.fini_array.*)))
        KEEP (*(.fini_array ))
        KEEP (*(.jcr))
        *(.data*)
        *(.bss*)
        *(COMMON)
    } > data_region
}
