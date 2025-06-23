`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 07:48:35 PM
// Design Name: 
// Module Name: BranchControl
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


module BranchControl(input Branch, input [2:0] BranchOp, input Zero, input Gt, output final_wire);
reg Branch_final;

initial begin
Branch_final = 0;
end

// applying inverse of all operations here on each bcoz in all intermediate commands, rt is the first argument and rs is the second argument
// while in branching, rs is the first argument and rt is the second.

assign final_wire = Branch_final & Branch;
always @(*) begin
    case (BranchOp) 
        3'd0: begin // beq
            Branch_final = Zero;
        end
        3'd1: begin // bne
            Branch_final = ~Zero;
        end
        3'd2: begin // bgt
//            Branch_final = Gt;
              Branch_final = ~Gt & ~Zero;
        end
        3'd3: begin // bgte
//            Branch_final = Gt | Zero;
              Branch_final = ~Gt | Zero;
        end
        3'd4: begin // ble
            Branch_final = Gt & ~Zero;
        end
        3'd5: begin // bleq
            Branch_final = Gt | Zero;
        end
        3'd6: begin // bleu
            Branch_final = Gt & ~Zero;
        end
        3'd7: begin // bgtu
//            Branch_final = Gt;
              Branch_final = ~Gt & ~Zero;
        end
         default: Branch_final = 1'b0;
    endcase
    Branch_final = (Branch_final === 1'bx)? 0 : Branch_final;
end

endmodule
