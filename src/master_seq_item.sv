`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "package.sv"
class master_seq_item extends uvm_sequence_item;
    // address
    rand bit [15:0] aw_addr;
    rand bit [31:0] w_data [] ;
    
    bit [7:0] aw_len ;
    bit [2:0] aw_size;
    bit [1:0] aw_burst ;

    //constraint data_arr {w_data.size() == aw_len+1 ;} 
    // constructor
    function new(string name ="master_seq_item");
        super.new(name);
        aw_len   = 7'h07 ;
        aw_size  = 4'b010;
        aw_burst = 2'b00 ;
        w_data   = new[aw_len + 1] ;
    endfunction

    `uvm_object_utils_begin(master_seq_item)
        // address + data 
        `uvm_field_int(aw_addr,UVM_DEFAULT)
        //`uvm_field_array_int(w_data,UVM_ALL_ON);
        // setting transaction
        `uvm_field_int(aw_len,UVM_DEFAULT)
        `uvm_field_int(aw_size,UVM_DEFAULT)
        `uvm_field_int(aw_burst,UVM_DEFAULT)
        // control 
        // `uvm_field_int(aw_valid,UVM_ALL_ON) 
        // `uvm_field_int(w_valid,UVM_ALL_ON)
    `uvm_object_utils_end
endclass

`endif 