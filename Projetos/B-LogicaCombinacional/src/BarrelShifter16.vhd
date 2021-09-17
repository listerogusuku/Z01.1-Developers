library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BarrelShifter16 is
	port ( 
			a:    in  STD_LOGIC_VECTOR(15 downto 0);   -- input vector
			dir:  in  std_logic;                       -- 0=>left 1=>right
			size: in  std_logic_vector(2 downto 0);    -- shift amount
			q:    out STD_LOGIC_VECTOR(15 downto 0));  -- output vector (shifted)
end entity;

--Referencia:https://hardwarecoder.com/qa/194/shift-left-in-vhdl
architecture rtl of BarrelShifter16 is
begin 
	q <= a(8 downto 0) & "0000000" when (dir = '0' and size = "111") else --shift 7 bits direita
	a(9 downto 0) & "000000" when (dir = '0' and size = "110") else --shift 6 bits direita
	a(10 downto 0) & "00000" when (dir = '0' and size = "101") else --shift 5 bits direita
	a(11 downto 0) & "0000" when (dir = '0' and size = "100") else --shift 4 bits direita
	a(12 downto 0) & "000" when (dir = '0' and size = "011") else --shift 3 bits direita
	a(13 downto 0) & "00" when (dir = '0' and size = "010") else --shift 2 bits direita
	a(14 downto 0) & '0' when (dir = '0' and size = "001") else --shift 1 bit1 direita
	"0000000" & a(15 downto 7) when (dir = '1' and size = "111") else--shift 7 bits esquerda
	"000000" & a(15 downto 6) when (dir = '1' and size = "110") else --shift 6 bits direita
	"00000" & a(15 downto 5) when (dir = '1' and size = "101") else --shift 5 bits direita
	"0000" & a(15 downto 4) when (dir = '1' and size = "100") else --shift 4 bits direita
	"000" & a(15 downto 3) when (dir = '1' and size = "011") else--shift 3 bits direita
	"00" & a(15 downto 2) when (dir = '1' and size = "010") else--shift 2 bits direita
	'0' & a(15 downto 1) when (dir = '1' and size = "001") else--shift 1 bits direita
	a;--mantém
	
end architecture;

