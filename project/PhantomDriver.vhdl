---- Phantom Driver
--		 回路図  DR20000119−00のためのCPLD
--
-- 		DR20000120-00:
--			UNDERCONSTRUCTION	V0.1	2014/12/16	M.Miyamoto
--			RELEASE				V1.0	2014/12/17	M.Miyamoto
--
--			DEVELOPPING 		D1.1	2015/02/20	M.Miyamoto
--			Drive fixed ECD channel on FIX signal (= not (SW2))
--				FIX=1, ECD is fixed   FIX=0, normal operation
--				the channel is determined by a constant "fixed_ECD"
--
--		DR20000120-01:
--			全面見直し
--			RELEASE		2.0	2020/05/07	M.Miyamoto
--				シミュレーションによるテスト済み
--				！！実機テストと調整が必要！！
--	
--			RELEASE		2.1  2020/08/23
--				実機テスト完了　調整済み
--
--			RELEASE		2.2 	2020/09/01
--				FSYNCがアサートされているときCLKをうごかさない（DDSのタイミング要求と整合）
--				動作確認済み
-- 
-- 		2020/9/8
--		Develop branch
-- 			Calibration Coil Driver 用に24chに変更
-- 				DDS Frequency = 80Hz
--				ECD Channel = 24
-- 				burst = 24 + 1
-- 			同時にECD数、バースト波の設定をパラメタ化した。
-- 			コンパイル確認。回路図確認。



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity PHANTOMDRIVER is
	port (
	-- inputs

		--		76MHz clock from DDS_INIT
		MCLK	: in std_logic;
		
		--		ECD clock
		CLK 	: in std_logic;

		--		user interface
		SW		: in std_logic_vector(5 downto 1);

		-- 		Utilize as !RESET
		LOW_BAT	: in std_logic;

	--	outputs
		--    for DDS unit
		PSEL, FSEL, RESET, SDATA, SCLK, FSYNC	: out std_logic;

		--		for sync signal output
		SYNC	: out std_logic;

		--		for controlling the status
		ZOUT	: out std_logic;
		AMP		: out std_logic_vector(1 downto 0);
		
		-- 	for selecting input signal
		SEL_EXT, SEL_ANALOG	: out std_logic;

		--		for MUX
		CH		: out std_logic_vector(2 downto 0);
		CS		: out std_logic_vector(6 downto 0);

		--		Aux output
		D		: out std_logic_vector(4 downto 1);

		-- future use
		OE		: out std_logic
	);
end PHANTOMDRIVER;


architecture Behavioral of PHANTOMDRIVER is

-- constants for configure architecture:
	constant ECD_COUNT 	: integer :=24;
	constant ECD_W		: integer :=integer(Ceil(log(real(ECD_COUNT-1),2.0)));

	constant BURST_MARK		: integer := 24;
	constant BURST_SPACE	: integer := 1;

	constant FIXED_OUTPUT_CH : integer :=12 ;
		--  fix output on DRIVE_13(=12+1) output. 

	constant DDS_FREQ : integer := 80; -- [/Hz]

--  internal signals
	signal ECD		: unsigned(ECD_W-1 downto 0);
	
	signal CHANNEL	: unsigned(5 downto 0);
	signal PATCH_OUT: std_logic_vector(5 downto 0);

	signal nRES, int_INH, dec_INH, TEST		: std_logic;

begin
-- サブモジュールのインスタンス化

	-- DDS
	DDS_INIT: entity work.DDS_INIT
		generic map (
			FREQUENCY => DDS_FREQ
		)

		port map 	(
			nRES => nRES, MCLK => MCLK,
			PSEL => PSEL, FSEL => FSEL, RESET => RESET,
			SDATA => SDATA, SCLK => SCLK, FSYNC => FSYNC
		);

	-- シーケンサ
	SEQUENCER: entity work.SEQUENCER
		generic map (
			ECD_NUMBER => ECD_COUNT,
			ECD_Q_WIDTH => ECD_W, 
			BURST_MARK => BURST_MARK,
			BURST_SPACE => BURST_SPACE
		)
		
		port map (
			nRES => nRES, CLK => CLK,
			SYNC => SYNC, INH => int_INH, ECD => ECD
		);

	-- パッチ（非同期ROM）
	OUTPUT_PATCH: entity work.OUTPUT_PATCH
		generic map (
			INPUT_CASE_WIDTH => ECD_W,
			PATCH_FILE_NAME => "patch_table.mif"
			-- 入出力の対応表のファイル名指定
		)

		port map (
			ADDR => ECD,  Q => PATCH_OUT
		);
		

-- 回路

	nRES <= LOW_BAT;
	
-- テストの場合の動作を規定 INHは常にネゲート、出力チャネルは固定(FIXED_OUTPUT_CH)
	process(TEST, PATCH_OUT, int_INH)
	begin
		case TEST is
			when '1' =>
				dec_INH <= '0';
				CHANNEL <= to_unsigned(FIXED_OUTPUT_CH, CHANNEL'length);
			when others =>
				dec_INH <= int_INH;
				CHANNEL <= unsigned(PATCH_OUT);
		end case;
	end process;

-- INH付きデコーダ
--  CS : Active Low
--  CH : Active High
	process(CHANNEL, dec_INH)
	begin
		case dec_INH is
			when '1' =>
				CS <= (others => '1');
			when others =>
				CS <= (others => '1');
				CS(to_integer(CHANNEL(5 downto 3))) <= '0'; 
		end case;
	end process;
	CH <= std_logic_vector(CHANNEL(2 downto 0));

-- UI & settings
	-- settings for driver circuit
	TEST 		<= not(SW(4));
	ZOUT 		<= not(SW(3));
	AMP(0) 	<= not(SW(2));
	AMP(1) 	<= '0';
	
	-- signal sorce selection
	SEL_ANALOG 	<= not(SW(5));
	SEL_EXT 	<= not(SW(1));
	
	-- turn on LED when ext input activated
	D(1) <= SW(1);

-- Future use
	OE <= '0';

end Behavioral;
