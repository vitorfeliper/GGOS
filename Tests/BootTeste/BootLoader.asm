[ORG 0x7C00]

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
	mov al, 0x00
	jmp LOOP
times 510-($-$$) db 0
db 0x55
db 0xAA