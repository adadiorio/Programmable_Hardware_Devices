----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2023 16:57:33
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
    port (
    clk : in std_logic;   
    we  : in std_logic;   
    a   : in std_logic_vector(4 downto 0);   # a is the input of the memory address
    di  : in std_logic_vector(3 downto 0);   
    do  : out std_logic_vector(3 downto 0)
    );   
end ram;

architecture Behavioral of ram is

type ram_type is array (0 to 31) of std_logic_vector (3 downto 0);   
signal RAM : ram_type;  
signal read_a : std_logic_vector(4 downto 0);   

-- The compiler is actually synthethizing the design using a distributed ram, for optimization purposes
-- with the above constraint it is possible to "suggest" the compiler some strategies to be applied 
-- these are called soft constraints, because the compiler can decide to satisfy them or not 

--attribute ram_style : string;
--attribute ram_style of RAM : signal is "block";

-- the above signal means that block is assigned to ram_style of the ram, it is a property 
-- there are many possible values that can be assigned to the style of the ram 

begin   

--This memory displays write-before-read behaviour
--It means that during a write-cycle the data being returned is the same as that being written
--Without this, the data returned through the dataout port would be the data just being overwritten

process (clk)   
begin   
  if rising_edge(clk) then   
    if (we = '1') then   
      RAM(to_integer(unsigned(a))) <= di;   
    end if;   
    read_a <= a;   
  end if; 
end process;   

do <= RAM(to_integer(unsigned(read_a)));   # do is the output of the net

end Behavioral;
