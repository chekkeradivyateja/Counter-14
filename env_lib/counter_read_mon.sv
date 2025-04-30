class counter_read_mon;

     virtual count_IF.RD_MON_MP rd_mon_if;

     counter_trans tx_read;
counter_trans data_from_duv;

     mailbox #(counter_trans) read2ref;
	mailbox #(counter_trans) read2sb;	


   function new(virtual count_IF.RD_MON_MP rd_mon_if,
                mailbox #(counter_trans) read2ref,
		mailbox #(counter_trans) read2sb);
      this.rd_mon_if = rd_mon_if;
      this.read2ref  = read2ref;
	this.read2sb = read2sb;
	this.data_from_duv = new;
   endfunction: new


virtual task monitor();
	forever begin
		@(rd_mon_if.rd_mon_cb);
		//data_from_duv = new();
		data_from_duv.observed_count = rd_mon_if.rd_mon_cb.count;
		read2ref.put(data_from_duv);
	end
endtask


   virtual task start();
      fork
         monitor();
      join_none
   endtask: start

endclass: counter_read_mon

