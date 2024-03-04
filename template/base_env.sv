`include "env.sv"

class base_env extends uvm_test;
    `uvm_component_utils(base_env) ;
    env newEnv ;
    function new(string name= "base_env" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction //new()

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        newEnv   = env::type_id::create("newEnv",this);
    endfunction

    // task run_phase(uvm_phase phase);
    //     uvm_top.print_topology() ;
    // endtask

    function void report_phase(uvm_phase phase );
        super.report_phase(phase);
        uvm_top.print_topology() ;
    endfunction
endclass // base_env