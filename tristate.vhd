LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity tristate is
  port( 		    Atr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				     enable : in std_logic;
                Qtr : out std_logic_VECTOR(15 DOWNTO 0));
end tristate;

architecture behaviour of tristate is
begin
  process (enable)
  --process (Atr, enable)
  begin
		IF(enable = '1') then
			Qtr <= Atr;
		ELSE
			Qtr <= (others => 'Z');
		END IF;
  end process;
end behaviour;
