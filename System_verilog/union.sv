	//Packed Union
typedef union packed {
	bit [7:0] wordView;
	
	struct packed {
		bit [3:0] mode;
		bit [2:0] cfg;
		bit		  en;
	} floatView;
}MyUnion;

module tb;

	MyUnion myData;
	
	initial begin
		myData.wordView = 8'hff;
		
		$display("myData.wordView = %0h", myData.wordView);
		$display("myData.floatView.mode = %0h", myData.floatView.mode);
		$display("myData.floatView.cfg = %0h", myData.floatView.cfg);
		$display("myData.floatView.en = %0h", myData.floatView.en);
		$display("myData.floatView = %0h", myData.floatView);
	end

endmodule