interface AW_IF (input CLK , RESET);
    logic [15:0] AWADDR     ;
    logic [7:0]  AWLEN      ;
    logic [2:0]  AWSIZE     ;
    logic [1:0]  AWBUSRT    ;
    logic        AWVALID    ;
    logic        AWREADY    ;
endinterface //AR_IF