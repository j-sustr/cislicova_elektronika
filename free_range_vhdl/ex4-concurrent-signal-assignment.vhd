-- a)

-- F(A, B) = !A && B || A || A && !B

entity my_func1 is 
port(
    A, B : in std_logic;
    F: out std_logic
);
end my_func1;

architecture my_func1_a of my_func1 is
begin
    F <= (not A and B) or A or (A and not B);
end my_func1_a;


--__________________________________________________________________
-- d)

--    A B C D
-- 0: 0 0 0 0
-- 1: 0 0 0 1
-- 2: 0 0 1 0
-- 3: 0 0 1 1
-- 4: 0 1 0 0
-- 5: 0 1 0 1
-- 6: 0 1 1 0
-- 7: 0 1 1 1
-- 8: 1 0 0 0
-- 9: 1 0 0 1
-- 10: 1 0 1 0
-- 11: 1 0 1 1
-- 12: 1 1 0 0
-- 13: 1 1 0 1
-- 14: 1 1 1 0
-- 15: 1 1 1 1

-- F(A, B, C, D) = (!A || !B || C || !D) && (!A || !B || C || D)


entity my_func2 is 
port(
    A, B, C, D : in std_logic;
    F: out std_logic
);
end my_func2;

architecture my_func2_a of my_func2 is
begin
        F <= (not A or not B or C or not D) and (not A or not B or C or D);
end my_func2_a;