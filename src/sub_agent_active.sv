`include "package.sv"
`include "sub_driver.sv"
`include "sub_monitor.sv"

class sub_agent_active extends uvm_agent ;
    `uvm_component_utils(sub_agent_active);
    sub_driver sub_drv ;
    sub_monitor sub_mon ;
    function new(string name="sub_agent_active", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        sub_drv = sub_driver::type_id::create("sub_drv",this);
        sub_mon = sub_monitor::type_id::create("sub_mon",this);
    endfunction
endclass