[ORG 0x7c00]
    mov ah, 2 ; comando para ler o disco que originou o boot
    mov al, 1 ; total de setores lidos
    mov ch, 0 ; Numero do cilindro
    mov cl, 2 ; Numero do setor para começar a ler
    mov dh, 1 ; Numero da cabeça a ser lida
    mov es, [EXTENSION]
    mov bx, 0
    int 13h
    jmp PRINT_STRING
STR: db "Hello World", 13, 10, 0
    times 510-($-$$) db 0
    db 0x55
    db 0xAA
;==============================================================================================
EXTENSION:
; DEFINE O MODO DE TEXTO AH e AL

	mov ah, 0x00;Tipo de função  definirModoDeVideo()
	mov al, 0x13;Tipo do modo parâmetros de função
	int 0x10
; Parâmetros utilizados

; COR DE FUNDO
	mov al, 0x01; Cor do pixel
	mov bh, 0x00; Numero da página
	mov cx, 0x00; Posição X
	mov dx, 0x00; Poisção Y

LOOP:
	mov ah, 0x0C
	int 0x10; chama a função de video
	inc cx; avança para o pixel a direita 
	cmp cx, 0x0140; verifica se igual a 320 
	jne LOOP; continua se ainda não é 320
	mov cx, 0x00; volta para a posição 0 do eixo X
	inc dx; avançar para a próxima linha
	cmp dx, 0xC8; verifica se ja chegou no limite inferior
	jne LOOP
	mov dx, 0x00; volta para a primeira linha 
	inc al; pula para a próxima cor
	cmp al, 0xFF; verifica se é a ultima cor
	je RESETCOR
	jmp LOOP
RESETCOR:
	mov al, 0x00 ; Reinicia a primeira cor
	jmp LOOP


PRINT_STRING:
    xor ax, ax ; zera o acumulador
    mov ds, ax
    mov si, STR
CHAR_LOOP: lodsb 
    or al, al ; checa se o valor 0
    jz HANG ; fica em loop até desligar o computador
    mov ah, 0x0E ; Seleciona a interrupção a ser executada
    int 0x10     ; executa a rotina de video selecionada
    jmp CHAR_LOOP ; VAI PARA O PRÓXIMO CARACTERE
HANG:
    jmp HANG