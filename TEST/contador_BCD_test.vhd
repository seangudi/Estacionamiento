--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY contador_BCD_test IS
END contador_BCD_test;
 
ARCHITECTURE behavior OF contador_BCD_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador_BCD
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         en_p : IN  std_logic;
         up_p : IN  std_logic;
         min_tick : IN  std_logic;
         max_tick : IN  std_logic;
         dig1 : OUT  std_logic_vector(3 downto 0);
         dig2 : OUT  std_logic_vector(3 downto 0);
         dig3 : OUT  std_logic_vector(3 downto 0);
         dig4 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal en_p : std_logic := '0';
   signal up_p : std_logic := '0';
   signal min_tick : std_logic := '0';
   signal max_tick : std_logic := '0';

 	--Outputs
   signal dig1 : std_logic_vector(3 downto 0);
   signal dig2 : std_logic_vector(3 downto 0);
   signal dig3 : std_logic_vector(3 downto 0);
   signal dig4 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador_BCD PORT MAP (
          clk => clk,
          reset => reset,
          en_p => en_p,
          up_p => up_p,
          min_tick => min_tick,
          max_tick => max_tick,
          dig1 => dig1,
          dig2 => dig2,
          dig3 => dig3,
          dig4 => dig4
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	-- vamos a contar para arriba
		max_tick <= '0';
		min_tick <= '0';
		
				-- miro que el reset funcione
		reset <= '1';
		wait for 15 ns;
		assert(dig1="0000" and dig2="0000" and dig3="0000" and dig4="0000") report "---------------- NO RESETEA ---------------" severity failure ;
		
		wait until falling_edge(clk);
	   reset <= '0';
			
		en_p <= '1' ; 
		up_p <= '1' ;
		
		for k4 in 0 to 9 loop
			for k3 in 0 to 9 loop
				for k2 in 0 to 9 loop
					for k1 in 0 to 9 loop
						assert(dig1 = std_logic_vector(to_unsigned(k1,4))) report "------ CUENTA MAL DIG 1:S ------" severity failure;
						assert(dig2 = std_logic_vector(to_unsigned(k2,4))) report "------ CUENTA MAL DIG 2:S ------" severity failure;
						assert(dig3 = std_logic_vector(to_unsigned(k3,4))) report "------ CUENTA MAL DIG 3:S ------" severity failure;
						assert(dig4 = std_logic_vector(to_unsigned(k4,4))) report "------ CUENTA MAL DIG 4:S ------" severity failure;
						wait for clk_period;
					end loop;
				end loop;
			end loop;
		end loop; -- si llega hasta aca deberia estar  todo en 0
		
		assert(dig1="0000" and dig2="0000" and dig3="0000" and dig4="0000") report "---------------- NO dio la vuelta subiendo ---------------" severity failure ;
		
		-- miremos si respea min_tick
		
		up_p <= '0' ; -- le resto al "0"
		min_tick <= '1' ; -- pero este no le deja bajar mas.
		wait for 10*clk_period; -- no deberia bajar mas de 0
		assert(dig1="0000" and dig2="0000" and dig3="0000" and dig4="0000") report "---------------- NO RESPETA MIN_TICK ---------------" severity failure ;
		min_tick <='0';
		
		
		-- lo subimos hasta 9999
		up_p <='1';
		wait for 9999*clk_period;
		assert(dig1="1001" and dig2="1001" and dig3="1001" and dig4="1001") report "---------------- RAIOZ ---------------" severity failure ;
		
		-- miremos si repeta el max_tick
		up_p <= '1' ; -- le sumo 
		max_tick <='1'; -- pero este no le deja
		wait for 10*clk_period;
		assert(dig1="1001" and dig2="1001" and dig3="1001" and dig4="1001") report "---------------- NO RESPETA max_tick ---------------" severity failure ;
		max_tick <='0' ;

		up_p<= '0' ; -- vamos a bajar
		
		-- aca sigo en "9999"
		
		--wait for 10*clk_period;
		for k4 in 0 to 9 loop
			for k3 in 0 to 9 loop
				for k2 in 0 to 9 loop
					for k1 in 0 to 9 loop
						assert(dig1 = std_logic_vector(to_unsigned(9-k1,4))) report "------ CUENTA MAL DIG 1:B ------" severity failure;
						assert(dig2 = std_logic_vector(to_unsigned(9-k2,4))) report "------ CUENTA MAL DIG 2:B ------" severity failure;
						assert(dig3 = std_logic_vector(to_unsigned(9-k3,4))) report "------ CUENTA MAL DIG 3:B ------" severity failure;
						assert(dig4 = std_logic_vector(to_unsigned(9-k4,4))) report "------ CUENTA MAL DIG 4:B ------" severity failure;
						wait for clk_period;
					end loop;
				end loop;
			end loop;
		end loop; 
		
		
		assert false report " ------------ EXITO ------------------" severity failure;




   end process;

END;
