//bottom-up approach

package counter_env_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

   `include "command_sequence_item.svh"
   `include "sequencer.svh"
     

    `include "result_item.svh"
    `include "driver.svh"
   // `include "counter_ifc.sv"
    `include "command_monitor.svh"
    `include "result_monitor.svh"
    `include "scoreboard.svh"  
    `include "counter_agent_config.svh"
    `include "counter_agent.svh"
    `include "env.svh"
    `include "base_test.svh"


    `include "random_sequence.svh"
    `include "random_test.svh"



endpackage

