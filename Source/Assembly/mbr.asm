%include "D:/GGOS/Source/Assembly/settings.asm"
[ORG 0x7C00]
;mov ah, 02
;mov al, 01
;CX := ((CYLINDER AND 255)SHL 8) OR ((CYLINDER AND 768) SHR 2) OR SECTOR;
;xor cx, cx
;or cx, 02
;mov dh, 0
;mov bx, 0x500
;mov es, bx
;xor bx, bx

mov ah, 42h
xor bx, bx
mov ds, bx
mov si, DAP
int 13h

cmp ah, 0
je BOOTADD
hang:
    jmp hang

DAP:
    .size: db 10h
    .reserved: db 0
    .sectors: dw 2
    .segment: dw BOOTADD
    .offset: dw 0
    .lba: dq 1
times 510-($-$$) db 0
db 0x55
db 0xAA