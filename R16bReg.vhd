LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY R16bReg IS
PORT (
       Dreg : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	       clk: IN STD_LOGIC;
      enable: IN STD_LOGIC;
	      Qreg: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

END R16bReg;

ARCHITECTURE behavioural of R16bReg is

BEGIN
  PROCESS (clk, Dreg, enable)
	 BEGIN
    --check for rising clock edge and enable signal
    IF (clk'event AND clk = '1' AND enable = '1') THEN
      Qreg <= Dreg;
    END IF;
  END PROCESS;

END;
