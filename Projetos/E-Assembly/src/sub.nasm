; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; faz uma subtracao binaria do valor de :  RAM[1] - RAM[0] gravando em RAM[2].

leaw $0, %A ; Registrador A aloca informação 0 na memoria
movw (%A), %D ; D = RAM[0] que vem do leaw
leaw $1, %A ; Registrador A aloca a informação 1 na memoria
subw (%A), %D, %D
leaw $2, %A
movw %D, (%A)

