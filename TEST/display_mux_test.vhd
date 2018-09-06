
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY display_mux_test IS
END display_mux_test;
 
ARCHITECTURE behavior OF display_mux_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display_mux
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         min_tick : IN  std_logic;
         max_tick : IN  std_logic;
         dig1 : IN  std_logic_vector(3 downto 0);
         dig2 : IN  std_logic_vector(3 downto 0);
         dig3 : IN  std_logic_vector(3 downto 0);
         dig4 : IN  std_logic_vector(3 downto 0);
         num : OUT  std_logic_vector(3 downto 0);
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal min_tick : std_logic := '0';
   signal max_tick : std_logic := '0';
   signal dig1 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig2 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig3 : std_logic_vector(3 downto 0) := (others => '0');
   signal dig4 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal num : std_logic_vector(3 downto 0);
   signal an : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: display_mux PORT MAP (
          clk => clk,
          reset => reset,
          min_tick => min_tick,
          max_tick => max_tick,
          dig1 => dig1,
          dig2 => dig2,
          dig3 => dig3,
          dig4 => dig4,
          num => num,
          an => an
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
	
	reset<='1';
	wait for 15 ns ; 
	reset<='0';
	
	
	
	
		dig1 <= "0001";
		dig2 <= "0010";
		dig3 <= "0011";
		dig4 <= "0100";
		
		wait for 5 ms;

		
		assert false report "----------- EXITO ------------------" severity failure;
		
		
	end process;

END;
