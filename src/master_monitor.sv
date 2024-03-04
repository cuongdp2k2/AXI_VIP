`ifndef MON_SV
`define MON_SV

`include "package.sv"
`include "master_seq_item.sv"

class master_monitor extends uvm_monitor;
    static byte counter = 0 ;
    virtual axi_write_if vif ;
    master_seq_item master_mon_item ;
    master_seq_item fail_item ;
    uvm_analysis_port #(master_seq_item) master_item_collect_port;
    `uvm_component_utils(master_monitor);
    
    function new(string name="master_monitor", uvm_component parent=null);
        super.new(name,parent);
        master_item_collect_port = new("master_item_collect_port",this) ; 
        master_mon_item = master_seq_item::type_id::create("master_mon_item",this) ; 
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction

    task run_phase(uvm_phase phase); 
        fork  
            forever begin
                @(posedge vif.CLK ) ;
                if( vif.AWVALID ) begin
                    $display("Time m_monitor = %0t",$time);
                    master_mon_item.aw_addr  = vif.AWADDR  ;
                    master_mon_item.aw_len   = vif.AWLEN   ;
                    master_mon_item.aw_size  = vif.AWSIZE  ;
                    master_mon_item.aw_burst = vif.AWBUSRT ;
                end
            end

            forever begin
                @(negedge vif.CLK ) ;
                if( vif.WVALID == 1'b1 && vif.WREADY == 1'b1 ) begin
                    if(counter > vif.AWLEN)
                        counter = 0;
                    master_mon_item.w_data[counter] = vif.WDATA;
                    `uvm_info(get_type_name(),$sformatf("master_mon_item.w_data[%0d] = %0h",counter,master_mon_item.w_data[counter]),UVM_NONE);
                    
                    counter++;
                //@(negedge vif.WLAST) ;
                //@(posedge vif.WLAST) ; 
                //@(negedge vif.CLK) ;
                if(vif.WLAST) begin
                    `uvm_info(get_type_name(),$sformatf("Time WLAST_CHECK = %0t",$time),UVM_NONE);
                    foreach(master_mon_item.w_data[i])
                    `uvm_info(get_type_name(),$sformatf("Item w_data =%0h",master_mon_item.w_data[i]),UVM_NONE);
                    master_item_collect_port.write(master_mon_item);    
                end
                end
            end
        join_any
    endtask
endclass

`endif