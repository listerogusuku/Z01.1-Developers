/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package assembler;

/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 4 bits) com código em linguagem de máquina para a instrução.
     */

    private static String apenasUmDestino (int posicao , String [] mnemnonic){
        if(mnemnonic[posicao].equals("%A")){
            return "0001";
        } else if (mnemnonic[posicao].equals("%D")){
            return "0010";
        } else if (mnemnonic[posicao].equals("(%A)")){
            return "0100";
        } else {
            return "0000";
        }
    }

    private static String maisDeUmDestino (int posicao , String [] mnwmonic){

        String destino = mnwmonic[2] + mnwmonic[3];

        switch (destino){
            case "(%A)%D":
            case "%D(%A)":
                return "0110";
            case "(%A)%A":
            case "%A(%A)":
            case "%A%D":
                return "0101";
            case "%D%A":
                return "0011";

            default:
                return "0000";
        }

    }

    public static String dest(String[] mnemnonic) {
        /* TODO: implementar */

        String opcode = "0000";
        int tamanho = mnemnonic.length;

        // Instruções que possuem destino na posição 1 : leaw , incw , notw , negw
        // Instruções que possuem destino na posição 2 : movw (possue mais possibilidades).
        // Instruções que possuem destino na posição 3 : movw , addw  , subw , rsubw -> possue mais possibilidades
        //                                               andw , orw
        // Instruções que possuem destino na posição 4 : movw , addw  , subw , rsubw -> possue mais possibilidades

        if(tamanho == 2){

            opcode = apenasUmDestino(1 , mnemnonic);

        } else if (tamanho == 3){

            opcode = apenasUmDestino(2 , mnemnonic);

        } else if (tamanho == 4){

            if (!mnemnonic[0].equals("movw")){

                opcode = apenasUmDestino(3,mnemnonic);

            } else {  // Para o movw (Começa a atribuição a destino em posicao = 2)

                opcode = maisDeUmDestino(2, mnemnonic);
            }

        } else if (tamanho == 5){
            if (mnemnonic[0].equals("movw")){    // Caso seja o movw iria para todos os destinos
                return "0111";
            } else {                        // Caso fosse outra instrução, pode possuir 2 destinos
                opcode = maisDeUmDestino(3, mnemnonic);
            }
        }

        return opcode;
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {  // c0 a r0 de uma instrução tipo D (ou C)
        /* TODO: implementar */

        if ( mnemnonic[0].equals("movw")){
            // Descobrindo que tipo de movw é:

            if(mnemnonic[1].equals("%A")){
                return "000110000";                         // Saída da ula deve ser A
            }else if (mnemnonic[1].equals("%D")){
                return "000001100";                         // Saída da ula deve ser D
            }else if (mnemnonic[1].equals("(%A)")){
                return "001110000";                         // Saída da ula deve ser (%A)
            }else if (mnemnonic[1].equals("$1")){
                return "000111111";
            }else if (mnemnonic[1].equals("$-1")){
                return "000111010";
            }else if (mnemnonic[1].equals("$0")){
                return "000101010";
            }

        }  else if (mnemnonic[0].equals("addw")){

            if(mnemnonic[1].equals("%A") || mnemnonic[1].equals("%D")) {
                return "000000010";                            // A + D
            } else if (mnemnonic[1].equals("(%A)")) {
                return "001000010";                            // (A) + D
            } else if (mnemnonic[1].equals("$1") && mnemnonic[2].equals("%A")) {
                return "000110111";                            // 1 + A
            } else if (mnemnonic[1].equals("$1") && mnemnonic[2].equals("%D")) {
                return "000011111";                            // 1 + D
            } else if (mnemnonic[1].equals("$1") && mnemnonic[2].equals("(%A)")){
                return "001110111";                            // 1 + (A)
            }else if (mnemnonic[1].equals("$-1") && mnemnonic[2].equals("%A")) {
                return "001100010";                            // -1 + A
            } else if (mnemnonic[1].equals("$-1") && mnemnonic[2].equals("%D")) {
                return "000011010";                            // -1 + D
            } else if (mnemnonic[1].equals("$-1") && mnemnonic[2].equals("(%A)")){
                return "011100010";                            // -1 + (A)
            }

        } else if (mnemnonic[0].equals("subw")){

            if (mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")) {
                return "000010011";                               // D - A
            } else if (mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")) {
                return "001010011";                               // D - (A)
            } else if (mnemnonic[1].equals("%D") && mnemnonic[2].equals("$1")) {
                return "000001110";                               // D - 1
            } else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("$1")) {
                return "000110010";                               // A - 1
            } else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("$1")) {
                return "001110010";                               // (A) - 1
            }
            else if (mnemnonic[1].equals("(%A)")) {
                return "001000111";
            }
            else{
                if (mnemnonic[1].equals("%A")){
                    if (mnemnonic[2].equals("(%A)")){
                        return "001000111";
                    } else {
                        return "000000111";
                    }
                }
            }


        } else if (mnemnonic[0].equals("rsubw")){

            if (mnemnonic[2].equals("%A") && mnemnonic[1].equals("%D")) {
                return "000000111";                               // A - D
            } else if (mnemnonic[2].equals("(%A)") && mnemnonic[1].equals("%D")) {
                return "001000111";                               // (A) - D
            }


        } else if (mnemnonic[0].equals("incw")){

            if (mnemnonic[1].equals("%A")) {
                return "000110111";                            // 1 + A                                  // A - 1
            } else if (mnemnonic[1].equals("%D")) {
                return "000011111";                            // 1 + D
            } else if (mnemnonic[1].equals("(%A)")){
                return "001110111";                            // 1 + (A)
            }


        } else if (mnemnonic[0].equals("decw")){

            if (mnemnonic[1].equals("%D")) {
                return "000001110";                               // D - 1
            } else if (mnemnonic[1].equals("%A")) {
                return "000110010";                               // A - 1
            } else if (mnemnonic[1].equals("(%A)")){
                return "000110010";                               // (A) - 1
            }

        } else if (mnemnonic[0].equals("notw")){       // !D ou !A ?

            if (mnemnonic[1].equals("%D")) {
                return "000001101";                               // !D
            } else if (mnemnonic[1].equals("%A")) {
                return "000110001";                               // !A
            } else if (mnemnonic[1].equals("(%A)")){
                return "001110001";                               // !(A)
            }

        } else if (mnemnonic[0].equals("negw")){      // -D ou -A ?

            if (mnemnonic[1].equals("%D")) {
                return "000001111";                               // -D
            } else if (mnemnonic[1].equals("%A")) {
                return "000110011";                               // -A
            } else if (mnemnonic[1].equals("(%A)")){
                return "001110010";                               // -(A)
            }

        } else if (mnemnonic[0].equals("andw")){

            if (mnemnonic[1].equals("%D") || mnemnonic[1].equals("%A")) {
                return "000000000";                               // D&A  ou A&D
            } else if (mnemnonic[1].equals("(%A)")){
                return "001000000";                               // D&(A) ou (A)&D
            }

        } else if (mnemnonic[0].equals("orw")){

            if (mnemnonic[1].equals("%D") || mnemnonic[1].equals("%A")) {
                return "000010101";                               // D|A  ou A|D
            } else if (mnemnonic[1].equals("(%A)")){
                return "001010101";                               // (A)|D
            }

        } else {
            return "000001100"; // Return para jumps (Saída da ULA = %D)
        }

        return "";
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
        /* TODO: implementar */

        switch(mnemnonic[0]){
            case "jmp": return "111";
            case "jle": return "110";
            case "jne": return "101";
            case "jl":  return "100";
            case "jge": return "011";
            case "je" : return "010";
            case "jg" : return "001";
            default: return "000";
        }
    }

    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */
    public static String toBinary(String symbol) {
        /* TODO: implementar */

        int numero = Integer.parseInt(symbol);
        String binario = Integer.toBinaryString(numero);

        while (binario.length() <= 15) {
            binario = '0' + binario;
        }

        return binario;
    }

}
