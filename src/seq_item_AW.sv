`ifndef SEQ_ITEM_AW_SV
`define SEQ_ITEM_AW_SV

`include "package.sv"
class seq_item_AW extends uvm_sequence_item;
    rand bit [15:0] aw_addr;
    bit [7:0] aw_len ;
    bit [2:0] aw_size;
    bit [1:0] aw_burst ;
    function new(string name ="seq_item_AW");
        super.new(name);
        aw_len   = 7'h07 ;
        aw_size  = 4'b010;
        aw_burst = 2'b00 ;
    endfunction

    `uvm_object_utils_begin(seq_item_AW) 
        `uvm_field_int(aw_addr,UVM_ALL_ON)
        `uvm_field_int(aw_len,UVM_ALL_ON)
        `uvm_field_int(aw_size,UVM_ALL_ON)
        `uvm_field_int(aw_burst,UVM_ALL_ON)
    `uvm_object_utils_end
endclass

`endif 