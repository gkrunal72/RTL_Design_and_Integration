vlog fa_tb.v

vsim fa_tb

#add wave sim:/fa_tb/dut/*
do wave.do

run -all
