class counter_generator;

    counter_trans data2duv;

     mailbox #(counter_trans) gen2wr;

   function new(mailbox #(counter_trans) gen2wr);
      this.gen2wr = gen2wr;
   endfunction

   virtual task start();
      fork
         repeat (30) begin  
            data2duv = new();

                        assert(data2duv.randomize());

                     gen2wr.put(data2duv);

            $display("[GENERATOR] Time: %0t | Sent: rstn=%0b, load=%0b, data_in=%0d, up_down=%0b",
                     $time, data2duv.rstn, data2duv.load, data2duv.data_in, data2duv.up_down);

                        #10;
         end
      join_none
   endtask

endclass

