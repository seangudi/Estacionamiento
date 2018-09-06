
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

entity time_display is
port(
	clk,reset : in std_logic;
	dig1,dig2,dig3,dig4 : in std_logic_vector(3 downto 0);
	c : in std_logic_vector(18 downto 0); -- este es el que trae el numero 
	min_tick,max_tick : in std_logic; -- estos son para mandar el codigo de F U L L o rayita
	num : out std_logic_vector(3 downto 0);
	an : out std_logic_vector(3 downto 0);
	start : out std_logic -- este resetea el time_control cuando se refresca una vez el display
);
end time_display;

architecture Behavioral of time_display is
--	signal c1,c2,c3,c4 : std_logic_vector(18 downto 0) ; -- estos son los limites donde se producen los cambios
	signal c_aux : unsigned(18 downto 0);
	signal an_reg,an_next,num_reg,num_next : std_logic_vector(3 downto 0);
	signal start_reg,start_next : std_logic;

begin

-- registro de estado 
	process(clk,reset)
	begin
		if( reset='1') then
			an_reg    <= "1111" ;   -- todos apagados
			num_reg   <= "0000" ;
			start_reg <= '1' ; 		-- este reseta el contador de time_control			
		elsif(clk'event and clk='1') then
			an_reg <= an_next ;
			num_reg <= num_next ;
			start_reg <= start_next;
		end if;
	end process;
	
---------------------- NEXT STATE LOGIC ----------------------

-- defino los limites del contador c que me da time_control
c_aux <= unsigned(c) ;

start_next <= '1' when(c_aux = 400000) else
				  '0' ;
an_next <=  "1110" when(c_aux<100000) else
				"1101" when(c_aux<200000 and c_aux>=100000) else
				"1011" when(c_aux<300000 and c_aux>=200000) else
				"0111" when(c_aux<400000 and c_aux>=300000) else
				an_reg; 

num_next <= "1101" when(min_tick = '1') else -- mando codigo de rayita
				"1100" when(max_tick='1' and c_aux<200000 ) else -- codigo de L
				"1110" when(max_tick='1' and c_aux<300000 and c_aux>=200000) else -- codigo de U
				"1111" when(max_tick='1' and c_aux<400000 and c_aux>=300000) else -- codigo de F
				dig1 when(c_aux<100000) else
				dig2 when(c_aux<200000 and c_aux>=100000) else
				dig3 when(c_aux<300000 and c_aux>=200000) else
				dig4 when(c_aux<400000 and c_aux>=300000) else
				num_reg;
----------------------------------- OUTPUT LOGIC -----------------------------------

start <= start_reg ;
an    <= an_reg ;
num   <= num_reg;


end Behavioral;

