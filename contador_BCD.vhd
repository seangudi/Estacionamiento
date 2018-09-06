
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

entity contador_BCD is
port(
	clk,reset  : in std_logic;
	en_p,up_p : in std_logic;
	min_tick,max_tick : in std_logic;
	dig1,dig2,dig3,dig4 : out std_logic_vector(3 downto 0)
);
end contador_BCD;

architecture Behavioral of contador_BCD is
	signal en_12,up_12,en_23,up_23,en_34,up_34,en_4f,up_4f : std_logic; -- la salidas en y up del ultimo BCD no se usan 

begin

	BCD1:entity work.BCD1(behavioral)
	port map(clk=>clk, reset=>reset , max_tick=>max_tick, min_tick=>min_tick , en_in=>en_p , up_in=>up_p, digito=>dig1, en_out=>en_12, up_out=>up_12);
	
	BCD2:entity work.BCD2(behavioral)
	port map(clk=>clk, reset=>reset , max_tick=>max_tick, min_tick=>min_tick , en_in=>en_12 , up_in=>up_12, digito=>dig2, en_out=>en_23, up_out=>up_23);
	
	BCD3:entity work.BCD3(behavioral)
	port map(clk=>clk, reset=>reset , max_tick=>max_tick, min_tick=>min_tick , en_in=>en_23 , up_in=>up_23, digito=>dig3, en_out=>en_34, up_out=>up_34);
	
	BCD4:entity work.BCD4(behavioral)
	port map(clk=>clk, reset=>reset , max_tick=>max_tick, min_tick=>min_tick , en_in=>en_34 , up_in=>up_34, digito=>dig4, en_out=>en_4f, up_out=>up_4f);
	


end Behavioral;

