	/******************************************************************
module tb;

	bit [7:0] myArray;
	
	bit [0:3][3:0] p_myArray; //Packed Array
	
	/*
	initial begin
		
		myArray = 8'hA2;
		
		for(int i =0; i < $size(myArray); i++) begin
			$display("myArray[%0d] = %0b", i, myArray[i]);
		end
	
	end
	*/
	
	//Packed Array
	/*
	initial begin
		p_myArray = 32'hface_cafe;
		
		foreach (p_myArray[i]) begin
			$display("p_myArray[%0d] = %0h", i, p_myArray[i]);
		end
	end
	*/
	
	
	/******************************************************************
	//Dynamic Array
	//Create int Array
	int d_array [];
	
	int id [];
	
	initial begin
		//define size of Array to 5
		d_array = new [10];
		
		//initialize Array with values
		d_array = '{1,2,3,4,5,7,8,9,0};
		//loop to print its values
		for(int i; i < $size(d_array) ; i++) begin
		
			$display("d_array[%0d] = %0h", i, d_array[i]);
		
		end
		//Copy d_array array to id.
		id = d_array;
		
		//Resize id array and copy existing element of id to new Resized Arra.
		id = new [id.size()+1] (id);
		
		//display all element of id Array
		$display("ID = %p", id);
	end

endmodule	
	**********************************************************************/
/**********************************************************************
module tb;

	//Associative Array
	int 	array1 [int];		//Key = Integer
	int 	array2 [string];	//Key = string
	string 	array3 [string];	//Key = string
	int		array4 [int];
	
	initial begin
		//Initialize each array with element and Key
		array1 = '{ 2: 30,
					3: 29,
					4: 24,
					1: 23};
					
		array2 = '{	"Krunal" : 100,
					"Nimisha": 200,
					"Viral"	 : 400,
					"Neel"	 : 800};
					
		array3 = '{ "Krunal" : "Gandhi",
					"Nimisha": "Parmar",
					"Viral"	 : "Parmar",
					"Neel"	 : "Patel"};
					
		//Print each Array
		
		$display("array1 = %p", array1);
		$display("array2 = %p", array2);
		$display("array3 = %p", array3);		
	end
endmodule
**********************************************************************/

/**********************************************************************
module tb;

	int fruits_10 [string];
	int empty_array [string];
	
	initial begin
		//Initialize Array
		fruits_10 = '{  "apple"  : 4,
						"orange" : 10,
						"plum"	 : 9,
						"guava"	 : 1 };
		
		//Num of Entry Method
		$display("fruits_10.num() 	= %0d", fruits_10.num());
		$display("empty_array.num() = %0d", empty_array.num());
		
		//Size of Array
		$display("fruits_10.size() 	= %0d", fruits_10.size());
		$display("empty_array.size()= %0d", empty_array.size());
		
		//Delete	
		empty_array = fruits_10;
		
		empty_array.delete("guava");
		$display("fruits_10 = %p", fruits_10);
		$display("empty_array = %p", empty_array);
		
		//Exists
		if (empty_array.exists ("guava") )
			$display("%0d guavas are available", empty_array["guava"]);
		else
			$display("guava is not available");			
			
		if (fruits_10.exists("orange"))
			$display("%0d oranges are available", fruits_10["orange"]);
		else
			$display("oranges are not available");
			
		//first
		begin
			string f;
			if(fruits_10.first(f))
				$display("fruits_10.first(%s) = %d", f, fruits_10[f]);
		end
		//Last
		begin
			string f;
			if(fruits_10.last(f))
				$display("fruits_10.last(%s) = %d", f, fruits_10[f]);
		end
		
		//Previous
		begin
			string f = "guava";
			if(fruits_10.prev (f))
				$display("fruits_10.prev(%s) = %0d", f, fruits_10[f]);
			
			$display("f= %s", f);
		end
		
		//Next
		begin
			string f = "guava";
			if(fruits_10.next (f))
				$display("fruits_10.next(%s) = %0d", f, fruits_10[f]);
			
			$display("f= %s", f);
		end
	end
endmodule
**********************************************************************/

/**********************************************************************
	//Dynamic Associative Array
module tb;

	int fruits [] [string]; //Emptry array with String key for indexing
	
	initial begin
	
		fruits = new [2];
		
		fruits[0] = '{"apple" : 1, "orange" : 2};
		fruits[1] = '{"guava" : 3, "plum" : 4};
		
		foreach(fruits[i]) begin
			foreach(fruits[i][fruit]) begin
				$display("fruits[%0d][%s] = %0d", i, fruit, fruits[i][fruit]);
			end
		end
	
	end
	
endmodule

**********************************************************************/

/**********************************************************************
	//Dynamic array within each index of an Associative Array
typedef int int_da [];

module tb;

	int_da fruits [string];
	
	initial begin
		fruits ["apple"] = new [2];
		
		fruits ["apple"] = '{4,5};
		
		foreach(fruits[str1]) begin
			foreach(fruits[str1][i]) begin
				$display("fruits[%s][%0d] = %0d", str1, i, fruits[str1][i]);
			end
		end
		
	end
endmodule
**********************************************************************/

/**********************************************************************
	//Array manipulation
	
module tb;

	int array[9] = '{4,7,2,5,7,1,6,3,1};
	int res[$];
	
	initial begin
		
		res = array.find(x) with (x >= 3);
		$display("array.find(x) = %p", res);
		
		res = array.find_index with (item == 7);
		$display("array.find_index(x) = %p", res);
		
		res = array.find_first with ( item <6 & item >= 1 );
		$display("array.find_first : %p", res);
		
		res = array.find_first_index(x) with ( x > 4 );
		$display("array.find_first_index : %p", res);
		
		res = array.find_last with (item <= 7 & item > 3);
		$display("array.find_last : %p", res);
		
		res = array.find_last_index(x) with (x > 1);
		$display("array.find_last_index : %p", res);
		
		res = array.min();
		$display("array.min : %p", res);
		
		res = array.max();
		$display("array.max : %p", res);
		
		res = array.unique();
		$display("array.unique : %p",res);
		
		res = array.unique(x) with (x < 4);
		$display("array.unique : %p",res);
		
		res = array.unique_index;
		$display("array.unique_index : %p", res);
		
		array.reverse();
		$display("array.reverse = %p", array);
		
		array.sort();
		$display("array.sort = %p", array);
		
		array.rsort();
		$display("array.rsort = %p", array);
		
		array.shuffle();
		$display("array.shuffle = %p", array);
		
	end
endmodule
**********************************************************************/


	//Array Ordering on Classes
class Register;
	string name;
	rand bit [3:0] rank;
	rand bit [3:0] pages;
	
	function new (string name);
		this.name = name;
	endfunction
	
	function void print();
		$display("name=%s rank=%0d pages=%0d", name, rank, pages);
	endfunction
	
endclass

module tb;
	Register rt[4];
	string name_arr[4] = '{"alexa", "siri", "google home", "cortana"};
	
	initial begin
		
		$display("
		--------Initial values------------");
		foreach (rt[i]) begin
			rt[i] = new(name_arr[i]);
			rt[i].randomize();
			rt[i].print();
		end
		
		$display("
		---------Sort by name-------------");
		rt.sort(x) with (x.name);
		foreach (rt[i]) rt[i].print();
		
		$display("
		---------Sort by rank, pages -------------");
		rt.sort(x) with ({x.rank, x.pages});
		foreach(rt[i]) rt[i].print();
	
	end
	
endmodule


/**********************************************************************
	//Array reduction methods
module tb;
	int array[4] = '{1,2,3,4};
		
	initial begin
		
		$display("Sum 		= %0d", array.sum());
		$display("Product 	= %0d", array.product());
		$display("And 		= %0h", array.and());
		$display("Or		= %0h", array.or());
		$display("Xor		= %0h", array.xor());
	
	end

endmodule
**********************************************************************/