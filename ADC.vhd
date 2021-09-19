----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:28:08 04/30/2014 
-- Design Name: 
-- Module Name:    ADC - Behavioral 
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

entity adc is
port(d0,d1,d2,d3,d4,d5,d6,d7:in std_logic;
	clk,eoc:in std_logic;
	start,ale,en:out std_logic;
	alarm:out std_logic);
end adc;

architecture Behavioral of adc is
type states is (st0,st1,st2,st3,st4,st5,st6,st7);
signal current_state,next_state:states;
signal reg1:std_logic_vector(7 downto 0);
signal clk1:std_logic;

begin
	st:process(current_state,eoc)
	begin
	case current_state is
		when st0 => next_state <= st1;
			ale <= '0';
			start <= '0';
			en <= '0';
			
		when st1 => next_state <= st2;
			ale <= '1';
			start <= '0';
			en <= '0';
			
		when st2 => next_state <= st3;
			ale <= '0';
			start <= '1';
			en <= '0';
			
		when st3 => ale <= '0';
			start <= '0';
			en <= '0';
			if eoc='1' then 
			next_state<=st3;
			else
			next_state<=st4;
			end if;
			
		when st4 => ale <= '0';
			start <= '0';
			en <= '0';
			if eoc='0' then 
			next_state<=st4;
			else
			next_state<=st5;
			end if;
			
		when st5 => next_state <= st6;
			ale <= '0';
			start <= '0';
			en <= '1';
			
		when st6 => next_state <= st0;
			ale <= '0';
			start <= '0';
			en <= '1';
			reg1(0)<=d0;
			reg1(1)<=d1;
			reg1(2)<=d2;
			reg1(3)<=d3;
			reg1(4)<=d4;
			reg1(5)<=d5;
			reg1(6)<=d6;
			reg1(7)<=d7;			
			
		when others =>next_state <= st0;
		    ale <= '0';
			start <= '0';
			en <= '1';
			reg1(0)<=d0;
			reg1(1)<=d1;
			reg1(2)<=d2;
			reg1(3)<=d3;
			reg1(4)<=d4;
			reg1(5)<=d5;
			reg1(6)<=d6;
			reg1(7)<=d7;	
			
			
	end case;
end process;

clock_rate : process(clk)
	variable qq:Integer:=0;
	begin
		qq:=qq+1;
		if qq<=5 then
			clk1<= '0';
		else
			clk1<='1';
			if qq=10 then
				qq:=0;
			end if;
		end if;
end process;
new_process : process(clk) 
	begin
		current_state<=next_state;
end process;

process(clk1)
 variable q_in:std_logic_vector(7 downto 0);
 begin 
  q_in:=reg1;
  if(q_in>="00000110") then alarm<='0';
  else alarm<='1';
  end if;
  end process;
end Behavioral;



