vlog encode_decode_tb.v

vsim encode_decode_tb

add wave sim:/encode_decode_tb/en1/*

add wave sim:/encode_decode_tb/de1/*

run -all
