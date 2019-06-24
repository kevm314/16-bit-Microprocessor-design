LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlUnit IS
PORT (
	     w : IN std_LOGIC;
	  clock: IN std_logic;
      Fcu: IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 instruction bits
		  Rx : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Rx 3 bits from instruction
		  Ry : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Ry 3 bits from instruction
		  Rin: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --driving ENTERING data for all registers
		 Rout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --driving EXITING data for all registers VIA A MULTIPLEXER OR TRINODE STRUCTURE
      Ain: OUT std_logic;
	    Gin: OUT std_logic;
	   Gout: OUT std_logic;
AddSubXOR: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
 ExternIn: OUT std_logic;
		  isI: OUT STD_logic;
	   Done: OUT std_logic);
END controlUnit;

ARCHITECTURE behavioural of controlUnit is


TYPE State_type IS (Res, Load, Load2, Add1, Add2, Add3, Mov1, Sub1, Sub2, Sub3, XOR1, XOR2, XOR3);
SIGNAL n_y,y : State_type;



SIGNAL FdecodedCu: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL regDecodedx: STD_LOGIC_VECTOR(7 downto 0); -- hot code for x
SIGNAL regDecodedy: STD_LOGIC_VECTOR(7 downto 0); -- hot code for y BOTH 8 BITS

COMPONENT instructionDecoder IS
PORT (
        F : IN std_logic_vector(2 DOWNTO 0);
 Fdecoded : OUT std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT registerDecoder IS
PORT (
        Reg: IN std_logic_vector(2 DOWNTO 0);
regDecoded : OUT std_logic_vector(7 downto 0));
END COMPONENT;

BEGIN

ID: instructionDecoder port map(Fcu, FdecodedCu);
REGX: registerDecoder port map(Rx, regDecodedx);
REGY: registerDecoder port map(Ry, regDecodedy);




--finite state machine encoding
PROCESS (w, Clock)
BEGIN
	IF w = '0' THEN
		y <= Res;		--reset the finite state machine
	ELSIF rising_edge(Clock) THEN
		y <= n_y;
	END IF;
END PROCESS;






--		Rin  <= "00000000";
--		Rout <= "00000000";
--       Ain <= '0';
--	    Gin <= '0';
--	   Gout <= '0';
-- AddSubXOR <= "00";
--  ExternIn <= '0';
--		Done <= '0';



--PROCESS (y)
PROCESS (Fcu,y)
BEGIN
		Rin  <= "00000000";
		Rout <= "00000000";
      Ain <= '0';
	   Gin <= '0';
	   Gout <= '0';
		AddSubXOR <= "00";
		ExternIn <= '0';
		isI <= '1';
		Done <= '0';


		CASE y IS
			WHEN Res =>
				IF w = '0' THEN
					n_y <= Res;
				ELSIF w = '1' AND Fcu = "111" THEN
					n_y <= Res;
				ELSIF w = '1' AND Fcu = "001" THEN
					n_y <= Mov1;
				ELSIF w = '1' AND Fcu = "000" THEN
					n_y <= Load;
					isI <= '0';
					Done <= '1';

				ELSIF w = '1' AND Fcu = "010" THEN
					n_y <= Add1;

				ELSIF w = '1' AND Fcu = "101" THEN
					n_y <= XOR1;

				ELSIF w = '1' AND Fcu = "011" THEN
					n_y <= Sub1;
				ELSE
					n_y <= Res;

				END IF;



			WHEN Add1 =>
				Ain <= '1';
				Rout <= regDecodedx;
				n_y <= Add2;

			WHEN Add2 =>
				Gin <= '1';
				Rout <= regDecodedy;
				AddSubXOR <= "10";
				n_y <= Add3;
				Done <= '1';

			WHEN Add3 =>
				Gout <= '1';
				Rin <= regDecodedx;
				n_y <= Res;
				ExternIn <= '0';



			WHEN XOR1 =>
				Ain <= '1';
				Rout <= regDecodedx;
				n_y <= XOR2;

			WHEN XOR2 =>
				Gin <= '1';
				Rout <= regDecodedy;
				AddSubXOR <= "11";
				n_y <= XOR3;
				Done <= '1';

			WHEN XOR3 =>
				Gout <= '1';
				Rin <= regDecodedx;
				n_y <= Res;


			WHEN Sub1 =>
				Ain <= '1';
				Rout <= regDecodedx;
				n_y <= Sub2;

			WHEN Sub2 =>
				Gin <= '1';
				Rout <= regDecodedy;
				AddSubXOR <= "01";
				n_y <= Sub3;
				Done <= '1';

			WHEN Sub3 =>
				Gout <= '1';
				Rin <= regDecodedx;
				n_y <= Res;



			WHEN Load =>

				ExternIn <= '1'; -- bring in the external data
				Rin <= regDecodedx; --ALWAYS load data into the register given by the operand Rx
				n_y <= Load2;


			WHEN Load2 =>
				n_y <= Res;
				Done <= '1';

			WHEN Mov1 =>
				Rin <= regDecodedx; -- X is receiving,
				Rout <= regDecodedy; -- Y is giving the value
				Done <= '1';
				n_y <= Res;






		END CASE;









END PROCESS;
















END behavioural;
