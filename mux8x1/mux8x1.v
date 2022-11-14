
/********************************************************************

Module          :   mux8x1

Date            :   10 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 10 November, 2022 - Initial implementation

Summary         :   Implementation of Mux8x1 using mux4x1 only.
                    Instantiating mux4x1 to impletement mumx8x1.

Inputs          :   i0, i1, i2, i3, i4, i5, i6, i7, sel

Outputs         :   Out

Instantiation   :   mux4x1

********************************************************************/

`include "mux4x1.v"

module mux8x1 (
    input   wire        i0,
    input   wire        i1,
    input   wire        i2,
    input   wire        i3,
    input   wire        i4,
    input   wire        i5,
    input   wire        i6,
    input   wire        i7,
    input   wire [2:0]  sel,
    output  wire        out
);

wire    m1;
wire    m2;

mux4x1 mux1 (i0,
             i1,
             i2,
             i3,
             {sel[1],sel[0]},
             m1
         );

mux4x1 mux2 (i4,
             i5,
             i6,
             i7,
             {sel[1],sel[0]},
             m2
         );

         
mux4x1 mux3 (m1,
             m2,
             1'b0,
             1'b0,
             {1'b0, sel[2]},
             out
         );

endmodule
