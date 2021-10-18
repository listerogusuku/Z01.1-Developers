; Arquivo: Max.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares 
; Data: 27/03/2017
; Log :
;     - Rafael Corsi portado para Z01
;
; Calcula R2 = max(R0, R1)  (R0,R1,R2 se referem a  RAM[0],RAM[1],RAM[2])
; ou seja, o maior valor que estiver, ou em R0 ou R1 sera copiado para R2
; Estamos considerando número inteiros

; Analisando a diferença através do subw

leaw $0, %A         ; A recebe a constante 0
movw (%A), %D       ; D=RAM[0]
leaw $1, %A         ; A recebe a constante 1
movw (%A), %A       ; A=RAM[1]
subw %A, %D, %D     ; D=RAM[1]-RAM[0]

;  (R1 - R0) --> se >0 ==> se <0 ==> R0 é max, R1 é max

; se >0:
leaw $RUM, %A       ;A recebe a constante RUM
jg %D               ;Salta se valor de %D for maior que 0
nop                 ; DÁ O STOP

; se <0:
leaw $RZERO, %A     ;A recebe a constante RZERO
jl %D               ;Salta se valor de %D for menor que 0
nop                 ; DÁ O STOP

; se = 0 ==> R1 = R0 ==> END
leaw $END, %A       ;A recebe a constante END
je %D               ;Salta se valor de %Dé igual a 0
nop                 ; DÁ O STOP

RUM:
leaw $1, %A         ;A recebe a constante 1
movw (%A), %D       ;D=RAM[1]
leaw $2, %A         ;A recebe a constante 2
movw %D, (%A)       ;D=RAM[2]
; pular para o fim
leaw $END, %A       ;A recebe a constante END
jmp                 ;SALTA
nop                 ; DÁ O STOP

RZERO:
leaw $0, %A         ;A recebe a constante 0
movw (%A), %D       ;D=RAM[0]
leaw $2, %A         ;A recebe a constante 2
movw %D, (%A)       ;D=RAM[2]


END:
nop                 ; NÃO FAZ NADA