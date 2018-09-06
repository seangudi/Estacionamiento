
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sseg_p is
	port(
		num_out : in std_logic_vector(3 downto 0);
		sseg 	  : out std_logic_vector(7 downto 0)
	);
end sseg_p;

architecture Behavioral of sseg_p is

begin
	sseg(7) <= '1' ; -- punto del led apagado

	sseg(6 downto 0) <= "0111111" when(num_out = "1101") else -- rayita de vacio
			  "1000000" when(num_out = "0000" ) else
			  "1111001" when(num_out = "0001" ) else
			  "0100100" when(num_out = "0010" ) else
			  "0110000" when(num_out = "0011" ) else
			  "0011001" when(num_out = "0100" ) else
			  "0010010" when(num_out = "0101" ) else
			  "0000010" when(num_out = "0110" ) else
			  "1111000" when(num_out = "0111" ) else
			  "0000000" when(num_out = "1000" ) else
			  "0011000" when(num_out = "1001" ) else
			  "0001110" when(num_out = "1111" ) else -- F
			  "1000001" when(num_out = "1110" ) else -- U
			  "1000111" ;    -- L
	
end Behavioral;

