

entity top is
    generic(
        C_CLK_COUNTER_WIDTH: integer
    );
    port(
        reset, enable: in std_logic;
        clk, clk_10ms: in std_logic;
        load: in std_logic;
        wr_segment_ena: std_logic;
        wr_segment_sel: in std_logic_vector(2 downto 1);
        wr_segment_value: in std_logic_vector(3 downto 0);
        count_10ms: in std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0);
        count_5ms: in std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0);
        seg_sel: out std_logic_vector(7 downto 0);
        cathodes: out std_logic_vector(7 downto 0);
        hr_d1: out std_logic_vector(1 downto 0);
        hr_d0: out std_logic_vector(3 downto 0);
        mi_d1: out std_logic_vector(3 downto 0);
        mi_d0: out std_logic_vector(3 downto 0);
        se_d1: out std_logic_vector(3 downto 0);
        se_d0: out std_logic_vector(3 downto 0);
        fs_d1: out std_logic_vector(3 downto 0);
        fs_d0: out std_logic_vector(3 downto 0)
    );
end top;

architecture arch of top is
    type digits_memory is array(0 to 7) of std_logic_vector(3 downto 0);
    signal written_time: digits_memory := (others => (others => '0'));
    signal current_time: digits_memory := (others => (others => '0'));
begin

    process(clk)
	begin
		if rising_edge(clk) then
			if(wr_segment_ena = '1') then
                written_time(to_integer(unsigned(wr_segment_sel))) <= wr_segment_value; 
			end if;
		end if;	
	end process;


    create_10ms_clock: entity work.clk_div
        generic map(C_COUNTER_WIDTH => C_CLK_COUNTER_WIDTH)
        port map(
            period => count_10ms,
            pulse_width => count_5ms,
            clk_in => clk,
            clk_out => clk_10ms
        );

    digital_clock_0: entity work.digital_clock
        port map(
            clk_10ms => clk_10ms,
            enable => enable,
            reset => reset,
            load => load,
            hr_d1_in => written_time(0)(1 downto 0),
            hr_d0_in => written_time(1),
            mi_d1_in => written_time(2),
            mi_d0_in => written_time(3),
            se_d1_in => written_time(4),
            se_d0_in => written_time(5),
            fs_d1_in => written_time(6),
            fs_d0_in => written_time(7),
            hr_d1 => current_time(0)(1 downto 0),
            hr_d0 => current_time(1),
            mi_d1 => current_time(2),
            mi_d0 => current_time(3),
            se_d1 => current_time(4),
            se_d0 => current_time(5),
            fs_d1 => current_time(6),
            fs_d0 => current_time(7)
        );


        display_0: entity work.digits_display
            port map(
                clk      => clk,
                rstn     => not reset,
                num_0    => current_time(0)(1 downto 0),
                num_1    => current_time(1),
                num_2    => current_time(2),
                num_3    => current_time(3),
                num_4    => current_time(4),
                num_5    => current_time(5),
                num_6    => current_time(6),
                num_7    => current_time(7),
                seg_sel  => seg_sel,
                cathodes => cathodes
            );


        hr_d1 <= current_time(0)(1 downto 0);
        hr_d0 <= current_time(1);
        mi_d1 <= current_time(2);
        mi_d0 <= current_time(3);
        se_d1 <= current_time(4);
        se_d0 <= current_time(5);
        fs_d1 <= current_time(6);
        fs_d0 <= current_time(7);
end arch;



