`ifndef SUB_MON_SV
`define SUB_MON_SV

`include "package.sv"
`include "master_seq_item.sv"

class sub_monitor extends uvm_monitor;
    static byte counter = 0 ;
    virtual axi_write_if vif ;
    master_seq_item sub_mon_item ;
    master_seq_item fail_mon_item ;
    uvm_analysis_port #(master_seq_item) sub_item_collect_port;
    `uvm_component_utils(sub_monitor);


    function new(string name="sub_monitor", uvm_component parent=null);
        super.new(name,parent);
        sub_item_collect_port = new("sub_item_collect_port",this) ;  
        sub_mon_item = master_seq_item::type_id::create("sub_mon_item",this);
        fail_mon_item = master_seq_item::type_id::create("fail_mon_item",this);
    endfunction

    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction


    function void end_of_elaboration_phase (uvm_phase phase);
        super.end_of_elaboration_phase(phase);
            fail_mon_item.aw_addr = 5;
            fail_mon_item.w_data [8] = {5,2,4,5,6,7,8,9};
            fail_mon_item.aw_len = 10;
            fail_mon_item.aw_size = 4;
            fail_mon_item.aw_burst = 1 ;
    endfunction


    task run_phase(uvm_phase phase);
        fork
            forever begin  : GET_VALUE_IN_AW_CHANEL
                @(negedge vif.CLK) ;
                if( vif.AWREADY ) begin
                    sub_mon_item.aw_addr  = vif.AWADDR  ;
                    sub_mon_item.aw_len   = vif.AWLEN   ;
                    sub_mon_item.aw_size  = vif.AWSIZE  ;
                    sub_mon_item.aw_burst = vif.AWBUSRT ;   
                end    
            end

            forever begin : GET_VALUE_IN_W_CHANEL
                @(negedge vif.CLK) ;
                if( vif.WREADY ) begin
                    if(  counter > sub_mon_item.aw_len )
                        counter = 0 ;
                    
                    sub_mon_item.w_data[counter] = vif.WDATA ;

                    counter++ ;
                end
            end

            forever begin : SEND_TRANSACTION_TO_SCOREBOARD
                @(posedge vif.WLAST)
                @(negedge vif.CLK) ;
                sub_item_collect_port.write(sub_mon_item) ;
                    
            end
        join
    endtask

endclass

`endif