`include "package.sv"
`include "sub_agent_active.sv"
`include "sub_scoreboard.sv"

class sub_env extends uvm_env ;
    sub_agent_active sub_agt_atv ;
    sub_scoreboard sub_scb ;

    `uvm_component_utils(sub_env) ;
    function new(string name= "sub_env" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction //new()

    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        sub_agt_atv  = sub_agent_active::type_id::create("sub_agt_atv",this);
        sub_scb      = sub_scoreboard::type_id::create("sub_scb",this);
    endfunction
endclass 