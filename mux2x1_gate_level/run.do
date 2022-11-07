vlog mux2x1_tb.v 

vsim mux2x1_tb   

#add wave sim:/mux2x1_tb/m1/*
do wave.do

run -all

