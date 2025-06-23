`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 09:40:47 PM
// Design Name: 
// Module Name: mux4_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4_1(sel, one, two, three, four, out);
    parameter W = 32;
    input [1:0] sel;
    input [W-1:0] one, two, three, four;
    output [W-1:0] out;
    assign out = (sel[0])? ((sel[1])? four : two) : ((sel[1])? three : one);
endmodule
