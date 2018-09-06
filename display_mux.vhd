
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

entity display_mux is
port(
	clk,reset: in std_logic;
	min_tick,max_tick : in std_logic ; 
	dig1,dig2,dig3,dig4 : in std_logic_vector(3 downto 0); 
	num,an : out std_logic_vector(3 downto 0)
);
end display_mux;

architecture Behavioral of display_mux is
	signal start_temp : std_logic;
	signal c_temp : std_logic_vector(18 downto 0);

begin

	time_control: entity work.time_control(Behavioral)
	port map( clk=>clk, reset=>start_temp, c_out => c_temp);
	
	time_display: entity work.time_display(Behavioral)
	port map( clk=>clk, reset=>reset, c=>c_temp, max_tick=>max_tick, min_tick=>min_tick, dig1=>dig1, dig2=>dig2, dig3=>dig3, dig4=>dig4, start=>start_temp , an=>an , num=>num ) ; 

end Behavioral;



-------------------------------------------------------------------------------------------------------------------------
