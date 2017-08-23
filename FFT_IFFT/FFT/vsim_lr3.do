onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fft_sim/fft_ins/iclk
add wave -noupdate -format Logic /fft_sim/fft_ins/rst_n
add wave -noupdate -format Logic /fft_sim/fft_ins/ien
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/iaddr
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/iReal
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/iImag
add wave -noupdate -format Logic /fft_sim/fft_ins/oen
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/oaddr
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/oReal
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/oImag
add wave -noupdate -format Logic /fft_sim/fft_ins/en_end
add wave -noupdate -format Literal /fft_sim/fft_ins/addr_end
add wave -noupdate -format Literal /fft_sim/fft_ins/data_end
add wave -noupdate -format Literal /fft_sim/fft_ins/en_w
add wave -noupdate -format Literal /fft_sim/fft_ins/addr_w
add wave -noupdate -format Literal /fft_sim/fft_ins/data_w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 67
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
WaveRestoreZoom {0 ps} {8400 ns}
