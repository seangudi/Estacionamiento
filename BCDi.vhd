
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

entity BCD1 is
	port(
		clk,reset : in std_logic;
		en_in,up_in : in std_logic; 
		max_tick,min_tick : in std_logic;
		en_out,up_out : out std_logic;
		digito 		  : out std_logic_vector(3 downto 0)
	);
end BCD1;

architecture Behavioral of BCD1 is
	signal dig_reg,dig_next : std_logic_vector(3 downto 0);
	signal temp_out 			: std_logic_vector(1 downto 0);

begin

-- registro de estado 
	process(clk,reset)
	begin
		if( reset='1') then
			dig_reg <= "0000" ; 
		elsif(clk'event and clk='1') then
			dig_reg <= dig_next ;
		end if;
	end process;
	
---------------------- NEXT STATE LOGIC ----------------------


dig_next <= std_logic_vector(unsigned(dig_reg)+1) when((en_in and up_in )='1' and dig_reg/="1001") else
				"0000" 										  when((en_in and up_in )='1' and max_tick='0') else -- como no hay max_tick, puedo subir 9->0
				std_logic_vector(unsigned(dig_reg)-1) when((en_in and not(up_in))='1' and dig_reg/="0000") else
				"1001" 										  when((en_in and not(up_in))='1' and min_tick='0') else
				dig_reg ; 

---------------------- OUTPUT LOGIC ---------------------------
	digito <= dig_reg ; 
	temp_out <= "11" when(en_in ='1' and up_in='1' and dig_reg="1001") else
					"10" when(en_in ='1' and up_in='0' and dig_reg="0000") else
					"00" ;
	en_out <= temp_out(1);
	up_out <= temp_out(0);
	   
end Behavioral;