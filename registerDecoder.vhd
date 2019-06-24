LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registerDecoder IS 
PORT (	       
        Reg: IN std_logic_vector(2 DOWNTO 0);
regDecoded : OUT std_logic_vector(7 downto 0)); 
END; 
ARCHITECTURE behavioural of registerDecoder is begin 
with Reg select
      regDecoded <= "00000001" when "000",
						  "00000010" when "001",
						  "00000100" when "010",
						  "00001000" when "011", 
						  "00000000" when OTHERS;
END behavioural; 

