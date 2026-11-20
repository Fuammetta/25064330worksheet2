global loader                   ; entry symbol, used by ENTRY() in link.ld
 
MAGIC_NUMBER equ 0x1BADB002     ; Multiboot magic: "I am a kernel"
FLAGS        equ 0x0            ; ask GRUB for no extra features
CHECKSUM     equ -(MAGIC_NUMBER + FLAGS)  ; magic + flags + checksum = 0
 
section .text                   ; code section (no colon!)
align 4                         ; header must be 4-byte aligned
    dd MAGIC_NUMBER             ; Multiboot header, 12 bytes,
    dd FLAGS                    ; inside the first 8 KB of the file
    dd CHECKSUM
 
loader:                         ; GRUB jumps here
    mov eax, 0xCAFEBABE         ; marker: proves our code ran
.loop:
    jmp .loop                   ; nothing else to do: loop forever
