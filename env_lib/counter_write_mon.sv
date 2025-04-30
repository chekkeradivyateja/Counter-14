class counter_write_mon;

   virtual count_IF.WR_MON_MP wr_mon_if;
   counter_trans tx_mon;
   mailbox #(counter_trans) mon2ref;

   function new(virtual count_IF.WR_MON_MP wr_mon_if,
                mailbox #(counter_trans) mon2ref);
      this.wr_mon_if = wr_mon_if;
      this.mon2ref = mon2ref ;
   endfunction: new

     virtual task start();
      fork
         forever begin 
            mon2ref.put(tx_mon); 
         end
      join_none
   endtask: start

endclass: counter_write_mon

