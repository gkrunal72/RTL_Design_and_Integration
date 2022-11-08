#compilation
vlog mux2x1_tb.v 

#Elaboration
vsim mux2x1_tb   

#add signals to the waveform
#add wave sim:/mux2x1_tb/m1/*
do wave.do

#simulation
run -all

