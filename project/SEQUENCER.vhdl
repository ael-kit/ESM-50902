-- Sequencer for "Phantom Driver"
-- 　ファントムドライバ用のシーケンサ
--　　必要な数のECDを順次指定し、必要な信号出力抑制信号、スキャン同期信号を生成する
--
-- input:
-- 	CLK:	ECD用の正弦波をコンパレートして得られたクロック（低周波）
-- 	nRES:	リセット信号（負論理）
--
-- output:
-- 	SYNC:	同期信号（指定したECD数をスキャンし終わった時に出力される）
-- 	INH:	ECD信号抑制出力（バースト波のSPACE部分、スキャン後のスペース部分を指示する
-- 			MUXのインヒビットに入力することで出力を切る）
-- 	ECD:	ECDの番号（出力パッチ回路の入力となる）
--
-- 	2020/4/23 Rev 0.5 Miyamoto
-- 		コンパイラテスト、シミュレーションテスト完了
--
-- 	2020/5/4 REV 0.7 Miyamoto
--		ライブラリを変更 numeric_std
-- 	2020/5/7 REV 0.8 Miyamoto
--		SYNCパルス幅指定を変更(ISSUE#1　対応)
-- 	2020/9/9 REV 1.0 Miyamoto
-- 		ECD数とバースト波の設定をパラメタ化
--		カウンタの桁数を計算で求めるようにした 



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity SEQUENCER is
	generic ( 
		ECD_NUMBER:		integer :=50;
		ECD_Q_WIDTH:	integer	:=6;
		-- ECDの数 (デフォルト値)

		BURST_MARK : 	integer := 2;
		BURST_SPACE:	integer := 1
		-- Burst波の構成（デフォルト値）
		-- BURST_MARK: ECDバースト波の信号波数
		-- BURST_SPACE: ECDバースト波のスペースの波数
		-- 		この２つを足したものが1ECDドライブのバースト波全体長さ（波数）になる
		--      実際のバースト波は、スペースが先で、その後マークとなる。（ECDの切替を見えなくするため）
	);
		
	port(
		-- inputs
		nRES	: in std_logic;
		CLK		: in std_logic;
		
		-- outputs
		SYNC, INH	: out std_logic;
		ECD			: out unsigned(ECD_Q_WIDTH-1 downto 0)
	);

end SEQUENCER;
			
			
architecture Behavioral of SEQUENCER is
				
	-- SYNC_PULSE_WIDTH: 同期パルスの幅（クロック数）　
	constant SYNC_PULSE_WIDTH: integer := 1;
					
	constant BURST_Q_WIDTH: integer := integer(Ceil(log(real(BURST_MARK+BURST_SPACE-1),2.0)));

	--  internal signal
	signal 	Q_BURST:		unsigned(BURST_Q_WIDTH-1 downto 0);		--  burst wave counter
	signal 	Q_ECD:			unsigned(ECD_Q_WIDTH-1 downto 0);

	signal	BURST_SYNC:		std_logic:='0';	-- Sync signal (internal)
	signal	ECD_SYNC:		std_logic:='0';

	signal	BURST_INH:		std_logic:='0';
	signal	ECD_INH:		std_logic:='0';

	signal	ECD_CLK:		std_logic;

begin

	BURST_COUNTER: entity work.COUNTER_INC
		generic map (WIDTH => BURST_Q_WIDTH, COUNT => (BURST_MARK + BURST_SPACE - 1) )
		port map    (EN => nRES , CLK => CLK, Q => Q_BURST);

	ECD_COUNTER: entity work.COUNTER_INC
		generic map (WIDTH => ECD_Q_WIDTH, COUNT => (ECD_NUMBER) )
		port map    (EN => nRES , CLK => ECD_CLK, Q => Q_ECD);

	-- assart BURST_SYNC when Q_BURST count more than SYNC_PULSE_START : determine the pulse width of SYNC
	process (Q_BURST) begin
		if ( Q_BURST >= (BURST_MARK + BURST_SPACE - SYNC_PULSE_WIDTH) ) then
			BURST_SYNC	<= '1';
		else
			BURST_SYNC	<= '0';
		end if;

		if Q_BURST = 0 then
			ECD_CLK	<='1';
		else
			ECD_CLK	<='0';
		end if;

		if ( Q_BURST <= BURST_SPACE-1 ) then
			BURST_INH	<= '1';
		else
			BURST_INH	<= '0';
		end if;

	end process;

	process (Q_ECD) begin
		-- SYNCをバースト波の直前に設定するために変更
		-- if ( Q_ECD = ECD_NUMBER ) then
		if ( Q_ECD = 0 ) then
			ECD_SYNC <= '1';
		else
			ECD_SYNC <= '0';
		end if;

		if ( Q_ECD = ECD_NUMBER ) then
			ECD_INH	<= '1';
		else
			ECD_INH <= '0';
		end if;

	end process;

	INH 	<= BURST_INH or ECD_INH;
	-- SYNCをバースト波の直前に設定するために変更
	-- SYNC 	<= BURST_SYNC and ECD_SYNC;
	SYNC 	<= ECD_CLK and ECD_SYNC;　-- ECD_COUNT=0 && BURST_COUNT=0
	ECD 	<= Q_ECD;

end Behavioral;
