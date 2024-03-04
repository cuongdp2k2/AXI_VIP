`ifndef CONSTANTS_SV
`define CONSTANTS_SV 

//RRESP[1:0] , BRESP[1:0]
`define OK          2'b00 
`define EXOK        2'b01 
`define SLVERR      2'b10 
`define DECERR      2'b11

// AxBURST[1:0]
`define FIXED       2'b00 
`define INCR        2'b01
`define WRAP        2'b10

`define PASS        1'b1 
`define FAIL        1'b0

`endif 