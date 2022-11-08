module ha (
    input   reg   a,   //Input a
    input   reg   b,   //Input b
    output  wire  s,   //Output Sum
    output  wire  c   //Output Carry
    );

xor g1 (s, a, b);
and g2 (c, a, b);

endmodule
