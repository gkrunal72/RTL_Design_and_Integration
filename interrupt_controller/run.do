vlog interrupt_controller_tb.v

vsim interrupt_controller_tb +testcase=RANDOM_PRIO

add wave sim:/interrupt_controller_tb/ic1/*

run -all
