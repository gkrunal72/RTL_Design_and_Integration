#Simulation
vlog memory_tb.v

#Elaboration
vsim memory_tb +start_addr=10 +num_writes=6

#Add signals to the waveform
add wave sim:/memory_tb/m1/*

#add memory register to the waveform
add wave -position insertpoint \ /memory_tb/m1/mem 

run -all

