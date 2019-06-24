LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY s16mux2to1 IS 
PORT (	        s : IN std_logic;
                     x : IN std_logic_vector(15 downto 0); --x is B
                     y : IN std_logic_vector(15 downto 0); --Y is B’
                     m : OUT std_logic_vector(15 downto 0));
END; 

ARCHITECTURE behavioural of s16mux2to1 is 

begin 
   with s select
      m <= x when '1',
           y when '0'; 
END behavioural; 

