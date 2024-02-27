	//Packed structure 
	
//st_ctrl
typedef struct packed {
	bit [3:0] mode;
	bit [2:0] cfg;
	bit		  en;
} st_ctrl;

module tb;
	st_ctrl ctrl_reg;
	
	initial begin
		//initialized packed array
		ctrl_reg = '{4'ha, 3'h5, 1};
		$display("ctrl_reg = %p", ctrl_reg);
		
		//Change packed array member
		ctrl_reg.mode = 4'hf;
		$display("ctrl_reg = %p", ctrl_reg);
		
		//Assign packed array value to structure variable
		ctrl_reg = 8'haa;
		$display("ctrl_reg = %p", ctrl_reg);
	end
endmodule
