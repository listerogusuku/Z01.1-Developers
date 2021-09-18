-- Elementos de Sistemas
-- by Luciano Soares
-- Ram512.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity Ram512 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 8 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture arch of Ram512 is

	component Ram64 is
		port(
			clock:   in  STD_LOGIC;
			input:   in  STD_LOGIC_VECTOR(15 downto 0);
			load:    in  STD_LOGIC;
			address: in  STD_LOGIC_VECTOR( 5 downto 0);
			output:  out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component Mux8Way16 is
		port (
				a:   in  STD_LOGIC_VECTOR(15 downto 0);
				b:   in  STD_LOGIC_VECTOR(15 downto 0);
				c:   in  STD_LOGIC_VECTOR(15 downto 0);
				d:   in  STD_LOGIC_VECTOR(15 downto 0);
				e:   in  STD_LOGIC_VECTOR(15 downto 0);
				f:   in  STD_LOGIC_VECTOR(15 downto 0);
				g:   in  STD_LOGIC_VECTOR(15 downto 0);
				h:   in  STD_LOGIC_VECTOR(15 downto 0);
				sel: in  STD_LOGIC_VECTOR( 2 downto 0);
				q:   out STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component DMux8Way is
		port (
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC;
			q4:  out STD_LOGIC;
			q5:  out STD_LOGIC;
			q6:  out STD_LOGIC;
			q7:  out STD_LOGIC);
	end component;

	signal load0, load1, load2, load3, load4, load5, load6, load7 : STD_LOGIC;
	signal output0, output1, output2, output3, output4, output5, output6, output7 : STD_LOGIC_VECTOR(15 downto 0);

begin

--Controlam saídas e entradas de loads
mux: Mux8Way16 port map ( --seleciona saidas
a =>output0,
b =>output1,
c =>output2,
d =>output3,
e =>output4,
f =>output5,
g =>output6,
h =>output7,
sel => address(8 downto 6) ,
q=>output 
);

dmux: DMux8Way port map ( --seleciona multiplos loads
	a => load,
	sel => address(8 downto 6),
	q0 => load0,
	q1 => load1,
	q2 => load2,
	q3 => load3,
	q4 => load4,
	q5 => load5,
	q6 => load6,
	q7 => load7
	);
--8 ram's utilizadas
ram8_1: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load0,
	address => address(5 downto 0),
	output  =>  output0
);

ram8_2: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load1,
	address => address(5 downto 0),
	output =>  output1
);

ram8_3: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load2,
	address => address(5 downto 0),
	output =>  output2
);
ram8_4: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load3,
	address => address(5 downto 0),
	output =>  output3
);
ram8_5: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load4,
	address => address(5 downto 0),
	output =>  output4
);
ram8_6: Ram64 port map(
	clock =>  clock,
	input =>   input,
	load =>    load5,
	address => address(5 downto 0),
	output =>  output5
);
ram8_7: Ram64 port map(
clock =>  clock,
input =>   input,
load =>    load6,
address => address(5 downto 0),
output =>  output6
);

ram8_8: Ram64 port map(
clock =>  clock,
input =>   input,
load =>    load7,
address => address(5 downto 0),
output =>  output7
);
end architecture;
