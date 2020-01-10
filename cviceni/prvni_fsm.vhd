
entity FSM is
    port(
        clk: in std_logic;
        key: in std_logic_vector(2 downto 0);
        press: in std_logic;
        unlock: out std_logic;
        alarm: out std_logic
    );
end FSM;

architecture RTL of FSM is
    type state_type is (SKP0, SKP1, SKP2, SKP1E, SKP2E, SUNLOCK, SALARM);
    constant code0 : std_logic_vector(2 downto 0) := "101";
    constant code1 : std_logic_vector(2 downto 0) := "001";
    constant code2 : std_logic_vector(2 downto 0) := "100";
    signal current_state : state_type := SKP0;
    signal next_state : state_type;
begin

    sync: process(clk)
    begin
        if rising_edge(clk) then
            if SRST = '0' then
                current_state <= next_state;
            else
                current_state <= SKP0;
            end if;
        end if;
    end process;
    
    comb: process(current_state)
    begin
        next_state <= current_state;
    
        case current_state is
            when SKP0 =>
                if press = '1' then
                    if key = code0 then
                        next_state <= SKP1;
                    else
                        next_state <= SKP1E;
                    end if;
                end if;
            when SKP1 =>
                if press = '1' then
                    if key = code1 then
                        next_state <= SKP2;
                    else
                        next_state <= SKP2E;
                    end if;
                end if;
            when SKP2 =>
                if press = '1' then
                    if key = code2 then
                        next_state <= SUNLOCK;
                    else
                        next_state <= SALARM;
                    end if;
                end if;
            when SKP1E =>
                if press = '1' then
                    next_state <= SKP2E;
                end if;
            when SKP2E =>
                if press = '1' then
                    next_state <= SALARM;
                end if;
            when SUNLOCK =>
                next_state <= SKP0;
            when SALARM =>
                next_state <= SKP0;
            when others =>
                next_state <= SKP0;
        end case;
    end process;
    
    unlock <= '1' when current_state = SUNLOCK else '0';
    alarm <= '1' when current_state = SALARM else '0';
end RTL;