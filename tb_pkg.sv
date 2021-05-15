
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "add_sub_sequence_item.sv"        // transaction class
 `include "add_sub_sequence.sv"             // sequence class
 `include "add_sub_sequencer.sv"            // sequencer class
 `include "add_sub_driver.sv"               // driver class
 `include "add_sub_monitor.sv"
 `include "add_sub_agent.sv"                // agent class  
 `include "add_sub_coverage.sv"             // coverage class
 `include "add_sub_scoreboard.sv"    
 `include "add_sub_env.sv"                  // environment class
 `include "add_sub_test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


