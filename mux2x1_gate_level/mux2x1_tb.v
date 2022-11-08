`include "mux2x1.v"         //Include DUT file to instantiate the modules

module mux2x1_tb;

reg i0_tb, i1_tb, sel_tb;   //Inputs to the DUT (Mux2x1.v)
wire y_tb;                  //Output of DUT

//Instantiation of module - Connection by name
mux2x1 m1 ( .i0(i0_tb), 
            .i1(i1_tb), 
            .sel(sel_tb), 
            .y(y_tb));

initial begin

//Execute the instructions "n" (e.g. 10) number of times
repeat (10) begin

    i0_tb = $random;        //$random - To assign random values
    i1_tb = $random;        //In our case 0 or 1 as our variable are of 1 bit
    sel_tb = $random;
    #1;
end    

end

initial begin
    //Print the value of variables continuously whenever value of variable changes
    $monitor("time - %0t, i0=%b, i1=%b, sel=%b, y=%b", $time, i0_tb, i1_tb, sel_tb, y_tb);
end

initial begin
    
    $dumpfile("mux.vcd"); //Value change dump file
    $dumpvars(0,mux2x1_tb);
end

endmodule
