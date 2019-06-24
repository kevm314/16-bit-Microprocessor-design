
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY myALU IS
PORT (
				 A : IN std_logic_vector(15 downto 0);
         B : IN std_logic_vector(15 downto 0);
         As: IN std_logic_vector(1 downto 0); --As is AddSub signal control signal
         G : OUT std_logic_vector(15 downto 0);
	   Kcarry: OUT std_logic);
END;

ARCHITECTURE behavioural of myALU is

SIGNAL R : std_logic_vector(15 downto 0); -- output of multiplexer
SIGNAL Intermediate : std_logic_vector(15 downto 0); -- intermediate output of multiplexer
SIGNAL xOutput : std_logic_vector(15 downto 0); -- intermediate output of multiplexer

COMPONENT s16mux2to1 IS
PORT (
			s : IN std_logic;
         x : IN std_logic_vector(15 downto 0); --x is B
         y : IN std_logic_vector(15 downto 0); --Y is B’
         m : OUT std_logic_vector(15 downto 0));
END COMPONENT;

COMPONENT fullAdder IS
PORT (
	AsZero: IN std_logic; --control signal
	 x, y : IN std_logic_vector(15 downto 0);  -- A and R inputs
     	 s : OUT std_logic_vector(15 downto 0); -- final S sum output
	    K : OUT std_logic); -- K carry output
END COMPONENT;

BEGIN

--As0 goes to the fullAdder
--As1 goes to the multiplexer

M: s16mux2to1 port map(As(1), B, NOT B, R);
FA:  fullAdder port map(As(0),  A, R, Intermediate, Kcarry);
xOutput <= A XOR B;


G <= Intermediate WHEN As="01" ELSE
	  Intermediate WHEN As="10" ELSE
           xOutput WHEN As="11";

END behavioural;
