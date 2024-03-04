`include "package.sv"
`include "agent_active.sv"
`include "agent_passive.sv"
`include "scoreboard.sv"
`include "coverage.sv"

class env extends uvm_env ;
    agent_active agt_atv ;
    agent_passive agt_pas ;
    scoreboard scb ;
    coverage func_cov ;

    `uvm_component_utils(env) ;
    function new(string name= "env" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction //new()

    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        agt_atv  = agent_active::type_id::create("agt_atv",this);
        agt_pas  = agent_passive::type_id::create("agt_pas",this);
        scb      = scoreboard::type_id::create("scb",this);
        func_cov = coverage::type_id::create("func_cov",this) ;
    endfunction
endclass