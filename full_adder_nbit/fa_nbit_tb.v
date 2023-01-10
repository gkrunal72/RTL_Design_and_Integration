`include "full_adder_nbit.v"


module fa_nbit_tb;

parameter BIT = 4;

    reg     [BIT-1:0]   a_i;
    reg     [BIT-1:0]   b_i;
    reg                 cin_i;
    wire    [BIT-1:0]   sum_o;
    wire                cout_o;




fa_nbit #(.BIT(BIT)) fa (
                        .a_i(a_i),
                        .b_i(b_i),
                        .cin_i(cin_i),
                        .sum_o(sum_o),
                        .cout_o(cout_o)
                    );

initial begin

    repeat (10) begin
        a_i = $random;
        b_i = $random;
        cin_i = $urandom_range(0,1);
        #5;
    end
    $finish;
end

initial
    $monitor("a_i=%0h\t, b_i=%0h\t, cin_i=%0h\t, sum_o=%0h\t, cout_o=%0h", a_i, b_i, cin_i, sum_o, cout_o);
endmodule


