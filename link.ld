ENTRY(loader)              /* entry label    */
 
SECTIONS {
    . = 0x00100000;        /* load at 1 MB   */
 
    .text ALIGN (0x1000) : /* code           */
    {
        *(.text)
    }
 
    .rodata ALIGN (0x1000) : /* read-only    */
    {
        *(.rodata*)
    }
 
    .data ALIGN (0x1000) : /* initialised    */
    {
        *(.data)
    }
 
    .bss ALIGN (0x1000) :  /* zeroed at load */
    {
        *(COMMON)
        *(.bss)
    }
}