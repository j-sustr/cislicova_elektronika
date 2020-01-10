---------------
--- Big AND ---
---------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY big_and IS
PORT(
    in1,in2 : IN STD_LOGIC;
    out1 : OUT STD_LOGIC);
END big_and;

ARCHITECTURE big_and_arc OF big_and is
BEGIN
    out1 <= in1 AND in2;
END big_and_arc;

---------------
--- Big NOT ---
---------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY big_not IS
PORT(
    in1 : IN STD_LOGIC;
    out1 : OUT STD_LOGIC);
END big_not;

ARCHITECTURE big_not_arc OF big_not IS
BEGIN
    out1 <= NOT in1;
END big_not_arc;

--------------
--- Big OR ---
--------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY big_or IS
PORT(
    in1,in2 : IN STD_LOGIC;
    out1 : OUT STD_LOGIC);
END big_or;

ARCHITECTURE big_or_arc OF big_or IS
BEGIN
    out1 <= in1 OR in2;
END big_or_arc;

-----------------------
--- Big 4-Input AND ---
-----------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY big_and4 IS
PORT(
    in1,in2,in3,in4 : IN STD_LOGIC;
    out1 : OUT STD_LOGIC);
END big_and4;

ARCHITECTURE big_and4_arc OF big_and4 IS
BEGIN
    out1 <= in1 AND in2 AND in3 AND in4;
END big_and4_arc;

-------------------
--- 3:8 Decoder ---
-------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY dec3to8 IS
PORT(
    ins : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    outs : OUT STD_LOGIC_VECTOR(0 TO 8));
END dec3to8;

ARCHITECTURE dec3to8_arc OF dec3to8 IS
BEGIN
WITH ins SELECT
    outs <= "10000000" WHEN "000",
            "01000000" WHEN "001",
            "00100000" WHEN "010",
            "00010000" WHEN "011",
            "00001000" WHEN "100",
            "00000100" WHEN "101",
            "00000010" WHEN "110",
            "00000001" WHEN "111",
            "00000000" WHEN OTHERS;
END dec3to8_arc;