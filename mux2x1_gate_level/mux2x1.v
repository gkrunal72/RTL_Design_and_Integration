module mux2x1 (i0, i1, sel, y);

input i0, i1, sel;
output y;

wire isel, o1, o2;

not g1 (isel,sel);
and g2 (o1, isel, i0);
and g3 (o2, sel, i1);
or g4 (y, o1, o2);

endmodule

