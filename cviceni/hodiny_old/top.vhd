



entity hodiny is
    port(
        clk, reset, enable in: std_logic;
        load: in std_logic;
        load_select: in std_logic_vector(2 downto 0);
        load_value: in std_logic_vector(5 downto 0);
    );
end hodiny;


architecture arch of hodiny is
    signal cntr_1s_enable: std_logic := '0';
    signal cntr_60s_enable: std_logic := '0';
    signal cntr_60m_enable: std_logic := '0';
    signal cntr_12h_enable: std_logic := '0';

    signal cntr_100ms_max: std_logic := '0';
    signal cntr_1s_max: std_logic := '0';
    signal cntr_60s_max: std_logic := '0';
    signal cntr_60m_max: std_logic := '0';
    signal cntr_12h_max: std_logic := '0';
    signal post_meridies: std_logic := '0';
    
    signal cntr_100ms_value: std_logic_vector(24 downto 0) := (others => '0');
    signal cntr_1s_value: std_logic_vector(4 downto 0) := (others => '0');
    signal cntr_60s_value: std_logic_vector(6 downto 0) := (others => '0');
    signal cntr_60m_value: std_logic_vector(6 downto 0) := (others => '0');
    signal cntr_12h_value: std_logic_vector(4 downto 0) := (others => '0');
    
begin

    cntr_1s_enable <= enable and cntr_100ms_max;
    cntr_60s_enable <= enable and cntr_1s_max;
    cntr_60m_enable <= enable and cntr_60s_max;
    cntr_12h_enable  <= enable and cntr_60m_max;

    cntr_100ms_max <= '1' when (cntr_100ms_value = "100110001001011001111111") else '0';
    cntr_1s_max <= '1' when (cntr_1s_value = "1001") else '0';
    cntr_60s_max <= '1' when (cntr_60s_value = "111011") else '0';
    cntr_60m_max <= '1' when (cntr_60m_value = "111011") else '0';
    cntr_12h_max <= '1' when (cntr_12h_value = "1011") else '0';
    

    cntr_100ms: entity work.counter_x_load
        generic map(
            C_WIDTH => 24  
        );
        port map(
            clk => clk,
            reset => reset,
            enable => '1',
            load => '0',
            decrement => '0',
            load_value => open,
            value => cntr_100ms_value
        );
    
    cntr_1s: entity work.counter_x_load
        generic map(
            C_WIDTH => 4 
        );
        port map(
            clk => clk,
            reset => reset,
            enable => cntr_1s_enable,
            load => '0',
            decrement => '0',
            load_value => load_value(3 downto 0),
            value => cntr_1s_value
        );
        
    cntr_60s: entity work.counter_x_load
        generic map(
            C_WIDTH => 6 
        );
        port map(
            clk => clk,
            reset => reset,
            enable => cntr_60s_enable,
            load => '0',
            decrement => '0',
            load_value => load_value(3 downto 0),
            value => cntr_1s_value
        );
        
    
    process()


end arch;