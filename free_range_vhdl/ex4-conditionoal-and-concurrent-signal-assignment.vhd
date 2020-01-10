-- Syntax for the conditional signal assignment statement
<target> <= <expression> when <condition> else
            <expression> when <condition> else
            <expression>

-- Syntax for the selected signal assignment statement
with <choose_expression> select
    target <= <expression> when <choice> | <choice> | <choice>;
              <expression> when <choices>;
              <expression> when <choices>;




--___________________________________________________________________________
-- a)
-- F(A, B) = (!A || B) && (!B || C || !D) && (!A || D)


architecture my_func1_a of my_func1 is
begin
    F <= '1' when ((A = '0' or B = '1') and (B = '0' or C = '1' or D = '0') and (A = '0' or D = '1')) else '0';
end my_func1_a;

architecture my_func1_b of my_func1 is
begin
    with ((A = '0' or B = '1') and (B = '0' or C = '1' or D = '0') and (A = '0' or D = '1')) select
        F <= '1' when '1',
            '0' when '0',
            '0' when others;
end my_func1_b;

--______________________________________________________________________________


-- F(A, B, C, D) = (!A || !B || C || !D) && (!A || !B || C || D)

