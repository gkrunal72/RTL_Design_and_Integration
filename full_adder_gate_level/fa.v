module fa (
    input   reg   a,    //Input a
    input   reg   b,    //Input b
    input   reg   cin,  //Input Carry
    output  wire  sum,  //Output Sum
    output  wire  cout  //Output Carry
    );
    
wire x1;    //output of xor1 gate connected to input of xor2 gate
wire a1;    //output of and1 gate connected to input of or1 gate
wire a2;    //output of and2 gate connected to input of or1 gate
wire a3;    //output of and3 gate connected to input of or1 gate


//Gate level Implementation for Sum output
xor xor1 (x1, a, b);
xor xor2 (sum, x1, cin);

//Gate level implementation for cout output
and and1 (a1,a,b);
and and2 (a2,a,cin);
and and3 (a3,b,cin);
or  or1  (cout, a1, a2, a3);

endmodule
