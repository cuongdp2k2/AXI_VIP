`include "package.sv"
`include "seq_item.sv"

class seq extends uvm_sequence ;
    `uvm_component_utils(seq) ;
    function new(string name="seq" , uvm_component parent = null) ;
        super.new(name,parent) ;
    endfunction

endclass