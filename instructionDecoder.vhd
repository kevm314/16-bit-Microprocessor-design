LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY instructionDecoder IS 
PORT (	       
        F : IN std_logic_vector(2 DOWNTO 0);
 Fdecoded : OUT std_logic_vector(7 downto 0)); 
END; 
ARCHITECTURE behavioural of instructionDecoder is begin 
with F select
      Fdecoded <= "00001000" when "000",
						"00000100" when "001",
						"00000010" when "010",
						"00000001" when "011",
						"00010000" when "101",
						"00000000" when others;
END behavioural; 

