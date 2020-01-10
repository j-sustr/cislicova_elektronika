entity dec_1ofn_8bit is
port(
    a: in std_logic_vector(2 downto 0);
    q: out std_logic_vector(7 downto 0)
);
end dec_1ofn_8bit;

architecture dataflow of dec_1ofn_8bit is
begin
    with a select
        q <= "00000001" when "000";
             "00000010" when "001";
             "00000100" when "010";
             "00001000" when "011";
             "00010000" when "100";
             "00100000" when "101";
             "01000000" when "110";
             "00000000" when others;
end dataflow;



