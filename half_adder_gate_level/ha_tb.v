`include "ha.v"

module ha_tb;

reg     a_tb;   //Input a
reg     b_tb;   //Input b
wire    s_tb;   //output Sum
wire    c_tb;   //Output Carry

//Instantiation of DUT
ha dut (.a(a_tb),
        .b(b_tb),
        .s(s_tb),
        .c(c_tb));

initial begin
repeat (10) begin
    a_tb = $random;
    b_tb = $random;
    #1;
end
end

initial begin
    $dumpfile("ha.vcd");
    $dumvars(0,ha_tb);
end

initial begin
    $monitor ("Time - %0t, a = %b, b = %b, Sum = %b, Carry = %b", $time, a_tb, b_tb, s_tb, c_tb);
end

endmodule
