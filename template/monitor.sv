`ifndef MON_SV
`define MON_SV

`include "package.sv"
`include "seq_item.sv"

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);
    function new(string name="monitor", uvm_component parent=null);
        super.new(name,parent);  
    endfunction
endclass

`endif