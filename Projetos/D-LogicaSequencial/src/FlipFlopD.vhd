-- Elementos de Sistemas
-- by Luciano Soares
-- FlipFlopD.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:      out std_logic := '0'
	);
end entity;

architecture arch of FlipFlopD is

begin
	process(clock, clear, preset) begin
		if (clear = '1') then
			q <='0';                -- Quando clear = 1 . Saída igual a 0 (Independente do clock)
		elsif (preset = '1') then
			q<='1'; 				-- Quando present = 1 . Saída igual a 1 (Independente do clock)
		elsif (rising_edge(CLOCK)) then
			q<=D;                   -- Clock na suubida saída = input
		end if;
  end process;
end architecture;
