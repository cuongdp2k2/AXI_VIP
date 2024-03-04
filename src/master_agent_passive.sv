`include "package.sv"
`include "master_sequencer.sv"
`include "master_driver.sv"
`include "master_monitor.sv"

class master_agent_passive extends uvm_agent;
    `uvm_component_utils(master_agent_passive);

    master_monitor     mon   ;

    function new(string name="master_agent_passive", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        mon   = master_monitor::type_id::create("mon",this);
    endfunction
endclass
