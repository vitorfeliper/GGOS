%include "D:/GGOS/Source/Assembly/settings.asm"
[ORG BOOTADD]
;mov ax, 0x4F02
  ;mov bx, 0x0115
  mov ah, 0
  mov al, 03
  int 0x10
 ;
 ;push bp
 ;mov ah, 06
 ;mov al, 0
 ;mov bh, 0
 ;xor cx, cx
 ;mov dh, 25
 ;mov dl, 80
 ;int 10h
 ;pop bp

 push word 0x3F8
call initSerial

    push word 0
    push word 32
    push word 0Ah
    push word title
    call printsAt

    push word 4
    push word 21
    push word 0Fh
    push word headerPart
    call printsAt

    push word 5
    push word 21
    push word 0Fh
    push word headerLine
    call printsAt

    push word 20
    push word 21
    push word 0Fh
    push word msgInfo
    call printsAt

;push word 0Eh
;push word msg
;call prints


;push word msg
;push word tgt
;call strcpy

;push word tgt
;push word 0x3F8
;call WriteSerialSB

;push word decstr
;push word 32767
;call itoa

;push word decstr
;push word 0x3F8
;call WriteSerialSB

hang:
    mov ax, 1
    int 16h
    jnz hang

    push ax
    push word COM1
    call WriteSerialB

    jmp hang

%include "D:/GGOS/Source/Assembly/serial.asm"
%include "D:/GGOS/Source/Assembly/string.asm"
%include "D:/GGOS/Source/Assembly/stdlib.asm"
%include "D:/GGOS/Source/Assembly/stdio.asm"
title: db "GGOS BOOTLOADER", 0
headerPart: db "Opcao Num Disco Num Part. Tipo Tamanho", 0
headerLine: db "_____ ___ _____ ___ _____ ____ _______", 0
msgInfo: db ">", 0