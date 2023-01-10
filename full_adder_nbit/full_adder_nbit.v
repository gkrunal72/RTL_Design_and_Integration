`include "fa.v"

module fa_nbit 
    #(
        //Define parameters
        parameter BIT= 4)
    
    (
        //define inputs/outputs
        input   wire    [BIT-1:0]   a_i,
        input   wire    [BIT-1:0]   b_i,
        input   wire                cin_i,
        output  wire    [BIT-1:0]   sum_o,
        output  wire                cout_o);


//instantiation of 1 bit fa module
genvar i;
wire [BIT:0] cin_vec;

assign cin_vec[0] = cin_i;
assign cout_o = cin_vec[BIT];

for(i=0; i<BIT; i=i+1) begin

    fa u1 ( .a(a_i[i]), 
            .b(b_i[i]),
            .cin(cin_vec[i]),
            .sum(sum_o[i]),
            .cout(cin_vec[i+1])
        );

end


endmodule

