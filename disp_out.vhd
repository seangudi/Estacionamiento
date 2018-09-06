
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

entity disp_out is
port(
	clk,reset: in std_logic;
	min_tick,max_tick : in std_logic ; 
	dig1,dig2,dig3,dig4 : in std_logic_vector(3 downto 0); 
	sseg_out : out std_logic_vector(7 downto 0) ;
	an : out std_logic_vector(3 downto 0)
);
end disp_out;

architecture Behavioral of disp_out is
	signal num_temp :std_logic_vector(3 downto 0) ;

begin

	display_mux: entity work.display_mux(Behavioral)
	port map(clk=>clk, reset=>reset, max_tick=>max_tick, min_tick=>min_tick, dig1=>dig1, dig2=>dig2, dig3=>dig3, dig4=>dig4, num=>num_temp, an=>an);
	
	sseg_p: entity work.sseg_p(Behavioral)
	port map(num_out=>num_temp, sseg=>sseg_out);
	
end Behavioral;

