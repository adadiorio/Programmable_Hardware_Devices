----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2024 11:13:06
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
    generic (N: POSITIVE :=100000000);
    port(
    Clk: in std_logic;
    Rst: in std_logic;
    B: in std_logic;
    Busy: out std_logic;
    output: out std_logic
    );
end uart_tx;

architecture Behavioral of uart_tx is

signal external: unsigned(12 downto 0) :=(others => '0'); -- da mettere a 9 bit dopo debug
signal baud: std_logic := '0';
signal DATA: std_logic_vector(7 downto 0) := "01100001";

type state_t is (idle, data_valid, start, bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop);
signal state: state_t;
signal B_reg, B_reg2 : std_logic;
signal VALID: std_logic := '0';

begin

process(Clk, VALID)
begin 
    if(rising_edge(Clk)) then    
        B_reg <= B;
        B_reg2 <= B_reg;
        if (B_reg = '1') and (B_reg2 = '0') then
            VALID <= '1';
        else 
            VALID <= '0';
        end if;     
        
    end if;       
end process; 

process(Clk)

    begin 
        if(rising_edge(Clk)) then
        
            if Rst = '1' then
                external <= to_unsigned(0, external'length);
                State <= idle; -- ritorna allo stato iniziale
             
             else 
                 external <= external + to_unsigned(1, external'length);
                 baud <= '0';
                 
                 if external = "001101100100" then
                    baud <= '1';
                    external <= to_unsigned(0, external'length);
                 end if;
             
                        case State is 
                            when idle => output <= '1';
                                         busy <= '0';
                                         if VALID = '1' then 
                                            State <= data_valid;
                                         else 
                                            State <= idle;
                                         end if;
                                         
                            when data_valid => output <= '1';
                                               busy <= '1';
                                               
                                               if baud = '1' then 
                                                State <= start;
                                                end if;
                                   
                            when start => output <= '0';
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit0;
                                          end if;
                                          
                            when bit0 => output <= DATA(0);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit1;
                                          end if;
                                          
                            when bit1 => output <= DATA(1);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit2; 
                                          end if;                                 
        
                            when bit2 => output <= DATA(2);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit3; 
                                          end if;  
         
                             when bit3 => output <= DATA(3);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit4; 
                                          end if;
                                          
                              when bit4 => output <= DATA(4);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit5;
                                          end if;
                                          
                              when bit5 => output <= DATA(5);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit6;
                                          end if;
                                          
                               when bit6 => output <= DATA(6);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= bit7; 
                                          end if;    
                                          
                                when bit7 => output <= DATA(7);
                                          busy <= '1';
                                          if baud = '1' then
                                          State <= stop;   -- Tera term to see the results 
                                          end if;
                                          
                                when stop => output <= '1';
                                          busy <= '0';
                                          if baud = '1' then
                                          State <= idle;
                                          end if;
                                          
                                when others => if baud = '1' then
                                                State <= idle;
                                               end if;
                                               busy <= '0';
                                               output <= '1';   
                                               
                        end case;
          
                      end if;                                                                                                                                                                                                                                       
                end if;

            
end process;


end Behavioral;
