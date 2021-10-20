; Arquivo: SWeLED.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Faça os LEDs exibirem 
; LED = ON ON ON ON ON !SW3 !SW2 !SW1 0
; Mesma questão da prova

INICIO:
leaw $21185, %A
movw (%A), %D
notw %D

; retorna condição necessária para manter acesa 
leaw $510, %A
andw %A, %D, %D

; Analisa condição anteposta
;leaw $496, %A
;orw %A, %D, %D

; liga cada led respectivo
leaw $21184, %A
movw %D, (%A)

; Renicia
leaw $INICIO, %A
jmp
nop



