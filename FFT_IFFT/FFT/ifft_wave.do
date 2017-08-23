onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /ifft_sim/ifft_ins/iclk
add wave -noupdate -format Logic /ifft_sim/ifft_ins/rst_n
add wave -noupdate -format Logic /ifft_sim/ifft_ins/ien
add wave -noupdate -format Literal -radix unsigned /ifft_sim/ifft_ins/iaddr
add wave -noupdate -format Literal -radix decimal /ifft_sim/ifft_ins/iReal
add wave -noupdate -format Literal -radix decimal /ifft_sim/ifft_ins/iImag
add wave -noupdate -format Logic /ifft_sim/ifft_ins/oen
add wave -noupdate -format Literal -radix unsigned /ifft_sim/ifft_ins/oaddr
add wave -noupdate -format Literal -radix decimal /ifft_sim/ifft_ins/oReal
add wave -noupdate -format Literal -radix decimal /ifft_sim/ifft_ins/oImag
add wave -noupdate -format Logic /ifft_sim/ifft_ins/en_end
add wave -noupdate -format Literal /ifft_sim/ifft_ins/addr_end
add wave -noupdate -format Literal /ifft_sim/ifft_ins/data_end
add wave -noupdate -format Literal /ifft_sim/ifft_ins/en_w
add wave -noupdate -format Literal /ifft_sim/ifft_ins/addr_w
add wave -noupdate -format Literal /ifft_sim/ifft_ins/data_w
add wave -noupdate -format Literal /ifft_sim/ifft_ins/ConjugIData
add wave -noupdate -format Logic /ifft_sim/ifft_ins/en_e
add wave -noupdate -format Literal /ifft_sim/ifft_ins/addr_e
add wave -noupdate -format Literal /ifft_sim/ifft_ins/data_e
add wave -noupdate -format Literal /ifft_sim/ifft_ins/data_f
add wave -noupdate -format Literal /ifft_sim/ifft_ins/data_g
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {12154545 ps}
