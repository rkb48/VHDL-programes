----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:38 03/10/2016 
-- Design Name: 
-- Module Name:    counter_binary - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_binary is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  COUNT_EN: in STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (03 downto 0));
end counter_binary;

architecture Behavioral of counter_binary is

signal count : STD_LOGIC_VECTOR(3 downto 0);

begin
	--count<="0000";
	process(CLK)
	begin
		if (RESET='1') then
				count<="0000";
		elsif (CLK'EVENT and CLK='1') then
			if (COUNT_EN='1')then
				count<=count+1;
			end if;
			Q<=count;
		end if;
		--Q<=count;
	end process;	

end Behavioral;

