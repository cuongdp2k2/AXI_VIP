`ifndef DRV_SV
`define DRV_SV

`include "package.sv"
`include "master_seq_item.sv"
`include "const_param.sv"

class master_driver extends uvm_driver #(master_seq_item);
    virtual axi_write_if vif ;
    static byte counter = 0 ;

    `uvm_component_utils(master_driver)

    function new(string name="master_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase) ;
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction

    task reset_phase(uvm_phase phase);
	    wait(vif.RESET) ;
	    vif.AWVALID = 0 ; 
        vif.WLAST   = 0 ;
        vif.AWADDR  = 0 ;
        vif.AWLEN   = 0 ;
        vif.AWSIZE  = 0 ;
        vif.AWBUSRT = 0 ;
	    vif.WDATA   = 0 ;
    	vif.WLAST   = 0 ;
    	vif.WVALID  = 0 ;
    	vif.WREADY  = 0 ;
        vif.BVALID  = 0 ;
        vif.BREADY  = 0 ;
        vif.TRANS_VALID = 0;
    endtask

    task run_phase (uvm_phase phase);
	wait(!vif.RESET);
        #5;
        vif.AWVALID = 1 ; // user-defined
        vif.WLAST   = 0 ;
        vif.TRANS_VALID <= 2'bxx ;
        seq_item_port.get_next_item(req);
        forever begin
            // AW -- It was ok
            
            if(vif.AWVALID) begin
                `uvm_info(get_type_name(),$sformatf("Processing push data into interface , still AWVALID"),UVM_HIGH);
                vif.AWADDR  = req.aw_addr   ;
                vif.AWLEN   = req.aw_len    ;
                vif.AWSIZE  = req.aw_size   ;
                vif.AWBUSRT = req.aw_burst  ;
            end

            @(posedge vif.CLK);
            if(vif.AWVALID) begin
                `uvm_info(get_type_name(),$sformatf("Processing AWADDR, still AWVALID"),UVM_HIGH);
                if(!vif.AWREADY) 
                    vif.AWVALID <= 1 ;
                else begin
                    vif.AWVALID <= 0 ;
                    vif.WDATA  <= {req.w_data[counter][3:0],12'b0,req.aw_addr} ;
                    vif.WVALID <= 1 ;
                    counter ++ ;
                end
            end

            // Process write data -- ok
            if(vif.WREADY && !vif.WLAST) begin
                `uvm_info(get_type_name(),$sformatf("Processing WREADY but not WLAST"),UVM_HIGH);
                vif.WVALID <= 1 ; // not optimize
            end
        
            if(vif.WVALID) begin
                
                `uvm_info(get_type_name(),$sformatf("Processing WDATA, still WVALID"),UVM_HIGH);
                vif.WDATA = {req.w_data[counter][3:0],12'b0,req.aw_addr} ;
                // Counter Process
                if (counter == vif.AWLEN) begin
                    `uvm_info(get_type_name(),$sformatf("Processing counter = AWLEN, counter = %0d",counter),UVM_HIGH);
                    counter = 0 ;
                    vif.WLAST <= 1 ;
                    vif.WDATA = {req.w_data[counter][3:0],12'b0,req.aw_addr} ;
                end else if(counter >= 1) begin
                    `uvm_info(get_type_name(),$sformatf("Processing counter != AWLEN, counter = %0d",counter),UVM_HIGH);
                    counter ++ ;
                    vif.WLAST <= 0 ;
                end
            end

            if(vif.WLAST) begin
                `uvm_info(get_type_name(),$sformatf("Processing WLAST"),UVM_HIGH);
                vif.WVALID <= 0 ;
                vif.WLAST  <= 0 ;
            end 

            // Process respond -- ok
            if(vif.WLAST) vif.BREADY = 1   ;
            //if(vif.WREADY && vif.BVALID) vif.BREADY <= 0  ;
            
            if(vif.BRESP == `OK && vif.BVALID) begin
                `uvm_info(get_type_name(),$sformatf("Processing RES"),UVM_HIGH)
                seq_item_port.item_done() ;
                vif.BREADY <= 0  ;
                // additions
                vif.AWVALID <= 1 ;
                seq_item_port.get_next_item(req);
            end else begin
                vif.BREADY <= 1 ; 
            end
            
        end
    endtask 
endclass //driver extends uvm_driver

`endif