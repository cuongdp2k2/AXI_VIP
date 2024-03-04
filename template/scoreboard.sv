`include "package.sv"
`include "seq_item.sv"
//`include "monitor.sv"

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard) ;
    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction
endclass 