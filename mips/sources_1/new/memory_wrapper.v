`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2025 03:13:41 PM
// Design Name: 
// Module Name: memory_wrapper
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


module memory_wrapper(
a, d, dpra, clk, we, dpo
    );
    // read address - dpra, output uska dpo. we - write enable, a - write address, d - write data
    input [11:0] a, dpra;
    input clk, we;
    output [31:0] dpo;
    input [31:0] d;

    dist_mem_gen_0 inst(
        .a(a),
        .d(d),
        .dpra(dpra),
        .clk(clk),
        .we(we),
        .dpo(dpo)
    );
endmodule 

