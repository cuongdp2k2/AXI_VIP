`include "package.sv"
`include "master_sequencer.sv"
`include "master_driver.sv"
`include "master_monitor.sv"

class master_agent_active extends uvm_agent;
    `uvm_component_utils(master_agent_active);

    master_monitor     mon   ;
    master_driver      drv   ;
    master_sequencer   seqcr ;

    function new(string name="master_agent_active", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        mon   = master_monitor::type_id::create("mon",this);
        drv   = master_driver::type_id::create("drv",this);
        seqcr = master_sequencer::type_id::create("seqcr",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqcr.seq_item_export);
    endfunction

endclass
