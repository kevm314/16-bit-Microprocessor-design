LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fullAdder IS 
PORT (	
	AsZero: IN std_logic; --control signal	
	 x, y : IN std_logic_vector(15 downto 0);  -- A and R inputs
     	 s : OUT std_logic_vector(15 downto 0); -- final S sum output
	    K : OUT std_logic); -- K carry output
END; 
ARCHITECTURE behavioural of fullAdder is 
SIGNAL c : std_logic_vector(16 downto 0);
 

COMPONENT fa IS
PORT (
 a, b, cin : IN std_logic; 
           	    c, s      : OUT std_logic);
END COMPONENT;



BEGIN

c(0) <= AsZero; --initialise carry in bit

g0: FOR i IN 15 DOWNTO 0 GENERATE
   
FA0: fa port map(x(i), y(i), c(i), c(i+1), s(i));
 END GENERATE g0;

 K <= c(16); --extract the carry bit

END behavioural; 
