
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

entity estacionamiento_top is
	port(
		clk,reset: in std_logic ;
		aa,bb : in std_logic ;
		an: out std_logic_vector(3 downto 0);
		sseg_out: out std_logic_vector(7 downto 0)
	);
end estacionamiento_top;

architecture Behavioral of estacionamiento_top is
	signal en_p,up_p,max_tick,min_tick,a,b : std_logic;
	signal dig1,dig2,dig3,dig4 : std_logic_vector(3 downto 0);

begin
	--================================= Debounce a las entradas ============================
	deb: entity work.deb(arch)
	port map(clk=>clk, reset=>reset, sw=>aa,db=>a);
	deb2: entity work.deb2(arch)
	port map(clk=>clk, reset=>reset, sw=>bb, db=>b);

	--================================ Estacionamiento =====================================
	estacionamiento: entity work.estacionamiento(moore)
	port map(clk=>clk, reset=>reset, a=>a , b=>b , en_p=>en_p , up_p=>up_p);
	
	--================================ Contador BCD ========================================
	contador_BCD: entity work.contador_BCD(Behavioral)
	port map(clk=>clk, reset=>reset, en_p=>en_p , up_p=>up_p, max_tick=>max_tick, min_tick=>min_tick, dig1=>dig1, dig2=>dig2, dig3=>dig3, dig4=>dig4) ;

	--================================ max_min =============================================
	max_min: entity work.max_min(Behavioral)
	port map(dig1=>dig1, dig2=>dig2, dig3=>dig3, dig4=>dig4, max_tick=>max_tick, min_tick=>min_tick);
	
	--=============================== display_out ==========================================
	disp_out: entity work.disp_out(Behavioral)
	port map(clk=>clk, reset=>reset, dig1=>dig1, dig2=>dig2, dig3=>dig3, dig4=>dig4, max_tick=>max_tick, min_tick=>min_tick, sseg_out=>sseg_out , an=>an);
	
end Behavioral;









