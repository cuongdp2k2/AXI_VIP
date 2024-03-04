`ifndef SEQ_ITEM_W_SV
`define SEQ_ITEM_W_SV

`include "package.sv"
class seq_item_W extends uvm_sequence_item;
    rand bit [31:0] w_data ;
    bit             w_last  ;
    bit             w_valid ;

    function new(string name ="seq_item_W");
        super.new(name);
        w_last = 0 ;
        w_valid = 0 ;
    endfunction

    `uvm_object_utils_begin(seq_item_W) 
        `uvm_field_int(w_data,UVM_ALL_ON);
        `uvm_field_int(w_last,UVM_ALL_ON) ;
        `uvm_field_int(w_valid,UVM_ALL_ON);
    `uvm_object_utils_end
endclass

`endif 