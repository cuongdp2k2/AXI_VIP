`include "package.sv"
`include "master_seq_item.sv"
`include "master_monitor.sv"
`include "sub_monitor.sv"
`include "const_param.sv"
`uvm_analysis_imp_decl (_PORT_A)
`uvm_analysis_imp_decl (_PORT_B)

class master_scoreboard extends uvm_scoreboard;
    master_seq_item newItem ;
    master_seq_item newSubItem ;
    static byte compare_flag = 0;
    master_seq_item master_items[$] ;
    master_seq_item sub_items[$]    ;
    virtual axi_write_if vif ;


    `uvm_component_utils(master_scoreboard) ;
    uvm_analysis_imp_PORT_A #(master_seq_item, master_scoreboard) analysis_imp_master;
    uvm_analysis_imp_PORT_B #(master_seq_item, master_scoreboard) analysis_imp_slave;
    function new(string name="master_scoreboard", uvm_component parent=null);
        super.new(name,parent);
        analysis_imp_master = new("analysis_imp_master",this) ;
        analysis_imp_slave  = new("analysis_imp_slave"   ,this) ;
        newItem = master_seq_item::type_id::create("newItem");
        newSubItem = master_seq_item::type_id::create("newSubItem");
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction

    function void write_PORT_A(master_seq_item req);
        $display("Process push back in MASTER_ITEM");
        master_items.push_back(req);
    endfunction

    function void write_PORT_B(master_seq_item req);
        sub_items.push_back(req);
    endfunction

    function bit check_trans (master_seq_item master_items , master_seq_item sub_items) ;
        return master_items.compare(sub_items);
    endfunction

    task run_phase (uvm_phase phase);
        fork
            forever begin : MATER_PROCESSING
                @(negedge vif.WLAST)
                if(master_items.size() != 0) begin
                    newItem = master_items.pop_front() ;
                    //$display("check_master_address = %0d",check_master_address(newItem)) ;
                    `uvm_info(get_type_name(),$sformatf("SCOREBOARD---------------"),UVM_NONE);
                    `uvm_info(get_type_name(),$sformatf("Inside Master Item , Addr= %0h, AWLEN = %0h, AWSIZE=%0h, Data size= %0d",newItem.aw_addr,newItem.aw_len,newItem.aw_size,newItem.w_data.size()),UVM_NONE);
                    foreach(newItem.w_data[i])
                        //$display("[Scoreboard-Master] %0h",newItem.w_data[i]);
                        `uvm_info("Scoreboard-Master",$sformatf("%0h",newItem.w_data[i]),UVM_NONE);
                    end else begin
                        //$display("[Scoreboard-Master] Null queue");
                        `uvm_info("Scoreboard-Master",$sformatf("Null queue"),UVM_NONE);
                    end //$stop;
                compare_flag ++ ;
            end

            forever begin : SUB_PROCESSING
                @(negedge vif.WLAST)
                if(sub_items.size() != 0) begin
                    newSubItem = sub_items.pop_back() ;
                    
                    `uvm_info(get_type_name(),$sformatf("SCOREBOARD---------------"),UVM_NONE);
                    `uvm_info(get_type_name(),$sformatf("Inside Sub Item , Addr= %0h, AWLEN = %0h, AWSIZE=%0h, Data size= %0d",newSubItem.aw_addr,newSubItem.aw_len,newSubItem.aw_size,newSubItem.w_data.size()),UVM_NONE);
                    foreach(newSubItem.w_data[i])
                        `uvm_info("Scoreboard-Sub",$sformatf("%0h",newSubItem.w_data[i]),UVM_NONE);
                    end else begin
                        `uvm_info("Scoreboard-Sub",$sformatf("Null queue"),UVM_NONE);
                end //$stop;\
                compare_flag ++ ;
            end   

            forever begin  
                @(negedge vif.CLK)  ;
                if(compare_flag == 2) begin
                    compare_flag = 0 ;
                    if(newItem.compare(newSubItem)) begin
                        vif.TRANS_VALID <= `OK ;
                        $display("============================SCOREBOARD CHECK PASSED============================");
                        //`uvm_info(get_type_name(),$sformatf("PASSED"),UVM_NONE);
                    end else begin
                        vif.TRANS_VALID <= `SLVERR  ;
                        $display("============================SCOREBOARD CHECK FAILED============================");
                       // `uvm_info(get_type_name(),$sformatf("FAILED"),UVM_NONE);
                    end
                end
            end
        join_any
    endtask


endclass 