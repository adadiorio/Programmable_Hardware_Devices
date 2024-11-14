----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2023 15:29:13
-- Design Name: 
-- Module Name: tb_nbit_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_nbit_adder is
--  Port ( );
end tb_nbit_adder;

architecture Behavioral of tb_nbit_adder is

component nbit_adder is
    generic (n: NATURAL :=4);
    port (A, B: in std_logic_vector(n-1 downto 0);
    Cin : in std_logic;
    Sum : out std_logic_vector(n-1 downto 0);
    Cout: out std_logic);
end component;

signal A, B : std_logic_vector(3 downto 0) :=(others=>'0'); 
signal Cin : std_logic :='0';
signal Sum : std_logic_vector(3 downto 0);
signal Cout : std_logic;
signal error : std_logic :='0'; -- can be used to check for errors or not checked conditions 

begin

-- we declare 5 more signals with the same names of the ports; these are signals of the test bench 
-- now we are free to decide which value to give to the signals 

DUT: nbit_adder
    generic map (
        n       => 4)
    port map (
        A       => A,
        B       => B,
        Cin     => Cin,
        Sum     => Sum,
        Cout    => Cout
     );
           
stim_p: process
begin
    A <= x"0"; -- we assign 0 to port A: it's equivalent to "0000"; A is a 4 bit vector 
    B <= x"D"; -- "1011"
    Cin <= '0';
    wait for 300 ns; -- this statement can't be synthetized; has no meaning for the circuit 
                     -- time in the circuit is given by the clock; but in this case it can
                     -- be used 
    Cin <= '1';
    wait for 100 ns;
    A <= x"C"; 
    wait; -- this means to wait forever; the process is stucked here, means that the signal will not change after assignign C to A
          -- if we remove the wait statement, the cycle will not work because A is assigned to C and then 
          -- immediately after is assigned to 0
end process;      

error <= '1' when (unsigned(A) + unsigned(B) + (0=>Cin)) /= unsigned(Sum) else
         '0';

end Behavioral;
