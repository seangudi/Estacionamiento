
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

entity time_control is
port(
	clk,reset : in std_logic ; 
	c_out     : out std_logic_vector(18 downto 0) -- necesito 19 bits para contar hasta 400000
);
end time_control;

architecture Behavioral of time_control is
signal c_reg,c_next : std_logic_vector(18 downto 0);

begin
-- registro de estado 
	process(clk,reset)
	begin
		if( reset='1') then
			c_reg <= std_logic_vector(to_unsigned(0,19)) ; 
		elsif(clk'event and clk='1') then
			c_reg <= c_next ;
		end if;
	end process;
	
---------------------- NEXT STATE LOGIC ----------------------

c_next <= std_logic_vector(unsigned(c_reg)+1);

--------------------- OUTPUT LOGIC ---------------------

c_out <= c_reg ; 



end Behavioral;

