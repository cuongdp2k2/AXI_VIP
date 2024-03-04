interface axi_write_if ( input logic CLK , RESET );
    // AW ---------------------------
    logic [15:0] AWADDR     ;
    logic [7:0]  AWLEN      ;
    logic [2:0]  AWSIZE     ;
    logic [1:0]  AWBUSRT    ;
    logic        AWVALID    ;
    logic        AWREADY    ;
    // W -----------------------------
    logic [31:0] WDATA  ;
    logic        WLAST  ;
    logic        WVALID ;
    logic        WREADY ;
    // B -----------------------------
    logic [1:0]  BRESP  ;
    logic        BVALID ;
    logic        BREADY ;

    // Checking signal
    logic [1:0]  TRANS_VALID ;
endinterface