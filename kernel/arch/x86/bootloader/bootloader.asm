; Set up the stack
mov ax, 0x07C0
add ax, 288     ; Leave room for 512-byte boot sector + 256-byte stack
cli             ; Disable interrupts while changing stack segment
mov ss, ax
mov sp, 512

; Enable A20 line (allows access to memory above 1MB)
call enable_a20

; Load kernel from disk into memory at address 0x1000
mov bx, 0x1000      ; Load address = 0x1000 (segment:offset = 0x1000:0000)
mov dh, 15          ; Number of sectors to read (15 * 512 bytes/sector = 7680 bytes)
mov dl, [boot_drive]; Boot drive number (passed by BIOS in DL register)
call load_kernel

; Jump to kernel entry point at physical address 0x10000 (segment:offset = 0x1000:0000)
jmp 0x1000:0000


; Function: enable_a20
; Enables the A20 line to allow access to memory above 1MB.
enable_a20:
    ; TODO: Implement A20 line enabling code here.
    ret


; Function: load_kernel
; Loads the kernel from disk into memory at the specified address.
load_kernel:
    push dx         ; Save DX (boot drive number)

    mov ah, 2       ; BIOS read disk function (int 13h/ah=2)
    mov al, dh      ; Number of sectors to read
    mov ch, KERNEL_START_CYLINDER   ; Cylinder number (10-bit value split between CH and CL)
    mov cl, KERNEL_START_SECTOR     ; Sector number (6-bit value in bits<5-