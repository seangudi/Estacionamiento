
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY max_min_test IS
END max_min_test;
 
ARCHITECTURE behavior OF max_min_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT max_min
    PORT(
         dig1 : IN  std_logic_vector(3 downto 0);
         dig2 : IN  std_logic_vector(3 downto 0);
         dig3 : IN  std_logic_vector(3 downto 0);
         dig4 : IN  std_logic_vector(3 downto 0);
         en_p : IN  std_logic;
         up_p : IN  std_logic;
         max_tick : OUT  std_logic;
         min_tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal dig1 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig2 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig3 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig4 : std_logic_vector(3 downto 0) := (others => '0');
   signal en_p : std_logic := '0';
   signal up_p : std_logic := '0';

 	--Outputs
   signal max_tick : std_logic;
   signal min_tick : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: max_min PORT MAP (
          dig1 => dig1,
          dig2 => dig2,
          dig3 => dig3,
          dig4 => dig4,
          en_p => en_p,
          up_p => up_p,
          max_tick => max_tick,
          min_tick => min_tick
        );

--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

--    Stimulus process
   stim_proc: process
   begin		
		dig1 <= "0000" ;
		dig2 <= "0000" ;
		dig3 <= "0000" ;
		dig4 <= "0000" ;
		en_p <= '1' ; 
		up_p <= '0' ;
		wait for 10 ns;
		
		assert(min_tick='1') report "------ NO REPORTA MINIMO -----------" severity failure ;
		assert(max_tick='0') report "MANDA MAXIMO CUANDO NADA QUE VER 1" severity failure;
		
		dig1 <= "0111" ;
		wait for 10 ns;
		assert(min_tick='0') report "------ MANDA MIN POR ERROR -----" severity failure;
				assert(max_tick='0') report "MANDA MAXIMO CUANDO NADA QUE VER 2" severity failure;
				
		dig1 <= "1001" ;
		dig2 <= "1001" ;
		dig3 <= "1001" ;
		dig4 <= "1001" ;
		en_p <= '1' ; 
		up_p <= '1' ;
		wait for 10 ns;
		assert(min_tick='0') report "MANDA MMINIMO CUANDO NADA QUE VER 1" severity failure;
		assert(max_tick='1') report "-------- NO REPORTA MAXIMO ---------" severity failure;
		
		dig1 <= "0111" ;
			wait for 10 ns;
			assert(max_tick='0') report "----------MANDA MAX POR ERROR----------" severity failure;
			assert(min_tick='0') report"NADA QUE VER" severity failure;
		
		assert false report "---------- EXITO ------------- " severity failure;
		
   end process;

END;


