library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PHANTOM_DRIVER_tb is
end PHANTOM_DRIVER_tb;

architecture sim of PHANTOM_DRIVER_tb is
component PHANTOM_DRIVER
	port	(
		-- inputs
			--nRES	: in std_logic;	-- This input MUST be Shumitt mode
			--		76MHz clock for DDS_INIT
			MCLK	: in std_logic;
			--		ECD clock
			CLK 	:	in std_logic;

			--		user interface
			SW		: in std_logic_vector(4 downto 1);
			-- TEST <= SW(3);
			-- ZOUT <= SW(2);
			-- AMP(0) <= SW(1);

			-- Future use
			LOW_BAT	:	in std_logic;

		--	outputs
			--    for DDS unit
			PSEL, FSEL, RESET, SDATA, SCLK, FSYNC	: out std_logic;

			--		for output of the box
			SYNC	:	out std_logic;

			--		for controlling the status
			ZOUT	: out std_logic;
			AMP		: out std_logic_vector(1 downto 0);

			--		for MUX
			CH		:	out std_logic_vector(2 downto 0);
			CS		:	out std_logic_vector(6 downto 0);

			--		Aux output
			D			: out std_logic_vector(4 downto 1);

			-- future use
			OE			: out std_logic
	);
end component;

-- signal tb_nRES  	: std_logic:='0';
signal tb_MCLK		: std_logic:='0';
signal tb_CLK   	: std_logic:='0';
signal tb_SW			: std_logic_vector(4 downto 1):="0000";
signal tb_LOW_BAT	: std_logic:='0';

signal tb_FSYNC, tb_SDATA, tb_SCLK	: std_logic; --for DDS

signal tb_SYNC, tb_ZOUT	: std_logic;
signal tb_AMP	: std_logic_vector(1 downto 0);
signal tb_CH	:	std_logic_vector(2 downto 0);
signal tb_CS	: std_logic_vector(6 downto 0);


-- signal for initiating end of simulation.
signal SIM_END 		: boolean := false;

-- CLK
constant PERIOD_A : time := 100 ns;
constant HALF_OF_A: time := PERIOD_A/2;

-- total period of this simulation
constant PERIOD_B : time := 20 us;

begin
	DUT:PHANTOM_DRIVER
 		port map(

		--nRES => tb_nRES,
		MCLK => tb_MCLK,
		CLK => tb_CLK,
		SW	=> tb_SW,
		LOW_BAT => tb_LOW_BAT,

	  SDATA => tb_SDATA, SCLK =>tb_SCLK, FSYNC => tb_FSYNC,
		SYNC => tb_SYNC,

		ZOUT => tb_ZOUT,
		AMP	=> tb_AMP,
		CH	=> tb_CH,
		CS	=> tb_CS
		);

	process
	begin
		wait for PERIOD_A;
		-- Enable counters
		tb_LOW_BAT <= '1';

		loop
			wait for HALF_OF_A;

			tb_CLK <= not(tb_CLK);
			tb_MCLK <= not(tb_MCLK);

			if (SIM_END) then
				wait;
			end if;
		end loop;

	end process;

-- Controlling the total simulation period of time
	process
	begin
			wait for PERIOD_B;
			SIM_END <= true;
			wait;
	end process;

end sim;
