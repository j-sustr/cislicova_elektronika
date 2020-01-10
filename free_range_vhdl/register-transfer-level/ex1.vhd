entity mux2t1 is
    port (
        a: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        sel: in std_logic;
        q: out std_logic
    );
end mux2t1;

architecture arch of mux2t1 is
begin
    with sel select
        q <= a when '1',
             b when '0',
             ('0' => others) when others;

end arch;


entity reg8 is
    port (
        clk, lda: in std_logic;
        d: in std_logic_vector(7 downto 0);
        q: out std_logic_vector(7 downto 0)
    );
end reg8;


architecture arch of reg8 is
    signal reg: std_logic_vector(7 downto 0);
begin
    process(clk)
        if rising_edge(clk) then
            if lda = '1' then
                reg <= d;
            end if;
        end if;
    end process;

    q <= reg;

end arch;



----------------------------------------------------

entity crk is
    port(
        lda, clk, sel: in std_logic;
        a, b: in std_logic_vector(7 downto 0);
        f: out std_logic_vector(7 downto 0)
    );
end entity;


architecture arch of crk is

    component reg8 
        port (
            clk, lda: in std_logic;
            d: in std_logic_vector(7 downto 0);
            q: out std_logic_vector(7 downto 0)
        );
    end component;

    component mux2t1
        port (
            a: in std_logic_vector(7 downto 0);
            b: in std_logic_vector(7 downto 0);
            sel: in std_logic;
            q: out std_logic
        );
    end component;

    signal muxout: std_logic_vector(7 downto 0);

begin

    mux: mux2t1 port map (
        a => a,
        b => b,
        sel => sel,
        q => muxout
    );

    reg: reg8 port map (
        lda => lda,
        clk => clk,
        sel => sel,
        d => muxout,
        q => f,
    );

end arch ;