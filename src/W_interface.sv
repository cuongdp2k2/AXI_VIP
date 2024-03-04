interface W_IF(input CLK , RESET);
    logic [31:0] WDATA  ;
    //logic [1:0]  WRESP  ;
    logic        WLAST  ;
    logic        WVALID ;
    logic        WREADY ;
endinterface //W_IF