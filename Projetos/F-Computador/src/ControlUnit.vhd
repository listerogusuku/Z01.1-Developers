-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: ControlUnit.vhd
-- date: 4/4/2017
-- Modificação:
--   - Rafael Corsi : nova versão: adicionado reg S
--
-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port(
		instruction                 : in STD_LOGIC_VECTOR(17 downto 0);  -- instrução para executar
		zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e
                                                                     -- ng (se negativo) da ALU
		muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- instrução  e ALU para reg. A
		muxAM                       : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- reg. A e Mem. RAM para ALU
                                                                     -- A  e Mem. RAM para ALU
		zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
		loadA, loadD, loadM, loadPC : out STD_LOGIC;                     -- sinais de load do reg. A,
                                                                     -- reg. D, Mem. RAM e Program Counter
    -- Conceito B:
    loadS: out STD_LOGIC;
    muxS: out STD_LOGIC

    );
end entity;

architecture arch of ControlUnit is

begin

  loadD<= instruction(4) and instruction(17);
  loadM<= instruction(5) and instruction(17);
  loadA<= instruction(3) or not instruction(17); -- Pode ser uma operação de escrita ou leitura.

  muxAM<= instruction(13) and instruction(17);     -- Mux para carregar inM ou %A
  muxALUI_A<= not(instruction(17));                -- Tipo de instrução

  -- Implementando valores da ULA:
  zx <= instruction(12) and instruction(17);
  nx <= instruction(11) and instruction(17);
  zy <= instruction(10) and instruction(17);
  ny <= instruction(9) and instruction(17);
  f  <= instruction(8) and instruction(17);
  no <= instruction(7) and instruction(17);
  
  -- Implementando loadPC:
  loadPC<= '1' when (instruction(2 downto 0)="001" and instruction(17)='1') and (zr='0' and ng='0') else       -- JG
           '1' when (instruction(2 downto 0)="010" and instruction(17)='1') and (zr='1' and ng='0') else       -- JE
           '1' when (instruction(2 downto 0)="100" and instruction(17)='1') and (zr='0' and ng='1') else       -- JL
           '1' when (instruction(2 downto 0)="011" and instruction(17)='1') and (ng='0') else                  -- JGE
           '1' when (instruction(2 downto 0)="101" and instruction(17)='1') and (zr='0') else                  -- JNE
           '1' when (instruction(2 downto 0)="110" and instruction(17)='1') and  (zr='1' or ng='1') else       -- JLE
           '1' when (instruction(2 downto 0)="111" and instruction(17)='1') else                               -- JMP
           '0';

  -- Impĺementando conceito B:
  loadS <= instruction(6) and instruction(17);  --Atribuindo a bit vazio;
  muxS <= instruction(15) and instruction(17);  -- VER

end architecture;
