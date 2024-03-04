`include "package.sv"
`include "master_agent_active.sv"
`include "master_agent_passive.sv"
// `include "master_scoreboard.sv"
// `include "master_coverage.sv"

class master_env extends uvm_env ;
    master_agent_active agt_atv ;
    master_agent_passive agt_pas ;
    // master_scoreboard scb ;
    // master_coverage func_cov ;

    `uvm_component_utils(master_env) ;
    function new(string name= "master_env" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction //new()

    function void build_phase(uvm_phase phase) ;
        super.build_phase(phase) ;
        agt_atv  = master_agent_active::type_id::create("agt_atv",this);
        //agt_pas  = master_agent_passive::type_id::create("agt_pas",this);
        // scb      = master_scoreboard::type_id::create("scb",this);
        // func_cov = master_coverage::type_id::create("func_cov",this) ;
    endfunction
endclass
