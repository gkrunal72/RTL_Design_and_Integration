`include "mux2x1.v"

module mux2x1_tb;

reg i0_tb, i1_tb, sel_tb;
wire y_tb;

mux2x1 m1 ( .i0(i0_tb), 
            .i1(i1_tb), 
            .sel(sel_tb), 
            .y(y_tb));

initial begin

//	$dumpfile("dump.vcd");
//  $dumpvars(0,testbench);
    
    #1
    i0_tb = 0;
    i1_tb = 0;
    sel_tb = 0;
    
    #1
    i0_tb = 0;
    i1_tb = 1;
    sel_tb = 1;
    
    #1
    i0_tb = 1;
    i1_tb = 0;
    sel_tb = 0;

    #1
    i0_tb = 1;
    i1_tb = 1;
    sel_tb = 1;
end

endmodule
