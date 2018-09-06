
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

entity max_min is
port(
	dig1,dig2,dig3,dig4 : in std_logic_vector( 3 downto 0) ;
	--en_p,up_p           : in std_logic;
	max_tick,min_tick   : out std_logic
);
end max_min;

architecture Behavioral of max_min is
	signal aux     : std_logic_vector(15 downto 0) ; 
	signal aux_max : std_logic_vector(15 downto 0);
	signal null_sig: std_logic_vector(15 downto 0);
	
begin
	null_sig <= (others=>'0');
	aux     <= (dig1 & dig2 & dig3 & dig4);
	aux_max <= ("1001" & "1001" & "1001" & "1001") ; 
	
	min_tick <= '1' when((aux = null_sig)) else
					'0';
					
	max_tick <= '1' when((aux = aux_max)) else
					'0';


end Behavioral;

