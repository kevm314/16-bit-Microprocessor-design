LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;



ENTITY programCounter IS
PORT (
					cluk : IN std_logic; --clock as determined by the done signal
				specify: IN std_logic_vector(7 downto 0); --specific address to count from
	resetCounter : IN std_logic; -- to reset must pass 00000000 as the specify address
	 enableCount : IN std_logic; --variable to enable counting
				 count : OUT std_logic_vector(7 downto 0)); --the actual output address to be used by RAM
END programCounter;


ARCHITECTURE behavioural of programCounter is


SIGNAL Q : std_logic_vector(7 downto 0); --temporary internal address variable for the counter


BEGIN


PROCESS(cluk, resetCounter)
	BEGIN
		IF resetCounter = '1' then
			Q <= specify;
		--check for clock, then count
		ELSIF (cluk'event AND cluk='1' AND enableCount = '1') then
			--loop around count if at last address
			IF Q = "00000110" THEN
				--Q <= (others => '0');
			--otherwise increment address
			ELSE
				Q <= Q+1;
			END IF;
		END IF;
	count <= Q;
END PROCESS;

END behavioural;
