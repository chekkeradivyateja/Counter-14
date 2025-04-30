class counter_trans;
	rand bit rstn;
	rand bit load;
	rand bit up_down;
	rand bit[3:0] data_in;
	bit [3:0] expected_count;
	bit [3:0] observed_count;
	
	function void display();
	$display("<------------------------------------------------------------>");
	$display("TXN: rstn = %0b/n, load = %0b/n, up = %0b/n, value = %0d => exp = %0d, obsr = %0d",
		rstn, load, up_down, data_in, expected_count, observed_count);
	$display("<------------------------------------------------------------>");
	endfunction
endclass
