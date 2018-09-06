
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Estacionamiento_test IS
END Estacionamiento_test;
 
ARCHITECTURE behavior OF Estacionamiento_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT estacionamiento
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  std_logic;
         b : IN  std_logic;
         en_p : OUT  std_logic;
         up_p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal en_p : std_logic;
   signal up_p : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: estacionamiento PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          b => b,
          en_p => en_p,
          up_p => up_p
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
		wait for 15 ns; -- esto es para que vaya al estado inicial e0	
		
		wait until falling_edge(clk);
	   reset <= '0'; -- vamos a empezar
		
		--------- ENTRA UN AUTO 
		a <= '0';
		b <= '0';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e0 -> e1 ---------------" severity failure ;
		a <= '1';
		b <= '0';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e1 -> e2 ---------------" severity failure ;
		a <= '1';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e2 -> e3 ---------------" severity failure ;
		a <= '0';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e3 -> e4 ---------------" severity failure ;
		a <= '0';
		b <= '0';
		--assert((en_p and up_p) = '1')  report "-------------- NO REPORTA ENTRADA ---------------" severity failure ;
		wait for clk_period ;
		assert((en_p and up_p) = '1')  report "-------------- NO REPORTA ENTRADA ---------------" severity failure ;
		
		-------- SALE UN AUTO
		a <= '0';
		b <= '0';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e0 -> e1 ---------------" severity failure ;
		a <= '0';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e1 -> e2 ---------------" severity failure ;
		a <= '1';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e2 -> e3 ---------------" severity failure ;
		a <= '1';
		b <= '0';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- MAL: e3 -> e4 ---------------" severity failure ;
		a <= '0';
		b <= '0';
		wait for clk_period ;
		assert((en_p and not(up_p)) = '1')  report "-------------- NO REPORTA SALIDA ---------------" severity failure ;
		
		-- auto que no decide si entar o salir (no completa la secuencia) SIEMPRE TIENE QUE DECIR QUE NO ENTRA NI SALE NADA
		a <= '0';
		b <= '0';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;
		a <= '0';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;
		a <= '0';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;
		a <= '1';
		b <= '1';
		wait for clk_period ;
		assert((en_p or up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;
		a <= '0';
		b <= '1';
		wait for clk_period ;
		assert((en_p and up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;
		a <= '0';
		b <= '0';
		wait for clk_period ;
		assert((en_p and up_p) = '0')  report "-------------- xxxxxxxxxxxxxx ---------------" severity failure ;		
				
				
		
		assert false report"------------ EXITO --------------------" severity failure ;
   end process;

END;

