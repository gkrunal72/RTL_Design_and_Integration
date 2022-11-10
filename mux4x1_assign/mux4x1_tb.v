/********************************************************************

Module          :   mux4x1_tb

Date            :   10 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 10 November, 2022 - Initial implementation

Summary         :   Test bench for mux4x1.v implemented using assign statements

Inputs          :   i0_tb, i1_tb, i2_tb, i3_tb, sel_tb

Outputs         :   Out_tb

Instantiation   :   mux4x1

********************************************************************/

`include "mux4x1.v"

module mux4x1_tb;

//Outputs
reg         i0_tb;
reg         i1_tb;
reg         i2_tb;
reg         i3_tb;
reg  [1:0]  sel_tb;

//Input
wire        out_tb;

//Instantiation
mux4x1 dut (.i0(i0_tb),
            .i1(i1_tb),
            .i2(i2_tb),
            .i3(i3_tb),
            .sel(sel_tb),
            .out(out_tb));


initial begin
    repeat (20) begin
        i0_tb = $random;
        i1_tb = $random;
        i2_tb = $random;
        i3_tb = $random;
        sel_tb = $random;
        #1;
    end
end

initial begin
    $dumpfile("mux4x1.vcd");
    $dumpvars(0,mux4x1_tb);
end


initial begin
    $monitor("Time = %0t, I0 = %b, I1 = %b, I2 = %b, I3 = %b, SEL = %d, Out = %b", $time, i0_tb, i1_tb, i2_tb, i3_tb, sel_tb, out_tb);
end

endmodule

