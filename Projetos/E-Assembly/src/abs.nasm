; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Copia o valor de RAM[1] para RAM[0] deixando o valor sempre positivo.

 leaw $R1, %A ; registrador A recebe 1
movw (%A), %D ; colocando a informacao de RAM[1] no registrador %D 
 ; linhas 11, 12, 13 sao tipo um if
leaw $NEGATIVO, %A ; 
jl %D ; jumping é uma condição que salta o valor para D quando esse valor for menor que zero 
nop ; como se fosse um break
leaw $POSITIVO, %A ; 
jge %D ; mesma coisa do jl so que para condição maior igual a zero
nop ; como se fosse um break
 
NEGATIVO: ; quando o D for menor que zero, o A vem pro negativo na condição if
negw %D ; neg é o -D
leaw $0, %A ; a ram 0 vai ser o D
movw %D, (%A) ; movo o D para a Ram[0]
; pular para o fim
leaw $END, %A ;A recebe a constante END
jmp ;SALTA (salto forçado- sem condicional)
nop ; DÁ O STOP 
 ; linhas 23,24,25 sao tipo o if
POSITIVO:
leaw $0, %A
movw %D, (%A)
 
END:
nop ; nao faz nada , so para acabar o comando