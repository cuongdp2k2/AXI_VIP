`include "package.sv"
`include "master_seq_item.sv"
`include "const_param.sv"

class sub_scoreboard extends uvm_scoreboard;
    virtual axi_write_if vif ;
    master_seq_item Items ;
    uvm_analysis_port #(master_seq_item) sub_mon2scb;
    `uvm_component_utils(sub_scoreboard) ;

    function new(string name="sub_scoreboard", uvm_component parent=null);
        super.new(name,parent);
        sub_mon2scb = new("sub_mon2scb",this) ;
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction

    // function void write(master_seq_item req);
    //     Items = req ;
    // endfunction

    // task run_phase(uvm_phase phase);
    //     fork
    //         forever begin
    //             @(negedge vif.WLAST) ;
    //             vif.TRANS_VALID <= checkItem(Items) ;
    //         end
    //     join
    // endtask

    // function bit [1:0] checkItem(master_seq_item newItem) ;
    //     if(newItem.aw_burst == `FIXED) begin
    //         foreach(newItem.w_data[i])
    //             if(newItem.w_data[i][15:0] != newItem.aw_addr) begin 
    //                 $display("Fail Address in the tail of data");
    //                 return `SLVERR ;
    //             end
    //         if(newItem.w_data.size() != newItem.aw_len + 1) begin
    //             $display("Fail data size");
    //             return `SLVERR ;
    //         end 
    //         return `OK ;
    //     end
    // endfunction
endclass 