`include "package.sv"

`include "AR_interface.sv"
`include "R_interface.sv"
`include "base_env.sv"
module top;
    bit clk   ;
    bit reset ;

    AR_IF ar_vif(clk,reset) ;
    R_IF  r_vif (clk,reset) ;

    always #2 clk = ~clk ;

    initial begin
        clk = 0 ;
        #15 reset = 1 ;
        #5; reset = 0 ;
    end

    initial begin
    // set interface in config_db
    uvm_config_db#(virtual AR_IF)::set(uvm_root::get(), "", "ar_vif", ar_vif);
    uvm_config_db#(virtual R_IF)::set(uvm_root::get(), "", "r_vif", r_vif);
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0);
    end

    initial begin
        run_test("base_env");
    end
endmodule