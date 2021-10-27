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
		loadA, loadD, loadM, loadPC : out STD_LOGIC               -- sinais de load do reg. A,
                                                                     -- reg. D, Mem. RAM e Program Counter
    );
end entity;

architecture arch of ControlUnit is

begin
  loadD<=instruction(17) and instruction(4);
  loadM<=instruction(17) and instruction(5);
  loadA<=not instruction(17) or instruction(3);

  muxALUI_A<=not instruction(17);

  zx<=instruction(17) and instruction(12); -- o bit 12 que indica o zx e o bit 17 que é do tipo C.
  nx<=instruction(17) and instruction(11); -- o bit 11 que indica o nx.
  zy<=instruction(17) and instruction(10); -- o bit 10 que indica o zy.
  ny<=instruction(17) and instruction(9); -- o bit 9 que indica o ny.
  f<=instruction(17) and instruction(8); -- o bit 8 que indica o f.
  no<=instruction(17) and instruction(7); -- o bit 7 que indica o no.

  muxAM<=instruction(17) and instruction(13);

  loadPC <= '1' when (instruction(17)='1' and instruction(2 downto 0)="001") and (ng='0' and zr='0') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="010") and (ng='0' and zr='1') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="100") and (ng='1' and zr='0') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="110") and (ng='1') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="110") and (zr='1') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="101") and (zr='0') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="011") and (ng='0') else
            '1' when (instruction(17)='1' and instruction(2 downto 0)="111") else
            '0';

end architecture;
