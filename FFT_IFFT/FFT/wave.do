onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fft_sim/iclk
add wave -noupdate -format Logic /fft_sim/rst_n
add wave -noupdate -format Literal -radix unsigned /fft_sim/iaddr
add wave -noupdate -format Literal -radix decimal /fft_sim/idata
add wave -noupdate -format Logic /fft_sim/ien
add wave -noupdate -format Literal -radix decimal /fft_sim/odata
add wave -noupdate -format Literal -radix unsigned /fft_sim/oaddr
add wave -noupdate -format Logic /fft_sim/oen
add wave -noupdate -format Literal -radix unsigned /fft_sim/index
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/stg7/oaddr
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/odata
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/oen
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/is_load
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/is_calc
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/with_dump
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/dump
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/stg7/dump_cnt
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/wdata_in
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/waddr_in
add wave -noupdate -format Logic /fft_sim/fft_ins/stg7/wen_in
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/rdata
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/rdata_out
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/stg7/raddr_in
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/bf_ia
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/bf_ib
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/bf_oa
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/stg7/bf_ob
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {11869790 ps}
