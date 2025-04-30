class counter_env;

   
   mailbox #(counter_trans) gen2wr;
   mailbox #(counter_trans) mon2ref;
   mailbox #(counter_trans) ref2scb;
   mailbox #(counter_trans) read2ref;
   mailbox #(counter_trans) read2scb;

 
   counter_generator gen;
   counter_write_drv wr_drv;
   counter_write_mon wr_mon;
   counter_read_mon  rd_mon;
   counter_refmod    refmod;
   counter_scoreboard scb;

   
   virtual count_IF.WR_DRV_MP wr_drv_if;
   virtual count_IF.WR_MON_MP wr_mon_if;
   virtual count_IF.RD_MON_MP rd_mon_if;

   function new(virtual count_IF.WR_DRV_MP wr_drv_if,
                virtual count_IF.WR_MON_MP wr_mon_if,
                virtual count_IF.RD_MON_MP rd_mon_if);
      this.wr_drv_if = wr_drv_if;
      this.wr_mon_if = wr_mon_if;
      this.rd_mon_if = rd_mon_if;

      gen2wr   = new();
      mon2ref  = new();
      ref2scb  = new();
      read2ref = new();
	read2scb = new();
   endfunction

   virtual task build();
      
      gen     = new(gen2wr);
      wr_drv  = new(wr_drv_if, gen2wr);
      wr_mon  = new(wr_mon_if, mon2ref);
      rd_mon  = new(rd_mon_if, read2ref, read2scb);
      refmod  = new(mon2ref, ref2scb, read2ref);
      scb     = new(ref2scb);
	endtask

virtual task start();
      
      gen.start();
      wr_drv.start();
      wr_mon.start();
      rd_mon.start();
      refmod.start();
      scb.start();
   endtask

virtual task stop();
      wait(scb.DONE.triggered);
   endtask: stop 


 virtual task run();
      
      start();
      stop();
      //scb.report();
   endtask: run



endclass

