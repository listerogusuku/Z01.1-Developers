; Arquivo: Pow.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Eleva ao quadrado o valor da RAM[1] e armazena o resultado na RAM[0].
; Só funciona com números positivos


;Criando um contador no RAM[3] para iniciar o LOOP
;Somaremos RAM[1] vezes a RAM[1] em RAM[0], para isso utilizaremos um loop.

leaw $R3, %A
movw $0,(%A)

LOOP:
    ; Soma RAM[1] ao atual valor de RAM[0]
    leaw $R1, %A
    movw (%A), %D
    leaw $R0, %A
    addw (%A), %D, %D
    movw %D, (%A)

    ; Incrementa o valor do contador RAM[3]
    leaw $R3, %A
    movw (%A), %D
    incw %D
    movw %D,(%A)
    
    ; Gera a condição de análise, isso é RAM[1]-RAM[3]
    leaw $R1, %A
    subw (%A),%D,%D

; Se RAM[1]-RAM[3] == 0, interrompe o LOOP, caso não, segue em execução.
leaw $LOOP, %A
jne %D
nop