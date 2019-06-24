library ieee;
use ieee.std_logic_1164.all;

-- Elaine Ou, ELEC2602 2011
-- This	is a hexadecimal decoder
-- It converts a 4-bit binary number to a hexadecimal number
-- Truth table:
-- 0000  0
-- 0001  1
-- 0010  2
-- 0011  3
-- 0100  4
-- 0101  5
-- 0110  6
-- 0111  7
-- 1000  8
-- 1001  9
-- 1010  10
-- 1011  11
-- 1100  12
-- 1101  13
-- 1110  14
-- 1111  15


entity hexdecode is
	port ( A : IN std_logic_vector(3 downto 0);
			   D : OUT std_logic_vector(0 to 6));
end;

ARCHITECTURE behaviour of hexdecode IS
	signal i0, i1, i2, i3, i4, i5, i6, i7 : std_logic;
	signal i8, i9, i10, i11, i12, i13, i14, i15 : std_logic;
begin
	i0 <= not A(3) and not A(2) and not A(1) and not A(0);
	i1 <= not A(3) and not A(2) and not A(1) and A(0);
	i2 <= not A(3) and not A(2) and A(1) and not A(0);
	i3 <= not A(3) and not A(2) and A(1) and A(0);
	i4 <= not A(3) and A(2) and not A(1) and not A(0);
	i5 <= not A(3) and A(2) and not A(1) and A(0);
	i6 <= not A(3) and A(2) and A(1) and not A(0);
	i7 <= not A(3) and A(2) and A(1) and A(0);
	i8 <= A(3) and not A(2) and not A(1) and not A(0);
	i9 <= A(3) and not A(2) and not A(1) and A(0);
	i10 <= A(3) and not A(2) and A(1) and not A(0);
	i11 <= A(3) and not A(2) and A(1) and A(0);
	i12 <= A(3) and A(2) and not A(1) and not A(0);
	i13 <= A(3) and A(2) and not A(1) and A(0);
	i14 <= A(3) and A(2) and A(1) and not A(0);
	i15 <= A(3) and A(2) and A(1) and A(0);

	D(0) <= not(i0 or i2 or i3 or i5 or i6 or i7 or i8 or i9
				or i10 or i11 or i12 or i13 or i14 or i15);
	D(1) <= not(i0 or i1 or i2 or i3 or i4 or i7 or i8 or i9
				or i10 or i11 or i13);
	D(2) <= not(i0 or i1 or i3 or i4 or i5 or i6 or i7 or i8 or i9
				or i10 or i11 or i13);
	D(3) <= not(i0 or i2 or i3 or i5 or i6 or
				i8 or i11 or i12 or i13 or i14);
	D(4) <= not(i0 or i2 or i6 or i8 or i10 or
				i11 or i12 or i13 or i14 or i15);
	D(5) <= not(i0 or i4 or i5 or i6 or i8 or i9 or i10 or i11
				or i12 or i13 or i14 or i15);
	D(6) <= not(i2 or i3 or i4 or i5 or i6 or i8 or
				i9 or i10 or i11 or i14 or i15);

END;
