vlog sync_fifo_tb.v

vsim sync_fifo_tb +test_case=FULL

add wave sim:/sync_fifo_tb/f1/*

run -all
