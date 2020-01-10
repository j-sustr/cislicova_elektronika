library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- knihovna numeric_std umoznuje aritmeticke operace s typy
-- unsigned - kladna cela cisla <0,(2**n)-1>
-- signed - cela cisla <-(2**(n-1)),(2**(n-1))-1> v dvojkovem doplnku
use IEEE.NUMERIC_STD.ALL;

-- pomoci konverznich funkci a operatoru scitani realizujte
-- 8 bit scitacku q = (a + b) v signed (2kovy doplnek) formatu
-- realizujte vystup prenosu carry C
-- realizujte priznak preteceni overflow O
entity adder8bit is
	Port(
	-- signed a unsigned pouzivame pouze uvnitr architektury!!!
		a    : in  std_logic_vector(7 downto 0);
		b    : in  std_logic_vector(7 downto 0);
		q    : out std_logic_vector(7 downto 0);
		c    : out std_logic;
		over : out std_logic
	);
end adder8bit;

architecture Behavioral of adder8bit is

	-- zde deklarujte pomocne signaly typu signed .. viz nize
	signal a_tmp: signed(8 downto 0);
	signal q_tmp: signed(8 downto 0);
	signal q_res: signed(7 downto 0);
	
begin

    -- operator (signed) + (signed) vraci signed s delkou vetsiho z operandu
	-- pro realizice 8 bit scitacky s prenosem musite vytvorit 9bit scitacku
	-- rozsirit muzete pomoci funkce resize(signed, len), ktera vraci signed nove delky
	--     signed je signal typu signed, ktery se bude rozsirovat
	--     len je delka po rozsireni

    -- pro realizaci priznaku overflow muzete vyuzit bud podmineneho prikazu prirazeni
    --      over <= '1' when ...
    -- nebo booleovskeho vyrazu
    --      over <= a(?) and b(?) and ...... 
    -- v simulaci porovnejte rozdil
    
    a_tmp <= resize(signed(a), a_tmp'length);
    
    q_tmp <= a_tmp + signed(b);
    
    q_res <= (q_tmp(q'range));
    
    q <= std_logic_vector(q_res);
    
    c <= q_tmp(q_tmp'high);  -- spatne (dobre pouze pro kladna) !!! 
    
    over <= '1' when (a(a'high) = '1' and b(b'high) = '1' and q_res(q_res'high) = '0') 
                  or (a(a'high) = '0' and b(b'high) = '0' and q_res(q_res'high) = '1') else '0';
              

end Behavioral;
