onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fft_sim/iclk
add wave -noupdate -format Logic /fft_sim/ien
add wave -noupdate -format Literal -radix unsigned /fft_sim/iaddr
add wave -noupdate -format Literal -radix hexadecimal /fft_sim/fft_ins/iReal
add wave -noupdate -format Literal -radix hexadecimal /fft_sim/fft_ins/iImag
add wave -noupdate -format Logic /fft_sim/oen
add wave -noupdate -format Literal -radix unsigned /fft_sim/oaddr
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/oReal
add wave -noupdate -format Literal -radix decimal /fft_sim/fft_ins/oImag
add wave -noupdate -divider 7
add wave -noupdate -format Logic {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/ien}
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/iaddr}
add wave -noupdate -format Literal -radix decimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/idata}
add wave -noupdate -format Logic {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/oen}
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/oaddr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/odata}
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/ROM_addr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/twiddle_ore}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/twiddle_oim}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/mul_ore}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/mul_oim}
add wave -noupdate -format Literal {/fft_sim/fft_ins/stagX[7]/stgX_inst/ftrans_II_inst/oen_d}
add wave -noupdate -divider 5
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[5]/stgX_inst/ftrans_II_inst/iaddr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[5]/stgX_inst/ftrans_II_inst/idata}
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[5]/stgX_inst/ftrans_II_inst/oaddr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[5]/stgX_inst/ftrans_II_inst/odata}
add wave -noupdate -divider 3
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[3]/stgX_inst/ftrans_II_inst/iaddr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[3]/stgX_inst/ftrans_II_inst/idata}
add wave -noupdate -format Literal -radix unsigned {/fft_sim/fft_ins/stagX[3]/stgX_inst/ftrans_II_inst/oaddr}
add wave -noupdate -format Literal -radix hexadecimal {/fft_sim/fft_ins/stagX[3]/stgX_inst/ftrans_II_inst/odata}
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /fft_sim/fft_ins/genblk2/stg1_inst/oaddr
add wave -noupdate -format Literal -radix hexadecimal /fft_sim/fft_ins/genblk2/stg1_inst/odata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 139
configure wave -valuecolwidth 89
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
WaveRestoreZoom {3229110 ps} {3473630 ps}
