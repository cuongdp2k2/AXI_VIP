`ifndef SEQ_ITEM_B_SV
`define SEQ_ITEM_B_SV

`include "package.sv"
class seq_item_B extends uvm_sequence_item;
    bit b_ready ;

    function new(string name ="seq_item_B");
        super.new(name);
        b_ready = 0;
    endfunction

    `uvm_object_utils_begin(seq_item_B) 
        `uvm_field_int(b_ready,UVM_ALL_ON)
    `uvm_object_utils_end
endclass

`endif 