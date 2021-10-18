; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Multiplica o valor de RAM[1] com RAM[0] salvando em RAM[3]
 
 leaw $0, %A
 movw (%A), %D      ; D = RAM[0] 
 leaw $END, %A      ; Condição caso RAM[0] = 0 (RAM[3] = 0)
 je %D
 nop
 leaw $1, %A
 movw (%A), %D      ; D = RAM[1]
 leaw $END, %A      ; Condição caso RAM[1] = 0 (RAM[3] = 0)
 je %D
 nop
 leaw $2, %A        ; RAM[2] é o contador (RAM[2]=RAM[1])
 movw %D, (%A)

 LOOP:                      ;  Controlado pelo valor do contador RAM[2]
 leaw $0, %A                 
 movw (%A), %D              ; D = RAM[0]
 leaw $3, %A
 addw %D, (%A), %D          ; D = RAM[3] + RAM[1] 
 movw %D, (%A)              ; RAM[3] = D
 leaw $2, %A                ; Buscando valor de RAM[2]
 subw (%A), $1, %D          ; D = RAM[2] - 1     
 movw %D, (%A)              ; RAM[2] é o contador (Enquanto RAM[1]>0 loop continua) ATUALIZA VALOR DO CONTADOR
 leaw $LOOP, %A
 jg %D                      ; RAM[2]>0
 nop
 leaw $END, %A
 jmp
 nop

 END: