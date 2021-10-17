; Arquivo: LCDQuadrado.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Desenhe um quadro no LCD
; Desenhando linha superior horizontal do quadrado:
    leaw $16385, %A
    movw $-1, (%A)

; Desenhando linha vertical esquerda do quadrado:
    leaw $16384, %A
    movw $1, (%A)
    leaw $16404, %A
    movw $1, (%A)
    leaw $16424, %A
    movw $1, (%A)
    leaw $16444, %A
    movw $1, (%A)
    leaw $16464, %A
    movw $1, (%A)
    leaw $16484, %A
    movw $1, (%A)
    leaw $16504, %A
    movw $1, (%A)
    leaw $16524, %A
    movw $1, (%A)
    leaw $16544, %A
    movw $1, (%A)
    leaw $16564, %A
    movw $1, (%A)
    leaw $16584, %A
    movw $1, (%A)
    leaw $16604, %A
    movw $1, (%A)
    leaw $16624, %A
    movw $1, (%A)
    leaw $16644, %A
    movw $1, (%A)
    leaw $16664, %A
    movw $1, (%A)
    leaw $16684, %A
    movw $1, (%A)
    leaw $16704, %A
    movw $1, (%A)
    leaw $16724, %A
    movw $1, (%A)

; Desenhando linha vertical direita do quadrado:
    leaw $16425, %A
    movw $1, (%A)
    leaw $16445, %A
    movw $1, (%A)
    leaw $16465, %A
    movw $1, (%A)
    leaw $16485, %A
    movw $1, (%A)
    leaw $16505, %A
    movw $1, (%A)
    leaw $16525, %A
    movw $1, (%A)
    leaw $16545, %A
    movw $1, (%A)
    leaw $16565, %A
    movw $1, (%A)
    leaw $16585, %A
    movw $1, (%A)
    leaw $16605, %A
    movw $1, (%A)
    leaw $16625, %A
    movw $1, (%A)
    leaw $16645, %A
    movw $1, (%A)
    leaw $16665, %A
    movw $1, (%A)
    leaw $16685, %A
    movw $1, (%A)
    leaw $16705, %A
    movw $1, (%A)
    leaw $16725, %A
    movw $1, (%A)

; Desenhando Linha inferior horizontal do quadrado:
    leaw $16725, %A
    movw $-1, (%A)