onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /phantom_driver_tb/DUT/DDS_INIT/nRES
add wave -noupdate /phantom_driver_tb/DUT/DDS_INIT/MCLK
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/PSEL
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/FSEL
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/RESET
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/SDATA
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/SCLK
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/FSYNC
add wave -noupdate -group DDS_INIT_internal -divider DetailOfSequencer
add wave -noupdate -group DDS_INIT_internal -radix unsigned -childformat {{/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(9) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(8) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(7) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(6) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(5) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(4) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(3) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(2) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(1) -radix unsigned} {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(0) -radix unsigned}} -subitemconfig {/phantom_driver_tb/DUT/DDS_INIT/Q_DIV(9) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(8) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(7) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(6) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(5) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(4) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(3) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(2) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(1) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV(0) {-height 15 -radix unsigned}} /phantom_driver_tb/DUT/DDS_INIT/Q_DIV
add wave -noupdate -group DDS_INIT_internal /phantom_driver_tb/DUT/DDS_INIT/SEQUENCE_COUNTER/CLK
add wave -noupdate -group DDS_INIT_internal -radix unsigned /phantom_driver_tb/DUT/DDS_INIT/Q_SEQ
add wave -noupdate -group DDS_INIT_internal -radix unsigned /phantom_driver_tb/DUT/DDS_INIT/ADD_COUNT
add wave -noupdate -group DDS_INIT_internal -radix hexadecimal /phantom_driver_tb/DUT/DDS_INIT/S_REG
add wave -noupdate -group DDS_INIT /phantom_driver_tb/tb_MCLK
add wave -noupdate -group DDS_INIT /phantom_driver_tb/tb_SCLK
add wave -noupdate -group DDS_INIT /phantom_driver_tb/tb_SDATA
add wave -noupdate -group DDS_INIT /phantom_driver_tb/tb_FSYNC
add wave -noupdate -divider SEQUENCER
add wave -noupdate /phantom_driver_tb/tb_CLK
add wave -noupdate /phantom_driver_tb/DUT/SEQUENCER/CLK
add wave -noupdate -group Internal -radix unsigned /phantom_driver_tb/DUT/SEQUENCER/Q_BURST
add wave -noupdate -group Internal /phantom_driver_tb/DUT/SEQUENCER/BURST_INH
add wave -noupdate -group Internal /phantom_driver_tb/DUT/SEQUENCER/BURST_SYNC
add wave -noupdate -group Internal /phantom_driver_tb/DUT/SEQUENCER/ECD_CLK
add wave -noupdate -group Internal -radix unsigned /phantom_driver_tb/DUT/SEQUENCER/Q_ECD
add wave -noupdate -group Internal /phantom_driver_tb/DUT/SEQUENCER/ECD_INH
add wave -noupdate /phantom_driver_tb/DUT/SEQUENCER/SYNC
add wave -noupdate /phantom_driver_tb/DUT/SEQUENCER/INH
add wave -noupdate -radix unsigned /phantom_driver_tb/DUT/SEQUENCER/ECD
add wave -noupdate -divider PATCH
add wave -noupdate -radix unsigned /phantom_driver_tb/DUT/OUTPUT_PATCH/ADDR
add wave -noupdate -radix unsigned /phantom_driver_tb/DUT/OUTPUT_PATCH/Q
add wave -noupdate -divider DECORDER
add wave -noupdate /phantom_driver_tb/DUT/dec_INH
add wave -noupdate -radix unsigned -childformat {{/phantom_driver_tb/DUT/CH(2) -radix unsigned} {/phantom_driver_tb/DUT/CH(1) -radix unsigned} {/phantom_driver_tb/DUT/CH(0) -radix unsigned}} -subitemconfig {/phantom_driver_tb/DUT/CH(2) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CH(1) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CH(0) {-height 15 -radix unsigned}} /phantom_driver_tb/DUT/CH
add wave -noupdate -radix unsigned -childformat {{/phantom_driver_tb/DUT/CS(6) -radix unsigned} {/phantom_driver_tb/DUT/CS(5) -radix unsigned} {/phantom_driver_tb/DUT/CS(4) -radix unsigned} {/phantom_driver_tb/DUT/CS(3) -radix unsigned} {/phantom_driver_tb/DUT/CS(2) -radix unsigned} {/phantom_driver_tb/DUT/CS(1) -radix unsigned} {/phantom_driver_tb/DUT/CS(0) -radix unsigned}} -subitemconfig {/phantom_driver_tb/DUT/CS(6) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(5) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(4) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(3) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(2) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(1) {-height 15 -radix unsigned} /phantom_driver_tb/DUT/CS(0) {-height 15 -radix unsigned}} /phantom_driver_tb/DUT/CS
add wave -noupdate -divider DUT_OUT
add wave -noupdate /phantom_driver_tb/tb_FSYNC
add wave -noupdate /phantom_driver_tb/tb_SDATA
add wave -noupdate /phantom_driver_tb/tb_SCLK
add wave -noupdate /phantom_driver_tb/tb_SYNC
add wave -noupdate -radix unsigned /phantom_driver_tb/tb_CH
add wave -noupdate -radix unsigned /phantom_driver_tb/tb_CS
add wave -noupdate -radix unsigned /phantom_driver_tb/tb_AMP
add wave -noupdate /phantom_driver_tb/tb_ZOUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {728438 ps} 0} {{Cursor 5} {14551604 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 364
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {21052500 ps}
