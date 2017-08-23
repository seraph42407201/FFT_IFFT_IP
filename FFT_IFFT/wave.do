onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/iclk
add wave -noupdate -format Logic /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/ien
add wave -noupdate -format Literal -radix unsigned /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/iaddr
add wave -noupdate -format Literal -radix decimal /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/iReal
add wave -noupdate -format Literal -radix decimal /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/iImag
add wave -noupdate -format Logic /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/oen
add wave -noupdate -format Literal -radix unsigned /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/oaddr
add wave -noupdate -format Literal -radix decimal /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/oReal
add wave -noupdate -format Literal -radix decimal /fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/oImag
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/oen}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/oaddr}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/odata}
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/ien}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/iaddr}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/idata}
add wave -noupdate -format Logic {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/oen}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/oaddr}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/odata}
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/twiddle_ore}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/twiddle_oim}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/mul_ore}
add wave -noupdate -format Literal -radix decimal {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/mul_oim}
add wave -noupdate -format Logic {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/k1}
add wave -noupdate -format Logic {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/k2}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/n3}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/addr1}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/addr2}
add wave -noupdate -format Literal -radix unsigned {/fft_ifft_sim/fft_ifft_ins/genblk1/fft_ins/stagX[6]/fft_stageX_inst/ftrans_II_inst/ROM_addr}
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
WaveRestoreZoom {0 ps} {8400 ns}
