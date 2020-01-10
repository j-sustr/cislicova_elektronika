library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- test bench slouzi pro simulaci navrzeneho obvodu
-- nema vstupy ani vystupy
entity adder8bit_tb is
end adder8bit_tb;

architecture Behavioral of adder8bit_tb is

    -- 
	signal a    : signed(7 downto 0);
	signal b    : signed(7 downto 0);
	signal q    : std_logic_vector(7 downto 0);
	signal c    : std_logic;
	signal over : std_logic;

begin

	-- instance testovane jednotky : Design Under Test
	dut : entity work.adder8bit
		port map(
			a    => std_logic_vector(a),
			b    => std_logic_vector(b),
			q    => q,
			c    => c,
			over => over
		);

	-- zde se odehrava samotne overovani funkce
	tb : process
	begin
	   -- na pocatku simulace nejsou vstupy definovany
		a <= to_signed(-128, a'length);
		b <= to_signed(-128, a'length);
		-- prikaz wait for X <ps,ns,us,ms>
	    -- provede vyhodnoceni vsech prikazu v procesu
		wait for 10 ns;
		--a <= to_signed(-128, a'length);
		--b <= to_signed(-127, a'length);
		wait for 10 ns;
		-- takto bychom se upsali xmrti
		
		
		-- k otestovani vsech variant vyuzijte dva vnorene cykly for		
		for i in -5 to 5 loop
		  -- vyuzijte konverznich funkci mezi signed, int, std_logic_vector
		  for j in -5 to 5 loop
		      a <= to_signed(21 * i, a'length);
		      b <= to_signed(21 * j, b'length);
		      wait for 10 ns;
		  end loop;
		  
		end loop;		
	end process;

end Behavioral;
