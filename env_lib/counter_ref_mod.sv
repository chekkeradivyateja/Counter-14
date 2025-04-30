class counter_refmod;

//counter_trans wrmon_data;
//counter_trans rdmon_data;

	mailbox #(counter_trans) mon2ref;
	mailbox #(counter_trans) ref2scb;
	mailbox #(counter_trans) read2ref;
bit [3:0] count;

function new(mailbox #(counter_trans) mon2ref,
	mailbox #(counter_trans) ref2scd,
	mailbox #(counter_trans) read2ref);
this.mon2ref = mon2ref;
this.ref2scb = ref2scb;
this.read2ref = read2ref;
count = 0;
endfunction

virtual task start();
fork
	forever begin
		counter_trans data2duv;
		mon2ref.get(data2duv);

	if(data2duv.rstn == 0) begin
	count = 0;
	end

	else if (data2duv.load) begin
	count = data2duv.data_in % 14;
	end

	else begin
	if(data2duv.up_down)
	count = (count +1) % 14;
	else
		count = (count - 1 + 14) % 14;
	end

	data2duv.expected_count = count;

read2ref.get(data2duv);
ref2scb.put(data2duv);
end
join_none
endtask
endclass

