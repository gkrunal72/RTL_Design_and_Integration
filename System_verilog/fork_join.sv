/**************************************************************************
	//fork join
module tb;

	initial begin
		
		$display("[%0t ns] fork join starts...........",$time);
		
		fork
			//Thread 1
			#5 $display("[%0t ns] Thread 1", $time);
			
			//Thread 2
			begin
				#2 $display("[%0t ns] Thread 2 - 1", $time);
				#4 $display("[%0t ns] Thread 2 - 2", $time);
			end
			
			//Thread 3
			#10 $display("[%0t ns] Thread 3", $time);
		join
		
		$display("[%0t ns] After fork join", $time);
	
	end

endmodule

**************************************************************************/

/**************************************************************************
	//fork join_any
module tb;

	initial begin
		
		$display("[%0t ns] fork join starts...........",$time);
		
		fork
			//Thread 1
			#5 $display("[%0t ns] Thread 1", $time);
			
			//Thread 2
			begin
				#2 $display("[%0t ns] Thread 2 - 1", $time);
				#4 $display("[%0t ns] Thread 2 - 2", $time);
			end
			
			//Thread 3
			#10 $display("[%0t ns] Thread 3", $time);
		join_any
		
		$display("[%0t ns] After fork join", $time);
	
	end

endmodule
**************************************************************************/

	//fork join_none
module tb;

	initial begin
		
		$display("[%0t ns] fork join starts...........",$time);
		
		fork
			//Thread 1
			#5 $display("[%0t ns] Thread 1", $time);
			
			//Thread 2
			begin
				#2 $display("[%0t ns] Thread 2 - 1", $time);
				#4 $display("[%0t ns] Thread 2 - 2", $time);
			end
			
			//Thread 3
			#10 $display("[%0t ns] Thread 3", $time);
		join_none
		
		$display("[%0t ns] After fork join", $time);
	
	end

endmodule