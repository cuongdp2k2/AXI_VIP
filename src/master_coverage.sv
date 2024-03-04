`include "package.sv"
`include "master_seq_item.sv"
class master_coverage extends uvm_subscriber#(master_seq_item);
    `uvm_component_utils(master_coverage)

    master_seq_item item ;

    covergroup cov ;
        // option.per_instance = 1;
        // cover_case : coverpoint item ;
        // //cover_case : coverpoint item.* ;
    endgroup ;

    function new(string name="master_coverage",uvm_component parent=null);
        super.new(name,parent);
        this.cov = new() ;
    endfunction

    virtual function void write(master_seq_item t) ;
        item = t ;
        cov.sample() ;
    endfunction
endclass
