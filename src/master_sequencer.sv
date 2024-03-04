`ifndef SEQCR_SV
`define SEQCR_SV

`include "package.sv"
`include "master_seq_item.sv"

class master_sequencer extends uvm_sequencer#(master_seq_item);
    `uvm_component_utils(master_sequencer) ;
    function new(string name="master_sequencer", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase) ;
    endfunction
endclass

`endif