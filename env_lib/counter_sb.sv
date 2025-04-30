class counter_scoreboard;
	event DONE;
   mailbox #(counter_trans) ref2scb;
	int data_verified = 0;
	int rm_data_count = 0;
	int cov_data_count = 0;

	counter_trans rm_data;
	counter_trans rcvd_data;
	counter_trans cov_data;
	covergroup count_coverage;
		RST: coverpoint cov_data.rstn
			{bins r = {0,1};}
		LOAD: coverpoint cov_data.load
			{bins l[] = {0,1};}
		DIN: coverpoint cov_data.up_down
			{bins up= {0,1};}
		ECNT: coverpoint cov_data.expected_count
			{bins count = {[0:13]};}
		OCNT: coverpoint cov_data.observed_count
			{bins count = {[0:13]};}
	endgroup

      function new(mailbox #(counter_trans) ref2scb);
      this.ref2scb = ref2scb;
   endfunction

     virtual task start();
      fork
         forever begin
            counter_trans data2scb;

                       ref2scb.get(data2scb);

                      if (data2scb.expected_count === data2scb.observed_count) begin
		$display("<------------------------------------------------------------------------->");
               $display("[SCOREBOARD][PASS] Time: %0t | Expected: %0d | Observed: %0d",
                        $time, data2scb.expected_count, data2scb.observed_count);
		$display("<------------------------------------------------------------------------->");

            end
            else begin
               $display("[SCOREBOARD][FAIL] Time: %0t | Expected: %0d | Observed: %0d",
                        $time, data2scb.expected_count, data2scb.observed_count);
		$display("<------------------------------------------------------------------------->");

            end
         end
      join_none
	if(data_verified >= (number_of_transactions))
	begin
	->DONE;
	end
   endtask

endclass

