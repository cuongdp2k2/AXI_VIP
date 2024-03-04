`include "package.sv"

`include "interface.sv"
`include "base_env.sv"
module top;
    bit clk   ;
    bit reset ;
    // bit [31:0] data ;
    // bit [15:0] addr ;
 
    
    // data = vif.WDATA ;
    // addr = vif.AWADDR ;
    always #2 clk = ~clk ;

    axi_write_if vif (clk,reset);
    initial begin
        vif.AWREADY = 0 ;
        vif.AWVALID = 0 ;
        clk = 0 ;
        #0 reset = 1 ;
        #5; reset = 0 ;
    end

    dut DUT (
        .CLK    (vif.CLK)     ,
        .RESET  (vif.RESET)   ,
        .AWADDR (vif.AWADDR ) ,
        .AWLEN  (vif.AWLEN  ) ,
        .AWSIZE (vif.AWSIZE ) ,
        .AWBUSRT(vif.AWBUSRT) ,
        .AWVALID(vif.AWVALID) ,
        .AWREADY(vif.AWREADY) ,
        .WDATA  (vif.WDATA  ) ,
        .WLAST  (vif.WLAST  ) ,
        .WVALID (vif.WVALID ) ,
        .WREADY (vif.WREADY ) ,
        .BRESP  (vif.BRESP  ) ,
        .BVALID (vif.BVALID ) ,
        .BREADY (vif.BREADY ) 
    );

    initial begin
    // set interface in config_db
    uvm_config_db#(virtual axi_write_if)::set(uvm_root::get(), "", "vif", vif);
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0);
    end

    initial begin
        run_test("base_env");
    end
endmodule