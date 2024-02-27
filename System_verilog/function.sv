	//Recursive function
	//Factorial series
	
module tb;
	
	initial begin
		int result = factorial(4);
		$display("Factorial(4) = %0d", result);
	end
	function automatic int factorial (int i);
		int result = i;
		
		if (i) begin
			result = i * factorial(i-1);
			$display("i=%0d result=%0d", i, result);
		end
		
		else
			result = 1;
			
		return result;
	endfunction
	
endmodule