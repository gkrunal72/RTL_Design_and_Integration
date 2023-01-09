vlog clock.v
vsim clock +freq=100 +duty=50 +jitter=10
add wave sim:/clock/*
run -all

