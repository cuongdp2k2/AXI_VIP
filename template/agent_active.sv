`include "package.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent_active extends uvm_agent;
    `uvm_component_utils(agent_active);

    monitor     mon   ;
    driver      drv   ;
    sequencer   seqcr ;

    function new(string name="agent_active", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        mon   = monitor::type_id::create("mon",this);
        drv   = driver::type_id::create("drv",this);
        seqcr = sequencer::type_id::create("seqcr",this);
    endfunction

endclass
