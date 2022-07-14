onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 Inputs
add wave -noupdate -height 25 -label Clock /testbench/SYS/CPU/clk
add wave -noupdate -height 25 -label Reset /testbench/SYS/CPU/rst
add wave -noupdate -divider -height 30 Data
add wave -noupdate -height 25 -label Data /testbench/SYS/CPU/data
add wave -noupdate -divider -height 30 Process
add wave -noupdate -height 25 -label {CPU Address} -radix unsigned /testbench/SYS/CPU/address
add wave -noupdate -height 25 -label {Signal Address} -radix unsigned /testbench/SYS/CPU/addreg
add wave -noupdate -height 25 -label {Program Counter} -radix unsigned /testbench/SYS/CPU/pc
add wave -noupdate -height 25 -label State /testbench/SYS/CPU/state
add wave -noupdate -height 20 -label {Stage Count} -radix unsigned /testbench/SYS/CPU/st_cnt
add wave -noupdate -divider -height 30 Registers
add wave -noupdate -height 25 -label {R0 (Accumulator)} -radix unsigned -childformat {{/testbench/SYS/CPU/line__41/r(0)(16) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(15) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(14) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(13) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(12) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(11) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(10) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(9) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(8) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(7) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(6) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(5) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(4) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(3) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(2) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(1) -radix unsigned} {/testbench/SYS/CPU/line__41/r(0)(0) -radix unsigned}} -subitemconfig {/testbench/SYS/CPU/line__41/r(0)(16) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(15) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(14) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(13) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(12) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(11) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(10) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(9) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(8) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(7) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(6) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(5) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(4) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(3) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(2) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(1) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(0)(0) {-height 15 -radix unsigned}} /testbench/SYS/CPU/line__41/r(0)
add wave -noupdate -height 25 -label R1 -radix unsigned -childformat {{/testbench/SYS/CPU/line__41/r(1)(16) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(15) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(14) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(13) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(12) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(11) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(10) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(9) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(8) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(7) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(6) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(5) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(4) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(3) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(2) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(1) -radix unsigned} {/testbench/SYS/CPU/line__41/r(1)(0) -radix unsigned}} -subitemconfig {/testbench/SYS/CPU/line__41/r(1)(16) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(15) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(14) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(13) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(12) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(11) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(10) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(9) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(8) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(7) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(6) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(5) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(4) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(3) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(2) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(1) {-height 15 -radix unsigned} /testbench/SYS/CPU/line__41/r(1)(0) {-height 15 -radix unsigned}} /testbench/SYS/CPU/line__41/r(1)
add wave -noupdate -height 25 -label R2 -radix unsigned /testbench/SYS/CPU/line__41/r(2)
add wave -noupdate -height 25 -label R3 -radix unsigned /testbench/SYS/CPU/line__41/r(3)
add wave -noupdate -height 25 -label R4 -radix unsigned /testbench/SYS/CPU/line__41/r(4)
add wave -noupdate -divider -height 30 {Register Index}
add wave -noupdate -height 25 -label {Index 1} -radix unsigned /testbench/SYS/CPU/line__41/i
add wave -noupdate -height 25 -label {Index 2} -radix unsigned /testbench/SYS/CPU/line__41/j
add wave -noupdate -divider -height 30 {Zero Flag}
add wave -noupdate -height 25 -label Zero /testbench/SYS/CPU/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9401818 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3660866 ps} {4470308 ps}
