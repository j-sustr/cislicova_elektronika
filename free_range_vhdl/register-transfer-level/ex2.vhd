



entity top of
    port(
        clk, ds: in std_logic;
        x, y, z: in std_logic_vector(7 downto 0);
        ms: std_logic_vector(1 downto 0);
        rb, ra: out std_logic_vector(7 downto 0)
    );
end top;


architecture arch of top is
    component mux8_4t1
        port(
            x, y, z: in std_logic_vector(7 downto 0);
            f: out std_logic_vector(7 downto 0)
        );
    end component;

    component reg8
        port(
            clk, ld: in std_logic;
            d: in std_logic_vector(7 downto 0);
            f: out std_logic_vector(7 downto 0)
        );
    end component;

    component dec1t2
        port(
            ds: in std_logic;
            out0, out1: out std_logic
        );
    end component;

    signal dec_out0, dec_out1: std_logic;
    signal mux_out, ra_out, rb_out: std_logic_vector(7 downto 0);
begin;
    dec: dec1t2 port map(
        ds => ds,
        out0 => dec_out0,
        out1 => dec_out1
    );
end arch;