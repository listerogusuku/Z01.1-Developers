-- Elementos de Sistemas
-- by Luciano Soares
-- Add16.vhd

-- Soma dois valores de 16 bits
-- ignorando o carry mais significativo

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16B is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
    q   : out STD_LOGIC_VECTOR(15 downto 0);
    carry_out: out  STD_LOGIC_VECTOR(15 downto 0)                                         -- Adicionando Carry para Conceito B
	);
end entity;

architecture rtl of Add16B is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.

  --signal carry_out:  STD_LOGIC_VECTOR(15 downto 0);

  component FullAdder is
    port(
      a,b,c:      in STD_LOGIC;   -- entradas
      soma,vaium: out STD_LOGIC   -- sum e carry
    );
  end component;

begin
  -- Implementação vem aqui!

adder1: FullAdder port map(
  a=> a(0),
  b=> b(0),
  c=> '0',
  soma => q(0),
  vaium => carry_out(0)
);

adder2: FullAdder port map(
  a=> a(1),
  b=> b(1),
  c=> carry_out(0),
  soma => q(1),
  vaium => carry_out(1)
);

adder3: FullAdder port map(
  a=> a(2),
  b=> b(2),
  c=> carry_out(1),
  soma => q(2),
  vaium => carry_out(2)
);

adder4: FullAdder port map(
  a=> a(3),
  b=> b(3),
  c=> carry_out(2),
  soma => q(3),
  vaium => carry_out(3)
);

adder5: FullAdder port map(
  a=> a(4),
  b=> b(4),
  c=> carry_out(3),
  soma => q(4),
  vaium => carry_out(4)
);

adder6: FullAdder port map(
  a=> a(5),
  b=> b(5),
  c=> carry_out(4),
  soma => q(5),
  vaium => carry_out(5)
);

adder7: FullAdder port map(
  a=> a(6),
  b=> b(6),
  c=> carry_out(5),
  soma => q(6),
  vaium => carry_out(6)
);

adder8: FullAdder port map(
  a=> a(7),
  b=> b(7),
  c=> carry_out(6),
  soma => q(7),
  vaium => carry_out(7)
);

adder9: FullAdder port map(
  a=> a(8),
  b=> b(8),
  c=> carry_out(7),
  soma => q(8),
  vaium => carry_out(8)
);

adder10: FullAdder port map(
  a=> a(9),
  b=> b(9),
  c=> carry_out(8),
  soma => q(9),
  vaium => carry_out(9)
);

adder11: FullAdder port map(
  a=> a(10),
  b=> b(10),
  c=> carry_out(9),
  soma => q(10),
  vaium => carry_out(10)
);

adder12: FullAdder port map(
  a=> a(11),
  b=> b(11),
  c=> carry_out(10),
  soma => q(11),
  vaium => carry_out(11)
);

adder13: FullAdder port map(
  a=> a(12),
  b=> b(12),
  c=> carry_out(11),
  soma => q(12),
  vaium => carry_out(12)
);

adder14: FullAdder port map(
  a=> a(13),
  b=> b(13),
  c=> carry_out(12),
  soma => q(13),
  vaium => carry_out(13)
);

adder15: FullAdder port map(
  a=> a(14),
  b=> b(14),
  c=> carry_out(13),
  soma => q(14),
  vaium => carry_out(14)
);

adder16: FullAdder port map(
  a=> a(15),
  b=> b(15),
  c=> carry_out(14),
  soma => q(15),
  vaium => carry_out(15)
);

end architecture;
