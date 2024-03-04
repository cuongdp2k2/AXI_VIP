`ifndef DRV_SV
`define DRV_SV

`include "package.sv"
`include "seq_item.sv"

class driver extends uvm_driver;
    `uvm_component_utils(driver)
    function new(string name="driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
endclass //driver extends uvm_driver

`endif