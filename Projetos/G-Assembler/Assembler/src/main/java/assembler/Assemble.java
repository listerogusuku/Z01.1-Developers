/**
 * Curso: Elementos de Sistemas
 * Arquivo: Assemble.java
 * Created by Luciano <lpsoares@insper.edu.br>
 * Date: 04/02/2017
 *
 * 2018 @ Rafael Corsi
 */

package assembler;
import java.io.*;

/**
 * Faz a geração do código gerenciando os demais módulos
 */
public class Assemble {
    private String inputFile;              // arquivo de entrada nasm
    File hackFile = null;                  // arquivo de saída hack
    private PrintWriter outHACK = null;    // grava saida do código de máquina em Hack
    boolean debug;                         // flag que especifica se mensagens de debug são impressas
    private SymbolTable table;             // tabela de símbolos (variáveis e marcadores)

    private boolean temSalto;
    private Integer contador ;

    /*
     * inicializa assembler
     * @param inFile
     * @param outFileHack
     * @param debug
     * @throws IOException
     */
    public Assemble(String inFile, String outFileHack, boolean debug) throws IOException {
        this.debug = debug;
        inputFile  = inFile;
        hackFile   = new File(outFileHack);                      // Cria arquivo de saída .hack
        outHACK    = new PrintWriter(new FileWriter(hackFile));  // Cria saída do print para
        // o arquivo hackfile
        table      = new SymbolTable();                          // Cria e inicializa a tabela de simbolos

        temSalto = false;  //Verifica a existência de um jump
        contador = 0;    //Verifica se a linha analisada é a "seguinte de um jump"
    }

    /**
     * primeiro passo para a construção da tabela de símbolos de marcadores (labels)
     * varre o código em busca de novos Labels e Endereços de memórias (variáveis)
     * e atualiza a tabela de símbolos com os endereços (table).
     *
     * Dependencia : Parser, SymbolTable
     * @return
     */
    public SymbolTable fillSymbolTable() throws FileNotFoundException, IOException {

        // primeira passada pelo código deve buscar os labels
        // LOOP:
        // END:
        Parser parser = new Parser(inputFile);
        int romAddress = 0;
        while (parser.advance()){
            if (parser.commandType(parser.command()) == Parser.CommandType.L_COMMAND) {
                String label = parser.label(parser.command());
                /* TODO: implementar */
                // deve verificar se tal label já existe na tabela,
                // se não, deve inserir. Caso contrário, ignorar.

                if(!table.contains(label)){                // Caso nao esteja na tabela adicionar
                    table.addEntry(label,romAddress);
                }

            }
            else {
                romAddress++;
            }
        }
        parser.close();

        // a segunda passada pelo código deve buscar pelas variáveis
        // leaw $var1, %A
        // leaw $X, %A
        // para cada nova variável deve ser alocado um endereço,
        // começando no RAM[15] e seguindo em diante.
        parser = new Parser(inputFile);
        int ramAddress = 15;
        while (parser.advance()){
            if (parser.commandType(parser.command()) == Parser.CommandType.A_COMMAND) {
                String symbol = parser.symbol(parser.command());
                if (Character.isDigit(symbol.charAt(0))){
                    /* TODO: implementar */
                    // deve verificar se tal símbolo já existe na tabela,
                    // se não, deve inserir associando um endereço de
                    // memória RAM a ele.

                    if(!table.contains(symbol)){                // Caso nao esteja na tabela adicionar
                        table.addEntry(symbol,ramAddress);
                    }
                }
                ramAddress++;
            }

        }
        parser.close();
        return table;
    }

    /**
     * Segundo passo para a geração do código de máquina
     * Varre o código em busca de instruções do tipo A, C
     * gerando a linguagem de máquina a partir do parse das instruções.
     *
     * Dependencias : Parser, Code
     */
    public void generateMachineCode() throws FileNotFoundException, IOException{
        Parser parser = new Parser(inputFile);  // abre o arquivo e aponta para o começo
        String instruction  = "";

        /**
         * Aqui devemos varrer o código nasm linha a linha
         * e gerar a string 'instruction' para cada linha
         * de instrução válida do nasm
         * seguindo o instruction set
         */
        while (parser.advance()){
            String[] comando = parser.instruction(parser.command());
            switch (parser.commandType(parser.command())){
                /* TODO: implementar */
                case C_COMMAND:
                    instruction = "10" + Code.comp(comando) + Code.dest(comando) + Code.jump(comando);

                    if (Code.jump(comando) != "000"){                  // jump
                        temSalto = true;                               // Atualiza variável temSalto (Verifica a exitencia de salto no código).
                        System.out.println("Tem salto");
                    }

                    break;
                case A_COMMAND:
                    try {
                        instruction = "00" + Code.toBinary(parser.symbol(parser.command()));
                    } catch (Exception e){
                        instruction = "00" + Code.toBinary(table.getAddress(parser.symbol(parser.command())).toString());
                    }
                    break;
                default:
                    continue;
            }
            // Escreve no arquivo .hack a instrução
            if(outHACK!=null) {

                if(temSalto   && parser.command().contains("nop")){   // Caso a linha seguinte não tenha Nop e a linha anterior tenha jump , escrever nop
                    if(contador == 0){
                        contador = 1;                                 // Condição para a linha seguinte ao jump
                    }else {
                        outHACK.println("100000011000000000");        // Nosso código está construido para interpretar essa instrução como um nop.
                        System.out.println("Acrescentando nop!");

                        temSalto = false;                            // atualizando variáveis depois de escrever um nop
                        contador=0;
                    }
                } else{
                    temSalto = false;                                // atualizando variável caso já haja um nop
                }

                outHACK.println(instruction);
            }
            instruction = null;
        }
    }

    /**
     * Fecha arquivo de escrita
     */
    public void close() throws IOException {
        if(outHACK!=null) {
            outHACK.close();
        }
    }

    /**
     * Remove o arquivo de .hack se algum erro for encontrado
     */
    public void delete() {
        try{
            if(hackFile!=null) {
                hackFile.delete();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}
