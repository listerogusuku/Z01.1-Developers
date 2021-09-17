-- Elementos de Sistemas
-- by Luciano Soares
-- ALU.vhd

-- Unidade Lógica Aritmética (ULA)
-- Recebe dois valores de 16bits e
-- calcula uma das seguintes funções:
-- X+y, x-y, y-x, 0, 1, -1, x, y, -x, -y,
-- X+1, y+1, x-1, y-1, x&y, x|y
-- De acordo com os 6 bits de entrada denotados:
-- zx, nx, zy, ny, f, no.
-- Também calcula duas saídas de 1 bit:
-- Se a saída == 0, zr é definida como 1, senão 0;
-- Se a saída <0, ng é definida como 1, senão 0.
-- a ULA opera sobre os valores, da seguinte forma:
-- se (zx == 1) então x = 0
-- se (nx == 1) então x =! X
-- se (zy == 1) então y = 0
-- se (ny == 1) então y =! Y
-- se (f == 1) então saída = x + y
-- se (f == 0) então saída = x & y
-- se (no == 1) então saída = !saída
-- se (out == 0) então zr = 1
-- se (out <0) então ng = 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_AB is
	port (
			x,y:   in STD_LOGIC_VECTOR(15 downto 0); -- entradas de dados da ALU
			zx:    in STD_LOGIC;                     -- zera a entrada x
			nx:    in STD_LOGIC;                     -- inverte a entrada x
			zy:    in STD_LOGIC;                     -- zera a entrada y
			ny:    in STD_LOGIC;                     -- inverte a entrada y
			f1:    in STD_LOGIC;                     -- se 0 calcula x & y, senão x + y
			f2:	   in STD_LOGIC;                     -- retorna o resultado o mux1 (caso 0) ou retorna X xor Y;
			s:     in STD_LOGIC;  					 -- shifter /left/right/
			ss:    in  std_logic_vector(2 downto 0); -- shift amount
			no:    in STD_LOGIC;                     -- inverte o valor da saída
			zr:    out STD_LOGIC;                    -- setado se saída igual a zero
			ng:    out STD_LOGIC;                    -- setado se saída é negativa
			saida: out STD_LOGIC_VECTOR(15 downto 0); -- saída de dados da ALU
			estouro: out STD_LOGIC  -- Adicionando Carry
	);
end entity;

architecture  rtl OF ALU_AB is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.

	signal x_Zerador : STD_LOGIC_VECTOR(15 downto 0);
	signal y_Zerador : STD_LOGIC_VECTOR(15 downto 0);
	signal x_Inversor : STD_LOGIC_VECTOR(15 downto 0);
	signal y_Inversor : STD_LOGIC_VECTOR(15 downto 0);
	signal operacaoMux1 : STD_LOGIC_VECTOR(15 downto 0);
	signal operacaoMux2 : STD_LOGIC_VECTOR(15 downto 0);
	signal saidaADD: STD_LOGIC_VECTOR(15 downto 0);
	signal saidaAND: STD_LOGIC_VECTOR(15 downto 0);
	signal carry: STD_LOGIC_VECTOR(15 downto 0);   
	signal entrada_shifter: STD_LOGIC_VECTOR(15 downto 0);  
	signal saida_shifter: STD_LOGIC_VECTOR(15 downto 0);   
	signal size1: STD_LOGIC_VECTOR(2 downto 0); 
	
	component BarrelShifter16 IS
		port(
			a:    in  STD_LOGIC_VECTOR(15 downto 0);   -- input vector
			dir:  in  std_logic;                       -- 0=>left 1=>right
			size: in  std_logic_vector(2 downto 0);    -- shift amount
			q:    out STD_LOGIC_VECTOR(15 downto 0)  -- output vector (shifted)
			);
	end component;-- Adicionando Carry

	component zerador16 IS
		port(z   : in STD_LOGIC;
			 a   : in STD_LOGIC_VECTOR(15 downto 0);
			 y   : out STD_LOGIC_VECTOR(15 downto 0)
			);
	end component;

	component inversor16 is
		port(z   : in STD_LOGIC;
			 a   : in STD_LOGIC_VECTOR(15 downto 0);
			 y   : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component Add16B is
		port(
			a   :  in STD_LOGIC_VECTOR(15 downto 0);
			b   :  in STD_LOGIC_VECTOR(15 downto 0);
			q   : out STD_LOGIC_VECTOR(15 downto 0);
			carry_out : out STD_LOGIC_VECTOR(15 downto 0)                                                 --Adicioanndo Carry de saúda
		);
	end component;

	component And16 is
		port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component comparador16 is
		port(
			a   : in STD_LOGIC_VECTOR(15 downto 0);
			zr   : out STD_LOGIC;
			ng   : out STD_LOGIC
    );
	end component;

	component Mux16 is
		port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

   SIGNAL zxout,zyout,nxout,nyout,andout,adderout,muxout,precomp: std_logic_vector(15 downto 0);

begin
  -- Implementação vem aqui!

-- Zerador x:	
	zeradorX: zerador16 port map (
		z => zx,
		a => x,
		y => x_Zerador
	);

	-- Zerador y:	
	zeradorY: zerador16 port map (
		z => zy,
		a => y,
		y => y_Zerador
	);
	
	-- Inversorsor X
	inversorX: inversor16 port map (
		z  => nx,
		a  => x_Zerador,
		y  => x_Inversor 
	);

	--Inversor Y
	inversorY: inversor16 port map (
		z  => ny,
		a  => y_Zerador,
		y  => y_Inversor 
	);

	-- And
	andPort: And16 port map (
		a =>  x_Inversor,
		b =>  y_Inversor,
		q => saidaAND
	);

	-- Add

	addPort: Add16B port map (
		a =>  x_Inversor,
		b =>  y_Inversor,
		q => saidaADD,
		carry_out =>  carry                                                        -- Adicionando Carry
	);

	-- Multiplexador:

	mux1: Mux16 port map (
		a =>   saidaAND,
		b =>   saidaADD,
		sel => f1, 
		q => operacaoMux1 
	);

	mux2: Mux16 port map (
		a =>   operacaoMux1,
		b =>  (x xor y),
		sel => f2, 
		q => operacaoMux2
	);

	--Inversor/ Saída:
	inversor: inversor16 port map(
		z  => no,
		a  => operacaoMux2,                       
		y  => precomp 
	);

	-- Comparador: Troca saida para o shifter
	comparador: comparador16 port map(
		a   => saida_shifter,
		zr  =>  zr,
		ng  => ng
	);

	-- Adicionando Carry:
	estouro <= '1' when (f1='1' AND f2='0' AND carry(15)='1') else
			   '0';

	Shifter : BarrelShifter16 port map (precomp,s,ss,saida_shifter);	   

	-- retoma saída normal
	saida <= saida_shifter;

end architecture;

