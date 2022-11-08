`include "fa.v"     //include full added verilog file

module fa_tb;

    reg   a_tb;     //Input a
    reg   b_tb;     //Input b
    reg   cin_tb;   //Input Carry
    wire  sum_tb;   //Output Sum
    wire  cout_tb;  //Output Carry

//Instantiation of Full adder module
fa dut (.a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_tb),
        .cout(cout_tb));


initial begin

    repeat (10) begin
        a_tb   = $random;
        b_tb   = $random;   
        cin_tb = $random;
        #1;
    end

end


initial begin
    $dumpfile("fa.vcd");
    $dumpvars(0,fa_tb);
end

initial begin
    $monitor("Time - %0t, a = %b, b = %b, cin = %b, sum = %b, cout = %b", $time, a_tb, b_tb, cin_tb, sum_tb, cout_tb);
end

endmodule

