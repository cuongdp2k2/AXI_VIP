`include "package.sv"
`include "seq_item.sv"
class coverage extends uvm_subscriber#(seq_item);
    `uvm_component_utils(coverage)

    seq_item item ;

    covergroup cov ;
        // option.per_instance = 1;
        // cover_case : coverpoint item ;
        // //cover_case : coverpoint item.* ;
    endgroup ;

    function new(string name="coverage",uvm_component parent=null);
        super.new(name,parent);
        this.cov = new() ;
    endfunction

    virtual function void write(seq_item t) ;
        item = t ;
        cov.sample() ;
    endfunction
endclass