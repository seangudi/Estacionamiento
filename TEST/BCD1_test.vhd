
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY BCD1_test IS
END BCD1_test;
 
ARCHITECTURE behavior OF BCD1_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCD1
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         en_in : IN  std_logic;
         up_in : IN  std_logic;
         max_tick : IN  std_logic;
         min_tick : IN  std_logic;
         en_out : OUT  std_logic;
         up_out : OUT  std_logic;
         digito : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal en_in : std_logic := '0';
   signal up_in : std_logic := '0';
   signal max_tick : std_logic := '0';
   signal min_tick : std_logic := '0';

 	--Outputs
   signal en_out : std_logic;
   signal up_out : std_logic;
   signal digito : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCD1 PORT MAP (
          clk => clk,
          reset => reset,
          en_in => en_in,
          up_in => up_in,
          max_tick => max_tick,
          min_tick => min_tick,
          en_out => en_out,
          up_out => up_out,
          digito => digito
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
		-- miro que el reset funcione
		reset <= '1';
		wait for 15 ns;
		assert(digito="0000") report "---------------- NO RESETEA ---------------" severity failure ;
		
		wait until falling_edge(clk);
	   reset <= '0';
		
		en_in <= '1';
		up_in <= '1';
		max_tick <= '0';
		min_tick <= '0';
		
		wait for clk_period; -- subi digito hasta 1
		
		for k in 1 to 9 loop --lo subo hasta el 8
			if(k < 9) then
				assert( digito=std_logic_vector(to_unsigned(k,4)) )report "------------ no cuenta bien subiendo ---------" severity failure;
				assert((en_out or up_out)='0') report "--------- manda al siguiente subir o bajar por error" severity failure;
				wait for clk_period;
			else
				assert(digito="1001") report "------ NO LLEGO AL 9 :C -----------" severity failure;
				assert((en_out and up_out)='1') report "-------- NO LE DICE AL SIGUIENTE QUE SUBA ------------ " severity failure ;
			end if;
		end loop;-- aca el digito esta en "9" me fijo si le avisa al siguiente si subir o bajar
		
			wait for clk_period;
		assert(digito="0000") report "----------- no da la vuelta 0 -> 9---------------" severity failure;
		--assert((en_out and not(up_out))='1') report "NO LE DICE AL SIGUENTE QUE BAJE" severity failure;
		-- si llega hasta aca, digito esta en "0000"
		
		-- lo subo a 9 para luego bajar
		
	   for k in 0 to 8 loop -- subo digito hasta 9
			assert(digito=std_logic_vector(to_unsigned(k,4))) report "------------ no cuenta bien subiendo ---------" severity failure;
			wait for clk_period;
		end loop;-- aca el digito esta en "9"
		
		-- VAMOS A BAJAR
		up_in <= '0';
		for k in 0 to 8 loop
				assert(digito=std_logic_vector(to_unsigned(9-k,4))) report "------------ no cuenta bien bajando ---------" severity failure;
				wait for clk_period;
		end loop;-- aca el digito esta en "0" me fijo si vuelve al "9" y avisa al siguiente que baje
		assert(digito="0000") report "---------- no da la vuelta bien 9 -> 0 ------------------" severity failure;
		assert((en_out and not(up_out))='1') report "-------- NO LE DICE AL SIGUIENTE QUE BAJE ------------ " severity failure ;
		wait for clk_period; -- aca esta en 9
		
		--------- vemos si los numeros se quedan estaticos con el max y min 
		-- aca digito = "1001"
		
		max_tick <='1'  ; 
		up_in    <= '1' ;
		
		wait for 10*clk_period;
		assert(digito="1001") report "------------NO SE QUEDO EN 9 CON EL MAX_TICK----------------" severity failure;
		
		max_tick <= '0' ;
		min_tick <= '1' ;
		up_in <= '0';
		
		--bajamos nuevamente
		for k in 0 to 8 loop 
				assert(digito=std_logic_vector(to_unsigned(9-k,4))) report "------------ no cuenta bien bajando ---------" severity failure;
				wait for clk_period;
		end loop;-- aca el digito esta en "0" 
		
		wait for 10*clk_period;
		assert(digito="0000") report "---------- NO SE QUEDO EN 0 CON EL MIN_TICK------------------" severity failure;
		-- si llega hasta aca, el digito esta en "0000"
		
		
		
			assert false report "---------------- EXITO ----------------" severity failure;
   end process;

END;
