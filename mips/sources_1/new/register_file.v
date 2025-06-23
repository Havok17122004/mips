`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 02:29:41 PM
// Design Name: 
// Module Name: register_file
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

module register_file(
    input clk,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write,
    output [31:0] read_data1,
    output [31:0] read_data2
    );
    
    reg [31:0] register_file [0:31];
    
    assign read_data1 = register_file[read_reg1];
    assign read_data2 = register_file[read_reg2];
    always @(posedge clk) begin
        register_file[0] <= 32'b0; // Force register 0 to 0 at all times
        if (reg_write && write_reg != 5'd0) begin
            register_file[write_reg] <= write_data;
        end
        else begin
            register_file[write_reg] <= register_file[write_reg];
        end
    end
    
endmodule