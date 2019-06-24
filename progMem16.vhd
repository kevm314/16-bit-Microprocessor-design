LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
USE ieee.numeric_std.ALL;

ENTITY progMem16 IS
GENERIC ( S : INTEGER := 2;
	N : INTEGER := 8 );
port(
	clock : in std_logic; -- from the processor
	data_in : in std_logic_vector (15 downto 0); -- not required
	write_addr : in std_logic_vector (N-1 downto 0); -- not required
	read_addr : in std_logic_vector (N-1 downto 0); -- from the program counter
	write_enable : in std_logic; --this always 0
	data_out : out std_logic_vector (15 downto 0)); --inks to external in AND is instruction
END;



ARCHITECTURE behavioral OF progMem16 IS
TYPE mem IS ARRAY (18 downto 0) OF std_logic_vector(15 downto 0);


	FUNCTION initialize_ram RETURN mem IS
	VARIABLE result : mem;
		BEGIN


			result(0) := "0000000000000000"; --LOAD R0
			result(1) := "1100000000001111"; --DATA 0 of value 1
			result(2) := "0000010000000000"; --LOAD R1
			result(3) := "1100000000000001"; --DATA 1 of value 3
			result(4) := "0100000010000000"; --ADD R1 and R2 -> R1 should contain 4

			--result(5) := "0000100000000000"; --LOAD R3
			--result(6) := "1100000000000000"; --DATA 1 of value 3
			--result(7) := "0110000100000000"; --SUBTRACT R1 - R3 -> R1 should contain 3
			--result(8) := "0010000010000000"; --MOVE CONTENTS of R2 to R1
			result(5) := "1010000010000000"; --XOR R1, R3 -> R1 should contain ...0011


			result(6) := "1111111111111111";



--
--
--			result(0) := "0000000000000000"; --LOAD R1
--			result(1) := "1100000000000001"; --DATA 0 of value 1
--			result(2) := "0000010000000000"; --LOAD R2
--			result(3) := "1100000000000011"; --DATA 1 of value 3
--			result(4) := "0100000010000000"; --ADD R1 and R2 -> R1 should contain 4
--			result(5) := "0010100000000000"; --MOVE CONTENTS of R1 to R3
--
--			result(6) := "0000000000000000"; --LOAD R1
--			result(7) := "1100000000000010"; --DATA 0 of value 2
--			result(8) := "0000010000000000"; --LOAD R2
--			result(9) := "1100000000000101"; --DATA 1 of value 5
--			result(10) := "0100000010000000"; --ADD R1 and R2 -> R1 should contain 7
--
--			result(11) := "0010010100000000"; --MOVE CONTENTS of R3 to R2
--			result(12) := "0110000010000000"; --SUBTRACT R1 - R2 -> R1 should contain 3
--
--			result(13) := "0000010000000000"; --LOAD into R2
--			result(14) := "1101111111111111"; --DATA
--			result(15) := "1010000010000000"; --XOR R1 and R2
--			result(16) := "1111111111111111"; --RETURN : 13 LSB of result should be
----													-- "1111111111100"
--
---- ((data0 + data2) - (data3 + data4)) XOR (11111111111)
--



		return result;
	END initialize_ram;
SIGNAL raMem : mem := initialize_ram;

BEGIN

PROCESS (clock)
	BEGIN
		IF clock'event and clock = '1' THEN
			IF write_enable = '1' THEN
				--raMem(to_integer(unsigned(write_addr))) <= data_in;
			END IF;
				data_out <= raMem(to_integer(unsigned(read_addr)));
		END IF;
	END PROCESS;
END behavioral;
