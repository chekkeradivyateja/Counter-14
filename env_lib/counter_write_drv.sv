class counter_write_drv;
	virtual count_IF.WR_DRV_MP wr_drv_if;
	counter_trans data2duv;
	mailbox #(counter_trans) gen2wr;

function new(virtual count_IF.WR_DRV_MP wr_drv_if, mailbox #(counter_trans)gen2wr);
	this.wr_drv_if = wr_drv_if;
	this.gen2wr = gen2wr;
endfunction


virtual task drive();
	@(wr_drv_if.wr_drv_cb);
	wr_drv_if.wr_drv_cb.load                <= data2duv.load;
	wr_drv_if.wr_drv_cb.rstn               <= data2duv.rstn;
	wr_drv_if.wr_drv_cb.up_down            <= data2duv.up_down;
	wr_drv_if.wr_drv_cb.data_in               <= data2duv.data_in;

repeat(2)
	@(wr_drv_if.wr_drv_cb);
		wr_drv_if.wr_drv_cb.rstn <= 0;
	wr_drv_if.wr_drv_cb.load <= 0;
endtask


virtual task start();
	fork
	forever begin
		gen2wr.get(data2duv);
		drive();
		end
	join_none
endtask

endclass	
