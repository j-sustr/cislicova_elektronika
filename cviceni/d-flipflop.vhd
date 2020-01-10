entity d_flipflop is
    port (
        reset: in std_logic;
        set: in std_logic;
        enable: in std_logic;
        clk: in std_logic;
        d: in std_logic;
        q: out std_logic
    );
end d_flipflop;

architecture async of d_flipflop is
begin
    dff: process (clk, set, reset)
    begin
        if (reset = '1') then
            q <= '0';
        elsif (set = '1') then
            q <= '1';
        elsif (enable = '1') and rising_edge(clk) then
            q <= d;
        end if;
    end process dff;
end async; 
   

architecture sync of d_flipflop is
begin
    dff: process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                q <= '0';
            elsif (set = '1') then
                q <= '1';
            elsif (enable = '1') then
                q <= d;
            end if;
        end if;
    end process dff;
end sync; 
       