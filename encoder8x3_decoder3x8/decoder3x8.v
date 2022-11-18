
/********************************************************************

Module          :   decoder8x3

Date            :   15 November, 2022

Author          :   Krunal Gandhi

Email           :   gkrunal72@gmail.com

History         :   1. 15 November, 2022 - Initial implementation

Summary         :   Implementation decoder8x3.

Inputs          :   i0_de, i1_de, i2_de

Outputs         :   o0_de, o1_de, o2_de, o3_de, o4_de, o5_de, o6_de, o7_de

Instantiation   :   N/A

********************************************************************/

module  decoder3x8 (
    output   wire        o0_de,
    output   wire        o1_de,
    output   wire        o2_de,
    output   wire        o3_de,
    output   wire        o4_de,
    output   wire        o5_de,
    output   wire        o6_de,
    output   wire        o7_de,
    input    wire       i0_de,
    input    wire       i1_de,
    input    wire       i2_de
);

and a1 (o0_de, ~i0_de, ~i1_de, ~i2_de);
and a2 (o1_de, i0_de, ~i1_de, ~i2_de);
and a3 (o2_de, ~i0_de, i1_de, ~i2_de);
and a4 (o3_de, i0_de, i1_de, ~i2_de);
and a5 (o4_de, ~i0_de, ~i1_de, i2_de);
and a6 (o5_de, i0_de, ~i1_de, i2_de);
and a7 (o6_de, ~i0_de, i1_de, i2_de);
and a8 (o7_de, i0_de, i1_de, i2_de);

endmodule
