----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:50 05/30/2016 
-- Design Name: 
-- Module Name:    FIR_Filter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIR_Filter is
    Port ( Clk : in  STD_LOGIC;
           Xin : in  signed(07 downto 0);
           Yout : out  signed (15 downto 0));
end FIR_Filter;

architecture Behavioral of FIR_Filter is

component D_FF is
	Port ( Clk : in STD_LOGIC;
				D : in signed(15 downto 0);
				Q : out signed(15 downto 0));
end component;

--signal H0,H1,H2,H3 : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
signal H0,H1,H2,H3 : signed(7 downto 0) := (others=>'0');
signal MCM0, MCM1, MCM2, MCM3, add_out1, add_out2, add_out3 : signed(15 downto 0):=(others=>'0');
signal Q1, Q2, Q3 : signed(15 downto 0):=(others=>'0');

begin
--H=[-2,-1,3,8]
--H0 <= to_STDLOGICVECTOR(signed(-2));
H0 := to_signed(-2,8);
H1 <= to_signed(-1,8);
H2 <= to_signed(3,8);
H3 <= to_signed(4,8);

--Constant Multiplication
MCM3 <= H3*Xin;
MCM2 <= H2*Xin;
MCM1 <= H1*Xin;
MCM0 <= H0*Xin;

--Delayed components
dff1: D_FF port map(Clk, MCM3, Q1);
dff2: D_FF port map(Clk, add_out1, Q2);
dff3:D_FF port map(Clk, add_out2, Q3);

--Addition
add_out1 <= Q1+MCM2;
add_out2 <= Q2+MCM1;
add_out3 <= Q3+MCM0;

process(Clk)
begin 
	if(rising_edge(Clk)) then
		Yout <= add_out3;
	end if;
end process;


end Behavioral;

