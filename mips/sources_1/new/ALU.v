`timescale 1ns / 1ps

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] AluCtl,
    output reg [31:0] Result,
    // output reg Zero, Gt,
    output reg [31:0] hi, lo
);
reg [63:0] temp;


always@(*) begin
    temp = 0;
    Result = 0;
    // Zero = 1;
    // Gt = 0;
    case(AluCtl)
        4'd0: Result = $signed(A) + $signed(B); //add
        4'd1: Result = $unsigned(A) + $unsigned(B); //addu
        4'd2: Result = $signed(A) - $signed(B); // sub
        4'd3: Result = $unsigned(A) - $unsigned(B); // subu
        4'd4: Result = A & B; // and
        4'd5: Result = A | B; // or
        4'd6: Result = ~A; // not
        4'd7: Result = A ^ B; // a xor b
        4'b1000: Result = A << B; //sll
        4'b1001: Result =$unsigned(A) >> B; //srl
        4'b1010: Result = $signed(A) >>> B; // sra
        4'b1011: Result = ($signed(A) < $signed(B)) ? 32'd1:32'd0; // slt
        4'b1100: Result = (A == B)? 32'd1:32'd0; // seq
        4'b1101: begin 
            temp = A * B;    //mul
            hi = temp[63:32];
            lo = temp[31:0];
           end
        4'b1110: begin // madd
            temp = $signed(A) * $signed(B);
            hi = $signed(hi) + $signed(temp[63:32]);
            lo = $signed(lo) + $signed(temp[31:0]);
           end
        4'b1111: begin // maddu
            temp = $unsigned(A) * $unsigned(B);
            hi = hi + temp[63:32];
            lo = lo + temp[31:0];
           end        
        default : Result = 32'd0;
    endcase
    // Zero = ($signed(Result) == 0);
    // Gt = ($signed(Result) > 0);
end

endmodule