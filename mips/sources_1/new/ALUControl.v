`timescale 1ns / 1ps

module ALUControl(
    input [3:0] AluOp,
    input [5:0] funct,
    output reg [3:0] AluCtl, 
    output reg hilo_enable,
    output reg shift
);
// output 1 shift signal also. if shift, then A = rs, B = shamt, result in rd


    always@(*) begin
        hilo_enable = 0;
        AluCtl = 0;
        shift = 0;
        if (AluOp == 0) begin // R
        case (funct) 
            4'd0: begin
            AluCtl <= 4'd0; hilo_enable <= 0;
            end
            4'd1: begin
            AluCtl <= 4'd2; hilo_enable <= 0;
            end
            4'd2: begin
            AluCtl <= 4'd1; hilo_enable <= 0;
            end
            4'd3: begin
            AluCtl <= 4'd3; hilo_enable <= 0;
            end
            4'd4: begin
            AluCtl <= 4'd14; hilo_enable <= 1;
            end
            4'd5: begin
            AluCtl <= 4'd15; hilo_enable <= 1;
            end
            4'd6: begin
            AluCtl <= 4'd13; hilo_enable <= 1;
            end
            4'd7: begin
            AluCtl <= 4'd4; hilo_enable <= 0;
            end
            4'd8: begin
            AluCtl <= 4'd5; hilo_enable <= 0;
            end
            4'd9: begin
            AluCtl <= 4'd6; hilo_enable <= 0;
            end
            4'd10: begin
            AluCtl <= 4'd7; hilo_enable <= 0;
            end
            4'd11: begin
            AluCtl <= 4'd11; hilo_enable <= 0;
            end
            4'd12: begin
            AluCtl <= 4'd8; hilo_enable <= 0; shift = 1;
            end
            4'd13: begin
            AluCtl <= 4'd9; hilo_enable <= 0; shift = 1;
            end
            4'd14: begin
            AluCtl <= 4'd8; hilo_enable <= 0; shift = 1;
            end
            4'd15: begin
            AluCtl <= 4'd10; hilo_enable <= 0; shift = 1;
            end
        endcase
        end else begin
            case (AluOp) 
            4'd1: begin // and
                AluCtl <= 4'd4; hilo_enable = 1'd0;
            end
            4'd2: begin // add
            AluCtl <= 4'd0; hilo_enable = 1'd0;
            end
            4'd3: begin // addu
            AluCtl <= 4'd1; hilo_enable = 1'd0;
            end
            4'd4: begin // sub
            AluCtl <= 4'd2; hilo_enable = 1'd0;
            end
            4'd5: begin // subu
            AluCtl <= 4'd3; hilo_enable = 1'd0;
            end
            4'd6: begin // or
            AluCtl <= 4'd5; hilo_enable = 1'd0;
            end
            4'd7:  begin // xor
            AluCtl <= 4'd7; hilo_enable = 1'd0;
            end
            4'd8: begin // seq
            AluCtl <= 4'd12; hilo_enable = 1'd0;
            end
            4'd9: begin // slt
            AluCtl <= 4'd11; hilo_enable = 1'd0;
            end
            endcase
        end
    end
    
endmodule
