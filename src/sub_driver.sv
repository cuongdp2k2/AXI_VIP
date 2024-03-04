`include "package.sv"
`include "const_param.sv"
class sub_driver extends uvm_driver;
    `uvm_component_utils(sub_driver);
    virtual axi_write_if vif ;

    function new(string name="sub_driver", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase) ;
        if(!uvm_config_db #(virtual axi_write_if)::get(this,"","vif",vif)) 
            `uvm_fatal(get_type_name(),"not set at top level");
    endfunction

    task run_phase (uvm_phase phase);
        forever begin
            @(posedge vif.CLK) ;
            // address - It was ok
            if(vif.AWREADY == 1 && vif.AWVALID == 1) 
                vif.AWREADY <= 0 ;
            else if(vif.AWVALID) begin
                vif.AWREADY <= 1 ;
                vif.WREADY  <= 1 ;
            end

             // data -- It was ok
             if(vif.WLAST) 
                vif.WREADY <= 0 ;
                    
            // respond -- ok
            if(vif.WLAST) begin
                @(posedge vif.CLK) ;
                vif.BVALID <= 1  ;
                if(vif.TRANS_VALID == `OK) 
                    vif.BRESP  <= `OK ;
                else
                    vif.BRESP <= `SLVERR ;
            end
            
            if(vif.BVALID) begin
                // @(negedge vif.CLK)
                // if(vif.TRANS_VALID == `OK)
                    vif.BRESP <= 2'bxx ;
                // else
                //     vif.BRESP <= `SLVERR; 
                vif.BVALID <= 0 ;
            end 
        end
    endtask
endclass