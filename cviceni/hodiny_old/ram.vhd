LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ram is
	generic(
		C_DATA_WIDTH: integer := 8;    --width of each data word
        C_SIZE: integer := 64   --number of data words the memory can store
    );  
	port(
		clk		: in std_logic;                             --system clock
		wr_ena	: in std_logic;                             --write enable
		addr    : in integer range 0 to C_SIZE-1;             --address to write/read
		data_in	: in std_logic_vector(C_DATA_WIDTH-1 downto 0);  --input data to write
		data_out: out std_logic_vector(C_DATA_WIDTH-1 downto 0)) --output data read
end ram;

architecture logic of ram is
	type memory_t is array(0 to C_SIZE-1) of std_logic_vector(C_DATA_WIDTH-1 downto 0);  --data type for memory
	SIGNAL ram:	memory_t;  --memory array
	SIGNAL addr_int: integer range 0 to C_SIZE-1;  --internal address register
begin

	process(clk)
	begin
		if rising_edge(clk) then

			if(wr_ena = '1') then     --write enable is asserted
				ram(addr) <= data_in;  --write input data into memory
			end if;
			
			addr_int <= addr;         --store the address in the internal address register

		end if;	
	end process;
	
	data_out <= ram(addr_int);      --output data at the stored address
	
end logic;