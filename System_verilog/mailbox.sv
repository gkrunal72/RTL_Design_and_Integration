/*****************************************************************************************
	//Generic Mailbox
module tb;
	mailbox mbx = new(2);
	
	initial begin
		
		for(int i=0; i < 5; i++) begin
			#1 mbx.put(i);
			$display("[%0t] Thread 0: put item #%0d, size = %0d", $time, i, mbx.num());
		end
	end
	
	initial begin
		forever begin
			int idx;
			#2 mbx.get(idx);
			$display("[%0t] Thread 1: Got item #%0d, size = %0d", $time, idx, mbx.num());
		end
	end

endmodule
*****************************************************************************************/

	//parameterized mailbox
//define mailbox as string
typedef mailbox #(string) s_mbx;

//class to send message
class comp1;
	
	s_mbx names;
	
	task send();
		for (int i=0; i < 5; i++) begin
			string s = $sformatf ("name_%0d",i);
			#5 $display("[%0t] comp1 put %s", $time, s);
			names.put(s);
		end
	endtask

endclass

//class to receive message
class comp2;
	s_mbx list;
	
	task receive();
		forever begin
			string s;
			list.get(s);
			$display("[%0t] comp2 get %s", $time, s);
		end
	endtask
endclass

//Connect mailbox handles at higher level
module tb;
	s_mbx m_mbx = new();
	comp1 m_comp1 = new();
	comp2 m_comp2 = new();
	
	initial begin
		m_comp1.names = m_mbx;
		m_comp2.list = m_mbx;
		
		fork
			m_comp1.send();
			m_comp2.receive();
		join
	end

endmodule