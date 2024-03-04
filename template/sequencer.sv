`ifndef SEQCR_SV
`define SEQCR_SV

`include "package.sv"
`include "seq_item.sv"

class sequencer extends uvm_sequencer;
    `uvm_component_utils(sequencer) ;
    function new(string name="sequencer", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass

`endif