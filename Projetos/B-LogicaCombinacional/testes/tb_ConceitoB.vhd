-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_ConceitoB.vhd
-- date: 4/4/2017

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ConceitoB is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ConceitoB is

	component ConceitoB is
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

  u1: ConceitoB port map('0', sw, hex0, hex1, hex2, open);

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

    -- Teste: 1
    sw <= "0000000000";
    wait until clk='1' ;
    assert(hex2 = "0000001" and hex1 = "0000001" and hex0 = "0000001")  report "Falha em teste: 1" severity error;

    sw <= "0000001111";
    wait until clk='1' ;
    assert(hex2 = "0111000" and hex1 = "0000001" and hex0 = "0000001")  report "Falha em teste: 1" severity error;

    sw <= "0011110000";
    wait until clk='1' ;
    assert(hex2 = "0000001" and hex1 = "0111000" and hex0 = "0000001")  report "Falha em teste: 1" severity error;

    sw <= "0111110000";
    wait until clk='1' ;
    assert(hex2 = "0000001" and hex1 = "0111000" and hex0 = "1001111")  report "Falha em teste: 1" severity error;

    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;
