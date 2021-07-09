--mem load -i C:/Users/miyam/OneDrive/Documents/HDL/ROM/simulation/modelsim/patch_table.mem -format hex -startaddress 50 -endaddress 0 -update_properties /sim/DUT/ROM

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity OUTPUT_PATCH is

	generic ( 
		INPUT_CASE_WIDTH:	integer :=6;
		OUTPUT_WIDTH:		integer	:=6;
			-- 入力の状態数を表すためのビット数指定と、出力のビット数

		PATCH_FILE_NAME:	string :="patch_table.mif"
			-- 入出力の対応表のファイル名
	);

	port (
		ADDR	: in 	unsigned(INPUT_CASE_WIDTH-1 downto 0);
		Q		: out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
	);

end entity;

architecture RTL of OUTPUT_PATCH is

	-- constant PATCH_FILE_NAME : string :="patch_table.mif";

	-- Build a 2-D array type for the patch table
	subtype WORD_T 	is std_logic_vector(OUTPUT_WIDTH-1 downto 0);
		type MEMORY_T is array(2**INPUT_CASE_WIDTH-1 downto 0) of WORD_T;

	signal ROM:MEMORY_T;
	attribute ram_init_file : string;
	attribute ram_init_file of ROM :
		signal is PATCH_FILE_NAME;
	-- ram_init_fileはファイルを指定するための特別なアトリビュート名

begin

	Q <= ROM(to_integer(ADDR));

end RTL;
