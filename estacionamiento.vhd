
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

entity estacionamiento is
	port(
		clk,reset : in std_logic;
		a,b : in std_logic; -- estas estan estables
		en_p,up_p : out std_logic
	);
end estacionamiento;

architecture moore of estacionamiento is
	type state_type is (e0,e1,e2,e3,ef,s1,s2,s3,sf);
	signal state_req,state_next : state_type;

begin

-- registro de estado 
	process(clk,reset)
	begin
		if( reset='1') then
			state_req <= e0 ; 
		elsif(clk'event and clk='1') then 
			state_req <= state_next ; 
		end if;
	end process;
	
--------------------------------------------------------------------------
---------------------- Next state logic--------------------------------
	process(state_req,a,b)
	begin
		state_next <= state_req; -- por default
		case state_req is 
		
			when e0 => -- se va por alguna de las dos ramas
				if((a and not(b)) = '1') then 
					state_next <= e1 ; 
				elsif((not(a) and b) = '1') then
					state_next <= s1 ;
				end if;
				
			-- Rama de entrada
			when e1 =>
				if((a and b) = '1') then -- esta entrando
					state_next <= e2 ; 
				elsif((not(a)and not(b))='1') then -- se devolvio
					state_next <= e0 ;
				end if;
				
			when e2 =>
				if((not(a) and b)='1') then -- esta entrando
					state_next <= e3 ;
				elsif((a and not(b))='1') then -- se devolvio
					state_next <= e1 ; 
				end if;
				
			when e3 =>
				if((not(a)and not(b))='1')then -- entro!!! 
					state_next <= ef ; 
				elsif((a and b) = '1') then -- se devolvio
					state_next <= e2 ;
				end if;
			when ef =>--si llega aca, el estado ef estuvo activo 1 clk. 
				state_next <= e0 ;
				
				
			-- Rama de Salida	
			when s1 =>
				if((a and b) = '1')then -- esta saliendo
					state_next <= s2;
				elsif((not(a) and not(b))='1')then-- se devolvio
					state_next <= e0;
				end if;
				
			when s2 =>
				if((a and not(b))='1')then -- esta entrando
					state_next <= s3 ; 
				elsif((not(a) and b)='1')then -- se devolvio
					state_next <= s1 ;
				end if;
			
			when s3 =>
				if((not(a) and not(b))='1')then -- salio!!!
					state_next <= sf ;
				elsif((a and b)='1') then -- se devolvio
					state_next <= s2;
				end if;
			
			when sf =>
				state_next <= e0 ;
				
		end case;
	end process;
--------------------------------------------------------------------------
-------------------------- Output logic ----------------------------------
	process(state_req)
	begin
		case state_req is -- son los mismos codigos de contador para sumar o restar
			when ef => -- suma un auto
				en_p <= '1' ; 
				up_p <= '1' ; 	
			when sf => -- resta un auto
				en_p <= '1' ;
				up_p <= '0' ;
			when others => -- no hace nada
				en_p <= '0' ; 
				up_p <= '0' ; 
		end case;
	end process;

end moore;


