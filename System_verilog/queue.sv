
/***********************************************************************
//Slice expressions

module tb;
	
	string fruits[$] = {"orange", "apple", "lemon", "kiwi"};
	
	initial begin
		//Select subset of Queue
		$display("Subset of Queue = %p", fruits[1:2]);
		
		//Get elements from 1 to end of Queue
		$display("Elements from 1 to end = %p", fruits[1:$]);
		
		//Add element to end of the Queue
		fruits[$+1] = "pineapple";
		$display("Add element to end of Queue = %p", fruits);
		
		//Add element to start of the Queue
		fruits = {"grapes", fruits};
		$display("Add element to start of the Queue = %p", fruits);
		
		//Delete first element
		fruits = fruits[1:$];
		$display("Delete first element = %p", fruits);
		
		//Delete last element
		fruits = fruits[0:$-1];
		$display("Delete last element = %p", fruits);
		
	end
endmodule
***********************************************************************/

/***********************************************************************
//Queue Methods

module tb;
	
	string fruits[$] = {"apple", "pear", "mango", "banana"};
	
	initial begin
		
		//Size()
		$display("Size of fruits = %0d",fruits.size());
		
		//Insert()
		fruits.insert(2, "kiwi");
		$display("Insert element = %p",fruits);
		
		//Delete()
		fruits.delete(4);
		$display("Delete element = %p", fruits);
		
		//pop_front
		fruits.pop_front();
		$display("Pop front = %p", fruits);
		
		//pop_back
		fruits.pop_back();
		$display("pop_back = %p", fruits);
		
		//push_front
		fruits.push_front("orange");
		$display("push_front = %p", fruits);
		
		//push_back
		fruits.push_back("guava");
		$display("push_front = %p", fruits);
		
	
	end

endmodule
***********************************************************************/

/***********************************************************************
	//Queue of Class
class fruits;
	string name;
	
	function new (string name = "unknown");
		this.name = name;
	endfunction
	
endclass

module tb;

	fruits list [$];
	
	initial begin
	
		fruits f = new ("Apple");
		list.push_back(f);
		
		f = new("Banana");
		list.push_back(f);
		
		foreach(list[i])
			$display("Fruits[%0d] = %s ", i , list[i].name);
			
		$display("List = %p", list);
	end

endmodule
***********************************************************************/

	//Queue of Dynamic array

typedef string str_da [];

module tb;
	str_da list [$];
	
	initial begin
		
		//Initialize dynamic arrays with values
		str_da karjan = '{"Krunal", "Nimit", "Harsh", "Gauri", "Gotu", "Krupa", "Kirtan", "Divy"};
		str_da limda = '{"Nimisha", "Vaisu", "Harshil", "Viral", "Gotu", "Dhruvi"};
		
		//push back arrays to Queue
		list.push_back(karjan);
		list.push_back(limda);
		
		//print each element of Queue
		foreach(list[i]) begin
			foreach(list[i][j]) begin
				$display("List[%0d][%0d] = %s", i, j, list[i][j]);
			end
		end
		
		//print whole Queue
		$display("List = %p", list);
	end
endmodule