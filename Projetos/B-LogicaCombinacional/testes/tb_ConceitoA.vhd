-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_ConceitoA.vhd
-- date: 4/4/2017

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ConceitoA is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ConceitoA is

	component ConceitoA is
	port (
      CLOCK_50 : in  std_logic;
		SW       : in  std_logic_vector(9 downto 0);
        HEX0     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX1     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX2     : out std_logic_vector(6 downto 0); -- 7seg0
		LEDR     : out std_logic_vector(9 downto 0)
        );
	end component;

  signal  SW : STD_LOGIC_VECTOR(9 downto 0);
  signal  HEX0, HEX1, HEX2 : STD_LOGIC_VECTOR(6 downto 0);

  -- Clock
  constant CLK_PERIOD : time := 1 ns;
  signal clk : STD_LOGIC := '0';

begin

  u1: ConceitoA port map(clk, sw, hex0, hex1, hex2, open);

  clk_process :process
  begin
    clk <= '0';
    wait for clk_period/2;  --for 0.5 ns signal is '0'.
    clk <= '1';
    wait for clk_period/2;  --for next 0.5 ns signal is '1'.
  end process;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    sw <= "0000001010";
    wait for 10 ns;
    wait until clk='1' ;
    assert(hex2 = "0000001" and hex1 = "1001111" and hex0 = "00000001")  report "Falha em teste: 1" severity error;

    sw <= "0000010110"; -- 22
    wait for 10 ns;
    wait until clk='1' ;
    assert(hex2 = "0010010" and hex1 = "0010010" and hex0 = "00000001")  report "Falha em teste: 1" severity error;

    sw <= "0101001101"; -- 333
    wait for 10 ns;
    wait until clk='1' ;
    assert(hex2 = "0000110" and hex1 = "0000110" and hex0 = "0000110")  report "Falha em teste: 1" severity error;


    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;
