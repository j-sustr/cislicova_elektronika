LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

----------------------
--- 8-bit, 2:1 Mux ---
----------------------
ENTITY mux2i1o8w IS
PORT(
    in1,in2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    sel : IN STD_LOGIC;
    out1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END mux2i1o8w;

ARCHITECTURE mux2i1o8w OF mux2i1o8w IS
BEGIN
    WITH sel SELECT
        out1 <= in1 WHEN '0',
                in2 WHEN '1',
                (OTHERS => '0') WHEN OTHERS;
END mux2i1o8w;

----------------------
--- 8-bit, 4:1 Mux ---
----------------------
ENTITY mux4i1o8w IS
PORT(
    in0,in1,in2,in3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    out1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END mux4i1o8w;

ARCHITECTURE mux4i1o8w OF mux4i1o8w IS
BEGIN
    WITH sel SELECT
        out1 <= in0 WHEN "00",
            in1 WHEN "01",
            in2 WHEN "10",
            in3 WHEN "11",
            (OTHERS => '0') WHEN OTHERS;
END mux4i1o8w;

-------------------
--- 1:2 Decoder ---
-------------------
ENTITY decoder1to2 IS
    PORT(
        in1 : IN STD_LOGIC;
        out0,out1 : OUT STD_LOGIC);
END decoder1to2;

ARCHITECTURE dec1to2 OF decoder1to2 IS
BEGIN
    output_process: PROCESS (in1) IS
    BEGIN
        IF (in1 = '0') THEN
            out0 <= '1';
            out1 <= '0';
        ELSIF (in1 = '1') THEN
            out0 <= '0';
            out1 <= '1';
        ELSE
            out0 <= '0';
            out1 <= '0';
        END IF;
    END PROCESS output_process;
END dec1to2;

----------------------
--- 8-bit Register ---
----------------------
ENTITY reg8 IS
PORT(
    REG_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    CLK,LD : IN STD_LOGIC;
    REG_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END reg8;

ARCHITECTURE reg OF reg8 IS
BEGIN
    load_process: PROCESS(CLK) IS
    BEGIN
        IF (RISING_EDGE(CLK)) THEN
            IF (LD = '1') THEN
                REG_OUT <= REG_IN;
                END IF;
        END IF;
    END PROCESS load_process;
END reg;