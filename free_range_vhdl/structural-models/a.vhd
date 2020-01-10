library IEEE;
use IEEE.std_logic_1164;

entity circuit_a is
    port(
       A, B, C: in std_logic;
       F: out std_logic 
    );
end circuit_a;




architecture my_circuit_a of circuit_a is

    component and_gate
        port(A, B: in std_logic;
            F: out std_logic);
    end component;

    component or_gate
        port(A, B: in std_logic;
            F: out std_logic);
    end component;

    signal x1, x2, x3, x4, x5: std_logic;

begin

    and1: and_gate
    port map (
        A => A,
        B => x1,
        F => x4
    );

    and1: and_gate
    port map (
        A => x2,
        B => x3,
        F => x5
    );

    or1: or_gate
    port map(
        A => x4,
        B => x5,
        F => F
    );

    x1 <= not B;
    x2 <= not A;
    x3 <= not C;

end my_circuit_a;

