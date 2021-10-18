; Arquivo: Div.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Divide R0 por R1 e armazena o resultado em R2.
; (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
; divisao para numeros inteiros positivos

LOOP:
leaw $1, %A         ; A RECEBE CONSTANTE 1
movw (%A), %D       ; D=RAM[1]
leaw $0, %A         ; A RECEBE A CONSTANTE 0
subw (%A), %D, %D   ; D= RAM[0]-RAM[1]

leaw $IF, %A        ; A RECEBE IF
jge %D              ; Salta se valor de %D for maior ou igual a 0
nop                 ; STOP
leaw $END, %A       ; A RECEBE END
jmp                 ; SALTA INCONDICIONALMENTE
nop                 ; STOP

IF:
leaw $0, %A         ; A RECEBE O
movw %D, (%A)       ; RAM[0]=D
leaw $2, %A         ; A RECEBE 2
movw (%A), %D       ; D=RAM[2]
incw %D             ; D = D+1
movw %D, (%A)       ; RAM[A]=D
leaw $LOOP, %A      ; A RECEBE LOOP
jmp                 ; PULA INDEFINIDAMENTE
nop                 ; STOP

END:
nop                 ; NÃO FAZ NADA 