-- 2. a)

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ckt_a IS
    PORT(
        A,B,C,D : IN STD_LOGIC;
        F : OUT STD_LOGIC);
END ckt_a;

ARCHITECTURE ckt_a_conditional OF ckt_a IS
BEGIN
    F <=
        '1' WHEN( A = '0' AND C = '1' AND D = '0' ) ELSE
        '1' WHEN( B = '0' AND C = '1') ELSE
        '1' WHEN( B = '1' AND C = '1' AND D = '0' ) ELSE
        '0';
END ckt_a_conditional;

ARCHITECTURE ckt_a_selected OF ckt_a IS
    SIGNAL ins : STD_LOGIC_VECTOR(0 TO 3);
BEGIN
    ins <= A & B & C & D;
    WITH ins SELECT
        F <=
            '1' WHEN "0010"|"0110",
            '1' WHEN "0010"|"0011"|"1010"|"1011",
            '1' WHEN "0110"|"1110",
            '0' WHEN OTHERS;
END ckt_a_selected;