----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:03:09 04/26/2014 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (07 downto 0);
           B : in  STD_LOGIC_VECTOR (07 downto 0);
           SEL : in  STD_LOGIC_VECTOR (03 downto 0);
           EN : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (07 downto 0);
           Cy : out  STD_LOGIC;
           AgB : out  STD_LOGIC;
           AeB : out  STD_LOGIC;
           AlB : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is

begin
process(A,B,SEL,EN)
variable tempa,tempb,tempy: std_logic_vector(08 downto 0);
begin
 Cy<='0';
 AgB<='0';
 AeB<='0';
 AlB<='0';
 tempa:='0' & A;
 tempb:='0' & B;
 
 if EN='1' then 
	 case SEL is
	   	when "0000"=>
		   tempy:=tempa+tempb;
		   Y<=tempy(07 downto 0);
		   Cy<=tempy(8);
		
	   	when "0001"=>
			tempy:=tempa-tempb;
			Y<=tempy(07 downto 0);
			Cy<=tempy(8);
		
			when "0010"=>
			tempy:=tempa and tempb;
			Y<=tempy(07 downto 0);
		
			when "0011"=>
			tempy:=tempa or tempb;
			Y<=tempy(07 downto 0);
		
			when "0100"=>
			tempy:=tempa xor tempb;
			Y<=tempy(07 downto 0);
		
			when "0101"=>
			tempy:=not tempa;
			Y<=tempy(07 downto 0);
		
			when "0110"=>
			Cy<=tempa(0);
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) srl 1);
			Y<=tempy(07 downto 0);
		
			when "0111"=>
			Cy<=tempa(07);
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) sll 1);
			Y<=tempy(07 downto 0);
		
			when "1000"=>
			Cy<=tempa(0);
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) sra 1);
			Y<=tempy(07 downto 0);
			
			when "1001"=>
			Cy<=tempa(7);
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) sla 1);
			Y<=tempy(07 downto 0);
		
			when "1010"=>
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) ror 1);
			Y<=tempy(07 downto 0);
		
			when "1011"=>
			tempy(07 downto 0):=to_stdlogicvector(to_bitvector(tempa(07 downto 0)) rol 1);
			Y<=tempy(07 downto 0);
		
			when "1100"=>
			  if tempa<tempb then
			  AlB<='1';
			  elsif tempa=tempb then
			  AeB<='1';
			  else 
			  AgB<='1';
			  end if; 
		
			when others=>
			Y<="00000000";	
	  end case;
	 
	else
	  Y<="00000000";
   end if;
end process;
end Behavioral;

