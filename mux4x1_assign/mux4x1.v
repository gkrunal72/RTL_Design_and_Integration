
/********************************************************************

Module          :   mux4x1

Date            :   10 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 10 November, 2022 - Initial implementation

Summary         :   Implementation of Mux4x1 using assign statements.
                    core logic is of mux4x1 using mux2x1.

Inputs          :   i0, i1, i2, i3, sel

Outputs         :   Out

Instantiation   :   N/A

********************************************************************/

module mux4x1 (
    input   wire        i0,
    input   wire        i1,
    input   wire        i2,
    input   wire        i3,
    input   wire  [1:0] sel,
    output  reg         out
    );

wire    m1;
wire    m2;

assign m1 = sel[0] ? i1 : i0;
assign m2 = sel[0] ? i3 : i2;
assign out = sel[1] ? m2 : m1;

endmodule
