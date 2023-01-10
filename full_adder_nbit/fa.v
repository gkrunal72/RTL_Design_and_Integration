module fa (
    input   reg   a,    //Input a
    input   reg   b,    //Input b
    input   reg   cin,  //Input Carry
    output  wire  sum,  //Output Sum
    output  wire  cout  //Output Carry
    );
    
assign {cout, sum} = a + b + cin;

endmodule
