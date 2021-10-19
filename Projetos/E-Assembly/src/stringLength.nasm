; Arquivo: stringLength.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi 
; Data: 28/03/2018
;
; Assuma que uma string é um conjunto de caracteres terminado
; em NULL (0).
; 
; Supondo que temos uma string que começa no endereço 8 da RAM.
; Calcule o seu tamanho e salve o resultado na RAM[0].
;
; Os caracteres estão formatados em ASCII
; http://sticksandstones.kstrom.com/appen.html
; 
; Exemplo:
;
;   Convertido para ASCII
;             |
;             v
;  RAM[8]  = `o`
;  RAM[9]  = `i`
;  RAM[10] = ` `
;  RAM[11] = `b`
;  RAM[12] =  l`
;  RAM[13] = `z`
;  RAM[14] = `?`
;  RAM[15] = NULL = 0x0000


leaw $8, %A    ; A recebe o endereço de memória 8
movw %A, %D    ; D = 8
leaw $0, %A    ; A recebe o endereço de memória 0
movw %D, (%A)  ; RAM[0]=8

LOOP: 
    leaw $0, %A ; A recebe o endereço de memória 0
    movw (%A), %A ; A = RAM[0]
    movw (%A), %D ; D = RAM[RAM[0]]
    leaw $END, %A ; A recebe END
    je %D ; salta para END, quando D= 0
    nop ; não faz nada
    leaw $0, %A ; A recebe o endereço de memória 0 
    movw (%A), %D ; D=RAM[0]
    addw $1, %D, (%A) ; RAM[0]=RAM[0]+1
    leaw $LOOP, %A 
    jmp
    nop

END:
leaw $0, %A ; A recebe o endereço de memória 0
movw (%A), %D ; D=RAM[0]
leaw $8, %A ; A recebe o endereço de memória 0
subw %D, %A, %D ; D=RAM[0]-8
leaw $0, %A ; A recebe o endereço de memória 0
movw %D, (%A) ; RAM[0]= RAM[0]-8


