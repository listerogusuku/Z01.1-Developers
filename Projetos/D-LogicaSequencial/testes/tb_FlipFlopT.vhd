-- Elementos de Sistemas
-- tb_A-FlipFlopT.vhd

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_FlipFlopT is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_FlipFlopT is

	component FlipFlopT is
    port(
      clock:  in std_logic;
      t:      in std_logic;
      q:      out std_logic:= '0';
      notq:   out std_logic:= '1'
      );
	end component;

	signal clk : std_logic := '0';
  signal t,q,notq : std_logic;

begin

	mapping: FlipFlopT port map(clk, t, q, notq);

	clk <= not clk after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    -- IMPLEMENTE AQUI!

    t <='0'; --t com entrada falsa, clock ativado , saidas esperadas como inalteradas
    wait until clk'event and clk='0';
    assert(q='0' and notq='1')  report "Falha em teste: Saídas não inalteradas" severity error;

    t <='0'; --t com entrada falsa, clock não ativado , saidas esperadas como inalteradas
    wait until clk'event and clk='0';
    assert(q='0' and notq='1')  report "Falha em teste: Saídas não inalteradas" severity error;

    t <='1'; --t com entrada falsa, clock ativado , saidas esperadas como invertidas
    wait until clk'event and clk='0';
    assert(q='1' and notq='0')  report "Falha em teste: Saídas não inalteradas" severity error;

    t <='1'; --t com entrada falsa, clock não ativado , saidas esperadas como inalteradas
    wait until clk'event and clk='0';
    assert(q='0' and notq='1')  report "Falha em teste: Saídas não invertidas" severity error;

    -- finish
    wait until clk'event and clk='0';
    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
