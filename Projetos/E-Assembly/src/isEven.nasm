; Arquivo: isEven.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2019
;
; Verifica se o valor salvo no endereço RAM[5] é
; par. Se for verdadeiro, salva 1
; em RAM[0] e 0 caso contrário.

leaw $1, %A ; A recebe 1

movw %A, %D ; D = 1

leaw $5, %A ; A recebe 5

andw (%A), %D, %D ; D = A and D

leaw $0, %A ; A recebe 0

movw %D, (%A) ; RAM[0]=D

leaw $1, %A ; A recebe 1

movw %A, %D ; D = 1

leaw $0, %A ; A recebe 0

subw (%A), %D, %D ; D = RAM[0] - D

leaw $END, %A ; A recebe END

jge %D ; salta para END quando D>=0

nop ; stop

negw %D ; D = -D

END:

leaw $0, %A ; A recebe 0

movw %D, (%A) ; RAM[0] = D


