`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "package.sv"
class seq_item extends uvm_sequence_item;
    function new(string name ="seq_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(seq_item) 
        //`uvm_field_*(VAL,FLAG);
    `uvm_object_utils_end
endclass

`endif 