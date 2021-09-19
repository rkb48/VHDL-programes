----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:46:01 04/29/2014 
-- Design Name: 
-- Module Name:    digital_clock - Behavioral 
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

entity digital_clock is
generic(fclk:integer :=50_000_000);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           sec : in  STD_LOGIC;
           min : in  STD_LOGIC;
           hour : in  STD_LOGIC;
           ssd_secu : out  STD_LOGIC_VECTOR (6 downto 0);
           ssd_sect : out  STD_LOGIC_VECTOR (6 downto 0);
           ssd_minu : out  STD_LOGIC_VECTOR (6 downto 0);
           ssd_mint : out  STD_LOGIC_VECTOR (6 downto 0);
           ssd_houru : out  STD_LOGIC_VECTOR (6 downto 0);
           ssd_hourt : out  STD_LOGIC_VECTOR (6 downto 0));
end digital_clock;

architecture digital clock of digital_clock is
signal secunits:natural range 0 to 10;
signal sectens:natural range 0 to 6;
signal minunits:natural range 0 to 10;
signal mintens:natural range 0 to 6;
signal hourunits:natural range 0 to 10;
signal hourtens:natural range 0 to 6;
signal limit:integer range 0 to fclk;

function integer_to_ssd(signal input:natural)return std_logic_vector is variable output:std_logic_vector(6 downto 0);
begin
case input is
when 0 => output:="0000001";
when 1 => output:="1001111";
when 2 => output:="0010010";
when 3 => output:="0000110";
when 4 => output:="1001100";
when 5 => output:="0100100";
when 6 => output:="0100000";
when 7 => output:="0001111";
when 8 => output:="0000000";
when 9 => output:="0000100";
when others => output:="0110000";
end case;
return output;
end integer_to_ssd;
begin
process(clk,rst)
variable  one_sec:natural range 0 to fclk;
variable  secu:natural range 0 to 10;
variable  sect:natural range 0 to 6;
variable  minu:natural range 0 to 10;
variable  mint:natural range 0 to 6;
variable  houru:natural range 0 to 10;
variable  hourt:natural range 0 to 3;
begin
if (rst='1') then
one_sec:=0;secu:=0;sect:=0;
minu :=0; mint :=0;
houru :=0; hourt :=0;
elsif(clk'EVENT AND clk='1') then
one_sec:=one_sec + 1;
if (one_sec=limit) then
one_sec:=0;
secu:=secu +1;
if (secu=10) then
secu:=0;
sect:=sect +1;
if (sect=6) then
sect:=0;
minu:=minu + 1;
if (minu=10) then
minu:=0;
mint:=mint +1;
if(minu=10) then
minu :=0;
mint:=mint + 1;
if(mint=6) then
mint:=0;
houru:=houru + 1;
if (( hourt/=2 and houru=10) or
(hourt=2 and houru=4)) then
houru :=0;
hourt:=hourt + 1;
if(hourt=3) then
hourt:=0;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
secunits<= secu;
sectens<=sect;
minunits<=minu;
mintens<=mint;
hourunits<=houru;
hourtens<=hourt;
end process;
ssd_secu<=integer_to_ssd(secunits);
ssd_sect<=integer_to_ssd(sectens);
ssd_minu<=integer_to_ssd(minunits);
ssd_mint<=integer_to_ssd(mintens);
ssd_houru<=integer_to_ssd(hourunits);
ssd_hourt<=integer_to_ssd(hourtens);

end digital clock;

