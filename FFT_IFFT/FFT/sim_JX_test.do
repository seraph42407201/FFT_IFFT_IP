onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -height 27 /fft_sim/fft_ins/iclk
add wave -noupdate -format Logic -height 27 /fft_sim/fft_ins/rst_n
add wave -noupdate -format Logic -height 27 /fft_sim/fft_ins/ien
add wave -noupdate -format Literal -height 27 -radix unsigned /fft_sim/fft_ins/iaddr
add wave -noupdate -format Literal -height 27 -radix decimal /fft_sim/fft_ins/iReal
add wave -noupdate -format Literal -height 27 -radix decimal /fft_sim/fft_ins/iImag
add wave -noupdate -format Logic -height 27 /fft_sim/fft_ins/oen
add wave -noupdate -format Literal -height 27 -radix unsigned /fft_sim/fft_ins/oaddr
add wave -noupdate -format Literal -height 27 -radix decimal /fft_sim/fft_ins/oReal
add wave -noupdate -format Literal -height 27 -radix decimal /fft_sim/fft_ins/oImag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 86
configure wave -valuecolwidth 43
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
WaveRestoreZoom {2550510 ps} {3369329 ps}
