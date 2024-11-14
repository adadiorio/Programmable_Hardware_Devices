----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.10.2023 14:26:57
-- Design Name: 
-- Module Name: FSM - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    port(
      Clk : in std_logic;
      Rst : in std_logic;
      Sel : in std_logic_vector(3 downto 0);
      Dout   : out std_logic_vector(3 downto 0);
      o : out std_logic := '0'
    );  
end FSM;

-- we are assuming here that we are constructing a two states state machine; in order to find them 
-- we need to find custom type 

architecture Behavioral of FSM is

type seq0_type is array (0 to 4) of std_logic_vector(3 downto 0);  -- Definizione del tipo di array

type state_t is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);

signal seq0 : seq0_type := (
    0 => "0000",
    1 => "0001",
    2 => "0011",
    3 => "0111",
    4 => "1111"
);

signal seq1 : seq0_type := (
    0 => "0000",
    1 => "1000",
    2 => "1100",
    3 => "1110",
    4 => "1111"
);

signal state : state_t;
--signal NextState : state_t;
constant Value0 : std_logic_vector(3 downto 0) := "0000";
constant Value1 : std_logic_vector(3 downto 0) := "0001";


begin

process(Clk) is
begin
   if rising_edge(Clk) then
       if Rst = '1' then
           State <= S0;
           Dout  <=  Value0;
           
       else
         case State is
            when S0 =>   
            
                        o <= '0';
                        if Sel = seq0(1) then -- devo assegnare '0000' ad S0 e poi da questo passare ad S1
                                       State <= S1; -- aggiornamento dello stato, nella macchina passo a quello successivo 
                                       Dout <= "0001";
                                       
                                       
                         elsif Sel = seq1(1) then
                                        State <= S6;
                                        Dout <= "0110";
                         else
                              State <= S0; -- rimane nello stesso stato di partenza 
                              Dout <= "0000";
                         end if;
                         
            when S1 =>  
            
                        o <= '0';
                        if Sel = seq0(2) then
                                       State <= S2;
		                               Dout <= "0010";
		                               
		           --      elsif Sel = seq0(0) then 
		             --                  State <= S1; -- torna nello stesso stato, do 0000 a 0000
		               --                Dout <= "0001";
		                               
		              --   elsif Sel = seq1(0) then 
		                --               State <= S6;
		                  --             Dout <= "0011";
		                  
		                 else 
		                      State <= S0;
		                      Dout <= "0000";
                              end if;
                                    
            when S2 =>   
            
                         o <= '0';            
                         if Sel = seq0(3) then
                                  State <= S3;
		                          Dout <= "0011";
		            --     elsif Sel = seq0(0) then 
		              --                State <= S1;
		                --              Dout <= "0001";
		                  else 
		                          State <= S0;
		                          Dout <= "0000";
                          end if;
                                    
            when S3 =>   
            
                         o <= '0';            
                         if Sel = seq0(4) then
                                       State <= S4;
		                               Dout <= "0100";
		            --     elsif Sel = seq0(0) then 
		              --                 State <= S1;
		                --               Dout <= "0001";
		                 else 
		                          State <= S0;
		                          Dout <= "0000"; 
                         end if;
                         
            when S4 =>   
            
                        o <= '1';            
                        if Sel = seq0(0) then
                                       State <= S0;
		                               Dout <= "0000";
		                               
		           --      elsif Sel = seq0(0) then
		             --             State <= S1;
		               --           Dout <= "0001";
		                 else 
		                          State <= S0;
		                          Dout <= "0000";
		                 end if;
            when S5 =>   
            
                        o <= '0';            
                        if Sel = seq0(0) then -- not sure it is correct 
                               State <= S1;
		                       Dout <= "0001";	
		                else     
		                       State <= S0;
		                       Dout <= "0000";	                               
                        end if;
                         
            when S6 =>   
            
                        o <= '0';            
                        if Sel = seq1(1) then
                                State <= S7;
		                        Dout <= "0111";	
		             --    elsif Sel = seq1(0) then 
		               --         State <= S1;
		                 --       Dout <= "0001";
		                 else     
		                        State <= S0;
		                        Dout <= "0000";	                               
                         end if;     
                         
            when S7 =>   
            
                         o <= '0';            
                         if Sel = seq1(2) then
                                 State <= S8;
		                         Dout <= "1000";	
		        --         elsif Sel = seq1(0) then 
		          --                     State <= S1;
		            --                   Dout <= "0001";
		                 else     
		                          State <= S0;
		                          Dout <= "0000";	                               
                         end if;  
                         
            when S8 =>   
            
                         o <= '0';            
                         if Sel = seq1(3) then
                                  State <= S9;
		                          Dout <= "1001";	
		                               
		            --     elsif Sel = seq1(0) then 
		              --                 State <= S1;
		                --               Dout <= "0001";
		                 else     
		                          State <= S0;
		                          Dout <= "0000";	                               
                         end if;  
                         
            when S9 =>   
            
                         o <= '1';            
                         if Sel = seq1(0) then 
		                          State <= S1;
		                          Dout <= "0001";
		                 else     
		                          State <= S0;
		                          Dout <= "0000";	                               
                         end if;    
                                                               
         end case;
      end if;
   end if;
end process;

-- NOTE: we want all the process to be synchronous, that's why we are putting all of it inside the if condition 

-- The same can be rebuilt in another way using two processes instead of only one, the process will still be synchronous 
-- but divided into two parts 

--process(Clk) is
--begin
--   if rising_edge(Clk) then
--       if Rst = '1' then
--           State <= S0;
--       else
--           State <= NextState;
--       end if;
--   end if;
--end process;

--process(State, Sel) is
--begin
--    NextState <= State;
--         case State is
--            when S0 =>      if Sel = x"A" then
--                                NextState <= S1; 
--                                Dout <= Value0;
--                            end if;
--            when S1 =>      if Sel = x"5" then
--                                NextState <= S0;
--                                Dout <= Value1;
--		                    end if;
--            when others =>  Dout <= Value0;
--                                NextState <= S0;
--         end case;
--end process;


end Behavioral;
