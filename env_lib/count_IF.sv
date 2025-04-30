interface count_IF(input clk);
	logic rstn;
	logic load;
	logic up_down;
	logic [3:0] data_in;
	logic [3:0] count;
 clocking wr_drv_cb @(posedge clk);
	default input #1 output #1;
	output load;
	output up_down;
	output data_in;
	output rstn;
endclocking

clocking wr_mon_cb @(posedge clk);
	default input #1 output #1;
	input load;
	input up_down;
	input data_in;
	input rstn;
endclocking


clocking rd_mon_cb @(posedge clk);
	default input #1 output #1;
	input count;
endclocking

modport WR_DRV_MP (clocking wr_drv_cb);
modport WR_MON_MP (clocking wr_mon_cb);
modport RD_MON_MP (clocking rd_mon_cb);
endinterface
