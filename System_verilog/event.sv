 //Events
 
module tb;
	
	event event_a;
	
	initial begin
	
		#20 -> event_a;
		$display("Thread 1 : event_a triggered");
	end
	
	//Wait for the event using @
	initial begin
		@(event_a);
		$display("event_a triggered using @");
	end
	
	//Wait for the event using "wait"
	initial begin
		wait(event_a.triggered);
		$display("event_a triggered using 'wait' ");
	end

endmodule