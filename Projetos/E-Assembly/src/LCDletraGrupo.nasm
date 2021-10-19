; Arquivo: LCDletraGrupo.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Escreva no LCD a letra do grupo de vocês
;  - Valide no hardawre
;  - Bata uma foto!

;;;;;;;;;;;;;;;;;;;;;;;; AJUSTAR TEMPO DE SIMULAÇÃO PARA 4000 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leaw $8, %A
movw %A, (%A)              ; Guarda a espessura das linhas RAM[8] = 8 (Inicio)

leaw $50, %A
movw %A, (%A)              ; Guarda altura maior vertical RAM[50]=50 (Inicio)

leaw $16564, %A            ; INICIO LINHA DE CIMA
movw %A, %D 
leaw $51, %A
movw %D, (%A)              ; Guarda endereço incial vertical RAM[51] = 16524

leaw $4, %A                ; 4x 16bits de comprimento nas duas maiores linhas horizontais
movw %A, (%A)              ; RAM[4] = 4

leaw $16384, %A            ;  Guarda endereço: em RAM[0]
movw %A, %D
leaw $0, %A
movw %D, (%A)              ; RAM[0] = 16384 (binary)                            

TOPO:
 
 leaw $4, %A
 subw (%A), $1, %D       ; Diminuindo contador: RAM[4]-=1
 movw %D, (%A)

 leaw $LARGURA, %A      ; Para uma determina espessura
 je %D
 nop

 leaw $0, %A             ; A = 0 (binary)
 movw (%A), %A           ; A = valor de RAM[0]
 movw $-1, (%A)          ; RAM[RAM[0]] = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 
 addw $1, %A, %D         ; D = Valor do endereço RAM[0] + 1    ---> Iterando endereço
 leaw $0, %A             ; A = 0
 movw %D, (%A)           ; RAM[0] = Posição Iterada

 leaw $TOPO, %A
 jmp
 nop

LARGURA:                ; Espessura das linhas:

leaw $17, %A
movw %A, %D             ; Número de endereços que devem ser saltados para chegarmos na linhas seguinte.
leaw $0, %A
addw (%A), %D, %D
movw %D, (%A)           ; RAM[0] passa a possuir primeiros indereços de outras linhas.

leaw $4, %A                ; Inicializando comprimento novamente
movw %A, (%A)              ; RAM[4] = 4

leaw $8, %A
subw (%A), $1, %D
movw %D, (%A)           ; Atualizando RAM[8], para termos uma espessura de 10 linhas ao final

leaw $MAIORVERTICAL , %A
je %D
nop

leaw $TOPO, %A
jmp
nop

MAIORVERTICAL:

leaw $51, %A             ; A = 51(binary)
movw (%A), %A            ; A = RAM[51] (Inicialmente = 16524)
movw $-1, (%A)           ; RAM[RAM[51]] = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1

leaw $20, %A
movw %A, %D              ; D = 20(binary) -> Vai ser somado para mudarmos de linha
leaw $51, %A
addw (%A), %D, %D        ; D = RAM[51]+20    Saltando para a proxima linha e guardando o endereço.
leaw $51, %A             ; RAM[51] = D
movw %D, (%A) 

leaw $50, %A
subw (%A), $1, %D
movw %D, (%A)            ; Atualizando contador para fixar altura da vertical.

leaw $MAIORVERTICAL, %A  ; Equanto contador !0, pinta linha.
jne %D
nop

leaw $BASE, %A
jmp
nop

BASE:

leaw $8, %A
movw %A, (%A)              ; Guarda a espessura das linhas RAM[8] = 8 (Inicio)

leaw $4, %A                ; 4x 16bits de comprimento nas duas maiores linhas horizontais
movw %A, (%A)              ; RAM[4] = 4

leaw $17584, %A            ;  Guarda endereço: em RAM[0] INICIO LINHA DE BAIXO
movw %A, %D
leaw $0, %A
movw %D, (%A)              ; RAM[0] = 16384 (binary)  

BASELINHA:
 
 leaw $4, %A
 subw (%A), $1, %D       ; Diminuindo contador: RAM[4]-=1
 movw %D, (%A)

 leaw $LARGURABASE, %A      ; Para uma determina espessura
 je %D
 nop

 leaw $0, %A             ; A = 0 (binary)
 movw (%A), %A           ; A = valor de RAM[0]
 movw $-1, (%A)          ; RAM[RAM[0]] = 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 
 addw $1, %A, %D         ; D = Valor do endereço RAM[0] + 1    ---> Iterando endereço
 leaw $0, %A             ; A = 0
 movw %D, (%A)           ; RAM[0] = Posição Iterada

 leaw $BASELINHA, %A
 jmp
 nop

LARGURABASE:                ; Espessura das linhas:

leaw $17, %A
movw %A, %D             ; Número de endereços que devem ser saltados para chegarmos na linhas seguinte.
leaw $0, %A
addw (%A), %D, %D
movw %D, (%A)           ; RAM[0] passa a possuir primeiros indereços de outras linhas.

leaw $4, %A                ; Inicializando comprimento novamente
movw %A, (%A)              ; RAM[4] = 4

leaw $8, %A
subw (%A), $1, %D
movw %D, (%A)           ; Atualizando RAM[8], para termos uma espessura de 7 linhas ao final

leaw $QUADRADO , %A
je %D
nop

leaw $BASELINHA, %A
jmp
nop

QUADRADO:

leaw $61440, %A            ; Guarda valor para desenhar quadrado
movw %A, %D                ; 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 

leaw $16547, %A            
movw %D, (%A)              ; QUADRADO CIMA
leaw $16567, %A            
movw %D, (%A) 
leaw $16587, %A            
movw %D, (%A) 
leaw $16607, %A            
movw %D, (%A) 
leaw $16627, %A            
movw %D, (%A) 

leaw $17567, %A            
movw %D, (%A)              ; QUADRADO BAIXO
leaw $17547, %A            
movw %D, (%A) 
leaw $17527, %A            
movw %D, (%A) 
leaw $17607, %A            
movw %D, (%A) 
leaw $17587, %A            
movw %D, (%A) 

leaw $45, %A               ; Guarda altura da menor vertical RAM[45] = 45 (Inicio)
movw %A, (%A)

leaw $16647, %A            ; Guarda endereços da menor vertical.
movw %A, %D
leaw $61, %A
movw %D, (%A)

MENORVERTICAL:

leaw $1984, %A
movw %A, %D
leaw $61, %A             ; A = 61(binary)
movw (%A), %A            ; A = RAM[61] (Inicialmente = 16647)
movw %D, (%A)           ; RAM[RAM[61]] = 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0

leaw $20, %A
movw %A, %D              ; D = 20(binary) -> Vai ser somado para mudarmos de linha
leaw $61, %A
addw (%A), %D, %D        ; D = RAM[51]+20    Saltando para a proxima linha e guardando o endereço.
leaw $61, %A             ; RAM[51] = D
movw %D, (%A) 

leaw $45, %A
subw (%A), $1, %D
movw %D, (%A)            ; Atualizando contador para fixar altura da vertical.

leaw $MENORVERTICAL, %A  ; Enquanto contador !0, pinta linha.
jne %D
nop