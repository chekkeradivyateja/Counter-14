 module top();

   //Import ram_pkg
   import counter_pkg::*;  
  
   parameter cycle = 10;
 
   reg clock;

   //Instantiate the interface
   count_IF DUV_IF(clock);

   //Declare an handle for the test as test_h
   test test_h;
//	test_ext1 test_h1;
//	test_ext2 test_h2;
  
   //Instantiate the DUV

   counter COUNTER ( .clk(clock),
                  .data_in(DUV_IF.data_in),
                  .count(DUV_IF.count),
                  .load(DUV_IF.load),
                  .up_down(DUV_IF.up_down),
                  .rstn(DUV_IF.rstn) ); 
   
   //Generate the clock
   initial
      begin
         clock = 1'b0;
         forever #(cycle/2) clock=~clock;
      end

   initial
      begin
	 
	`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif
	
	if($test$plusargs("TEST1"))
	begin
	//Create the object for test and pass the interface instances as arguments
         test_h = new(DUV_IF,DUV_IF,DUV_IF);
         number_of_transactions = 2500;
         //Call the virtual task build and virtual task run
         test_h.build();
         test_h.run();
         $finish;
      end

end

   
endmodule
