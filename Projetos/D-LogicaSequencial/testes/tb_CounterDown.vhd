-- Elementos de Sistemas
-- tb_CounterDown.vhd

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_CounterDown is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_CounterDown is

	component CounterDown is
    port(
      clock:  in std_logic;
      q:      out std_logic_vector(2 downto 0)
      );
	end component;

	signal clk : std_logic := '0';
  signal q   : std_logic_vector(2 downto 0);

begin

	mapping: CounterDown port map(clk, q);

	clk <= not clk after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    -- -- IMPLEMENTE AQUI!

    --vetor q já começa com '000', assim a cada ciclo do relogio basta conferir a alternancia da contagem
     wait until clk'event and clk='0';
     assert(q = "111")  report "Teste 0: Esperava-se 111" severity error;
 
     wait until clk'event and clk='0';
     assert(q = "110")  report "Teste 1: Esperava-se 110" severity error;

     wait until clk'event and clk='0';
     assert(q = "101")  report "Teste 2: Esperava-se 101" severity error;
 
     wait until clk'event and clk='0';
     assert(q = "100")  report "Teste 3: Esperava-se 100" severity error;
 
    -- finish
    wait until clk'event and clk='0';
    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
