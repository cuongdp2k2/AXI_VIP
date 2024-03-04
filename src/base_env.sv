`include "master_env.sv"
`include "sub_env.sv"
`include "master_sequence.sv"
`include "master_scoreboard.sv"

class base_env extends uvm_test;
    master_env master_Envir ;
    sub_env sub_Envir ;
    master_sequence bseq;
    master_scoreboard scb ;

    `uvm_component_utils(base_env) ;
    function new(string name= "base_env" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction //new()

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        master_Envir   = master_env::type_id::create("master_Envir",this);
        sub_Envir      = sub_env::type_id::create("sub_Envir",this);
        scb            = master_scoreboard::type_id::create("scb",this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        bseq = master_sequence::type_id::create("bseq");
        repeat(2) begin 
            bseq.start(master_Envir.agt_atv.seqcr);
            #5; 
        end
        
        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of testcase", UVM_LOW);
    endtask

    function void connect_phase(uvm_phase phase);
        master_Envir.agt_atv.mon.master_item_collect_port.connect(scb.analysis_imp_master);
        sub_Envir.sub_agt_atv.sub_mon.sub_item_collect_port.connect(scb.analysis_imp_slave);
    
        //sub_Envir.sub_agt_atv.sub_mon.sub_item_collect_port.connect(sub_Envir.sub_scb.sub_mon2scb) ;
    endfunction

    function void report_phase(uvm_phase phase );
        super.report_phase(phase);
        uvm_top.print_topology() ;
    endfunction
endclass // base_env