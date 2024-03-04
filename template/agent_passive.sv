`include "package.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent_passive extends uvm_agent;
    `uvm_component_utils(agent_passive);

    monitor     mon   ;

    function new(string name="agent_passive", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        mon   = monitor::type_id::create("mon",this);
    endfunction
endclass
