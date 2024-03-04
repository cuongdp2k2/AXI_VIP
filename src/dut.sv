module dut (
    // AW ---------------------------
    input logic        CLK        ,
    input logic        RESET      ,
    input logic [15:0] AWADDR     ,
    input logic [7:0]  AWLEN      ,
    input logic [2:0]  AWSIZE     ,
    input logic [1:0]  AWBUSRT    ,
    input logic        AWVALID    ,
    input logic        AWREADY    ,
    //input // W -----------------------------
    input logic [31:0] WDATA  ,
    input logic        WLAST  ,
    input logic        WVALID ,
    input logic        WREADY ,
    //input // B ----------------------------
    input logic [1:0]  BRESP  ,
    input logic        BVALID ,
    input logic        BREADY ,

    input logic [1:0]  TRANS_VALID ,

    // AW ---------------------------
    output logic [15:0] out_AWADDR     ,
    output logic [7:0]  out_AWLEN      ,
    output logic [2:0]  out_AWSIZE     ,
    output logic [1:0]  out_AWBUSRT    ,
    output logic        out_AWVALID    ,
    output logic        out_AWREADY    ,
    //output // W --------out_---------------------
    output logic [31:0] out_WDATA  ,
    output logic        out_WLAST  ,
    output logic        out_WVALID ,
    output logic        out_WREADY ,
    //output // B --------out_--------------------
    output logic [1:0]  out_BRESP  ,
    output logic        out_BVALID ,    
    output logic        out_BREADY 
);
    always_comb begin : assign_block
        out_AWADDR  = AWADDR  ;
        out_AWLEN   = AWLEN   ;
        out_AWSIZE  = AWSIZE  ;
        out_AWBUSRT = AWBUSRT ;
        out_AWVALID = AWVALID ;
        out_AWREADY = AWREADY ;
        out_WDATA   = WDATA   ;
        out_WLAST   = WLAST   ;
        out_WVALID  = WVALID  ;
        out_WREADY  = WREADY  ;
        out_BRESP   = BRESP   ;
        out_BVALID  = BVALID  ;
        out_BREADY  = BREADY  ;
    end
endmodule