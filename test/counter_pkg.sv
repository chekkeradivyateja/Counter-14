package counter_pkg;

   int number_of_transactions=1;

   //include the files

`include "counter_trans.sv"
`include "counter_gen.sv"
`include "counter_write_drv.sv"
`include "counter_write_mon.sv"
`include "counter_read_mon.sv"
`include "counter_ref_mod.sv"
`include "counter_sb.sv"
`include "counter_env.sv"
`include "test.sv"

endpackage
