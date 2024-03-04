`include "package.sv"
`include "master_seq_item.sv"

class master_sequence extends uvm_sequence #(master_seq_item);
    master_seq_item req ;

    `uvm_object_utils(master_sequence) ;
    function new(string name="master_sequence") ;
        super.new(name) ;
    endfunction

    task body();
        `uvm_info(get_type_name() ,"Base seq: Inside Body", UVM_LOW) ;
        `uvm_do(req) ;
    endtask 

endclass