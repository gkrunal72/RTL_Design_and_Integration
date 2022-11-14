/********************************************************************

Module          :   mux8x1_tb

Date            :   10 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 10 November, 2022 - Initial implementation

Summary         :   Test bench for mux8x1.v implemented using mux4x1 only

Inputs          :   i0_tb, i1_tb, i2_tb, i3_tb, i4_tb, i5_tb, i6_tb, i7_tb, sel_tb

Outputs         :   Out_tb

Instantiation   :   mux8x1

********************************************************************/

`include "mux8x1.v"
`include "mux4x1.v"

module mux8x1_tb;

reg         i0_tb;
reg         i1_tb;
reg         i2_tb;
reg         i3_tb;
reg         i4_tb;
reg         i5_tb;
reg         i6_tb;
reg         i7_tb;
reg  [2:0]  sel_tb;

wire        out_tb;

mux8x1 dut (.i0(i0_tb),
            .i1(i1_tb),
            .i2(i2_tb),
            .i3(i3_tb), 
            .i4(i4_tb), 
            .i5(i5_tb),
            .i6(i6_tb),
            .i7(i7_tb),
            .sel(sel_tb),
            .out(out_tb)
            );


initial begin

    repeat (10) begin
        i0_tb=$random;
        i1_tb=$random;
        i2_tb=$random;
        i3_tb=$random;
        i4_tb=$random;
        i5_tb=$random;
        i6_tb=$random;
        i7_tb=$random;
        sel_tb=$random;
        #1;
    end
end

initial begin
    $dumpfile("mux8x1.vcd");
    $dumpvars(0,mux8x1_tb);
end

initial begin
    $monitor("Time = %0t, I0 = %b, I1 = %b, I2 = %b, I3 = %b, I4 = %b, I5 = %b, I6 = %b, I7 = %b, SEL = %d, Out = %b", $time, i0_tb, i1_tb, i2_tb, i3_tb, i4_tb, i5_tb, i6_tb, i7_tb, sel_tb, out_tb);
end

endmodule
