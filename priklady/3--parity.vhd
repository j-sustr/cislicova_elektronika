

entity odd_parity is
    generic(
        length: integer := 4
    );
    port(
        x: std_logic_vector(length - 1 downto 0);
        y: std_logic;
    );
end odd_parity;


architecture arch of odd_parity is
begin
    y <= xor_reduce(x);
begin

    

end arch ; -- arch



function xor_reduce( v: std_logic_vector ) return std_ulogic is
    variable result: std_ulogic;
begin
    for i in v'range loop
        if i = v'left then
            result := v(i);
        else
            result := result xor v(i);
        end if;;
    end loop;
    return result;
end or_reduce;