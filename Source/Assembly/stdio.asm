%define videomem 0xB800
%define textcols [0x044A]
prints:
    %define strptr [bp +4]
    %define color [bp +6]
    push bp
    mov bp, sp
    mov si, strptr
    .charloop:
        lodsb
        cmp al, 0
        je .end
        mov ah, 0Eh
        mov bh, 0
        mov bl, color
        int 10h
        jmp .charloop
    .end:
    pop bp
    ret 4

printsAt:
    %define strptr [bp + 4]
    %define color [bp + 6]
    %define col [bp + 8]
    %define row [bp + 10]
    push bp
    mov bp, sp
    mov bx, videomem
    mov es, bx

    mov ax, row
    mul word textcols
    add ax, col
    shl ax, 1

    mov di, ax

   ;mov ah, 02h
   ;mov bh, 0
   ;mov dh, row
   ;mov dl, col
   ;int 10h

  ;push word color
  ;push word strptr
  ;call prints
    mov si, strptr
    .charloop:
        lodsb
        cmp al, 0
        je .end
        mov ah, color
        stosw
        ;mov bh, 0
        ;mov bl, color
        ;int 10h
        jmp .charloop
    .end:
    pop bp
    ret 8