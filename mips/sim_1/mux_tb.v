`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2025 03:22:16 PM
// Design Name: 
// Module Name: mux_tb
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


`timescale 1ns / 1ps

module mux_tb;
    parameter W = 32;

    reg [1:0] sel;
    reg [W-1:0] one, two, three, four;
    wire [W-1:0] out;

    mux4_1 #(W) uut (
        .sel(sel),
        .one(one),
        .two(two),
        .three(three),
        .four(four),
        .out(out)
    );

    initial begin
        // Initialize inputs
        one = 32'hAAAA_AAAA;
        two = 32'hBBBB_BBBB;
        three = 32'hCCCC_CCCC;
        four = 32'hDDDD_DDDD;

        // Test all sel values
        $display("Time\t sel\t out");
        sel = 2'b00; #10; $display("%0dns\t %b\t %h", $time, sel, out);
        sel = 2'b01; #10; $display("%0dns\t %b\t %h", $time, sel, out);
        sel = 2'b10; #10; $display("%0dns\t %b\t %h", $time, sel, out);
        sel = 2'b11; #10; $display("%0dns\t %b\t %h", $time, sel, out);

        // Finish simulation
        $finish;
    end
endmodule
