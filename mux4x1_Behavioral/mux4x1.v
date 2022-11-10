
/********************************************************************

Module          :   mux4x1

Date            :   09 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 09 November, 2022 - Initial implementation

Summary         :   Behavioral implementation of Mux4x1

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

always @  (i0, i1, i2, i3, sel) begin

    case (sel)
        2'b00   : out <= i0;   //if sel=0, out = i0
        2'b01   : out <= i1;   //if sel=1, out = i1
        2'b10   : out <= i2;   //if sel=2, out = i2
        2'b11   : out <= i3;   //if sel=3, out = i3
        default : out <= 1'b0;
    endcase

end
endmodule
