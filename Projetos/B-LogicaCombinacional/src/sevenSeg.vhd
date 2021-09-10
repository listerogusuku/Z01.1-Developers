library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenSeg is
	port (
			bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			leds: out STD_LOGIC_VECTOR(6 downto 0));
end entity;

architecture arch of sevenSeg is
begin

leds <= "0000001" when bcd = "0000" else -- numero 0
	"1001111" when bcd = "0001" else -- numero 1 
	"0101101" when bcd = "0010" else -- numero 2
	"0000110" when bcd = "0011" else -- numero 3
	"1001100" when bcd = "0100" else --numero 4
	"0100100" when bcd = "0101" else --numero 5
	"0100000" when bcd = "0110" else -- numero 6
	"0001111" when bcd = "0111" else --numero 7
	"0000000" when bcd = "1000" else --numero 8
	"0000100" when bcd = "1001" else --numero 9
	"0001000" when bcd ="1010" else -- digito A (10)
	"1100000" when bcd ="1011" else -- digito B (11)
	"0110001" when bcd ="1100" else -- digito C (12)
	"1000011" when bcd ="1101" else -- digito D (13)
	"0110000" when bcd ="1110" else -- digito E (14)
	"0111000" when bcd ="1111" else -- digito F (15)
	"1111111";                      --Leds desligados.

end architecture;
