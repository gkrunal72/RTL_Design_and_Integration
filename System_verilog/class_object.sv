
class baseClass;
/*
	int addr;
	
	function new (int addr);
		this.addr = addr;
	endfunction
*/	
	virtual function void display();
		$display("[Base]");
	endfunction
endclass

class childClass_1 extends baseClass;
/*
	int data;
	
	function new (int data);
		//super.new(addr);
		this.data = data;
	endfunction
*/	
	function void display();
		$display("[Child - 1]");
	endfunction
		
endclass

class childClass_2 extends baseClass;
/*
	int data;
	
	function new (int data);
		//super.new(addr);
		this.data = data;
	endfunction
*/	
	function void display();
		$display("[Child - 2]");
	endfunction
		
endclass

class childClass_3 extends baseClass;
/*
	int data;
	
	function new (int data);
		//super.new(addr);
		this.data = data;
	endfunction
*/	
	function void display();
		$display("[Child - 3]");
	endfunction
		
endclass

module tb;
	
	
	initial begin
			
		childClass_1 cc1 = new ();
		childClass_2 cc2 = new ();
		childClass_3 cc3 = new ();
		
		baseClass bc[3];
		
		bc[0] = cc1;
		bc[1] = cc2;
		bc[2] = cc3;
		
		bc[0].display();
		bc[1].display();
		bc[2].display();
		//cc.display();
	end
endmodule


/***********************************************************************************
//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------

// base class 
class base_class;
  virtual function void display();
    $display("Inside base class");
  endfunction
endclass

// extended class 1
class ext_class_1 extends base_class;
  function void display();
    $display("Inside extended class 1");
  endfunction
endclass

// extended class 2
class ext_class_2 extends base_class;
  function void display();
    $display("Inside extended class 2");
  endfunction
endclass

// extended class 3
class ext_class_3 extends base_class;
  function void display();
    $display("Inside extended class 3");
  endfunction
endclass

// module
module tb;

  initial begin 
    
    //declare and create extended class
    ext_class_1 ec_1 = new();
    ext_class_2 ec_2 = new();
    ext_class_3 ec_3 = new();
    
    //base class handle
    base_class b_c[3];
    
    //assigning extended class to base class
    b_c[0] = ec_1;
    b_c[1] = ec_2;
    b_c[2] = ec_3;
    
    //accessing extended class methods using base class handle
    b_c[0].display();
    b_c[1].display();
    b_c[2].display();
  end

endmodule
***********************************************************************************/