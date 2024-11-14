----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2023 15:10:54
-- Design Name: 
-- Module Name: nbit_adder - Behavioral
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


-- Here we have another kind of implementation of the adder, the final result is the same
-- also in terms of efficiency 

entity nbit_adder is
    -- := is used to declare a default value; is a constant, can't be changed during computation
    -- also it must have an initialized value 
    generic (n: NATURAL :=4);
    port (A, B: in std_logic_vector(n-1 downto 0);
    Cin : in std_logic;
    Sum : out std_logic_vector(n-1 downto 0);
    Cout: out std_logic);
end nbit_adder;

architecture unsigned_a of nbit_adder is
    -- signal is a way of instantiating a value that can be changed during computation 
    signal result : unsigned(n downto 0);
    -- (*)
    signal carry : unsigned(n downto 0);
    constant zeros : unsigned(n-1 downto 0) := (others => '0');
    -- it means that we will have in ouput a 4 bit vector 

begin

    carry <= (zeros & Cin);
    -- The A variable is interpreted as unsigned, same for B 
    -- A and B have length n, so the result will have shape n+1; that's
    -- why it is instantiated as above (*)
    -- we perform a concatenation between 0 and A 
    result <= ('0' & unsigned(A)) + ('0' & unsigned(B)) + carry;
    Sum <= std_logic_vector(result(n-1 downto 0));
    Cout <= result(n);


end unsigned_a;
