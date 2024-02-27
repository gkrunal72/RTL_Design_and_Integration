	//Interface
interface cnt_if 
	#(	parameter WIDTH = 4	)
	(	input clk	);
	
		logic rstn;
		logic load_en;
		logic [WIDTH-1:0] load;
		logic [WIDTH-1:0] count;
		logic down;
		logic rollover;
endinterface

module counter_ud
	#(
		parameter WIDTH = 4
	)
	(	cnt_if _if );
	
	always @ (posedge _if.clk or negedge _if.rstn) begin
		if(!_if.rstn)
			_if.count <= 0;
		else begin
			if(_if.load_en)
				_if.count <= _if.load;
			else begin
				if(_if.down)
					_if.count <= _if.count - 1;
				else
					_if.count <= _if.count + 1;
			end
		end
	end
	
	assign _if.rollover = &_if.count;
	
endmodule

module tb;
	reg clk;
	
	always #1 clk = ~clk;
	
	cnt_if cnt_if0 (clk);
	
	counter_ud c0 (	cnt_if0 );

	initial begin
		bit load_en, down;
		bit [3:0] load;
		
		$monitor("[%0t] down=%0b load_en=%0b load=%0h count=%0h rollover=%0b", $time, cnt_if0.down, cnt_if0.load_en, cnt_if0.load, cnt_if0.count, cnt_if0.rollover);
		
		//Initialize testbench variable
		clk <= 0;
		cnt_if0.rstn <= 0;
		cnt_if0.load <= 0;
		cnt_if0.load_en <= 0;
		cnt_if0.down <= 0;
		
		repeat (5) @ (posedge clk);
			cnt_if0.rstn <= 1;
		
		//int delay;
		
		for (int i = 0; i < 5; i++) begin	
			automatic int delay = $urandom_range (1,30);
			#(delay);
			
			std::randomize(load, load_en, down);
			
			cnt_if0.load <= load;
			cnt_if0.load_en <= load_en;
			cnt_if0.down <= down;
		end
		
		repeat(5) @ (posedge clk);
			$finish;	
	end
endmodule