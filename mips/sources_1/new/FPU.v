`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 11:32:53 PM
// Design Name: 
// Module Name: FPU
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


module FPU(
    input [31:0] A, B,
    input [3:0] AluOp,
    output reg [31:0] Result,
    output reg Zero, Gt
    );
     wire c_out;
   wire [31:0] less,greater,equal,sum_out1,sum_out2,sub_out; 
   float_comparator comp_inst(A,B,less,greater,equal);
   float_add float_add_inst1(A,B,sum_out1,c_out);
   float_add float_add_inst2(A,32'd0,sum_out2,c_out);
   float_add float_add_inst3(A, {~B[31],B[30:0]},sub_out,c_out);
   
    always @(*) begin
        case (AluOp) 
        4'd2: // add
        begin
        Result <= sum_out1;
        end
        4'd4: // sub
        begin
        Result <= sub_out;
        end
        4'd8: // c.eq.s
        begin
        Result <= equal;
        end
        4'd9: // c.lt.s
        begin
        Result <= less;
        end
        4'd10: // c.gt.s
        begin
        Result <= greater;
        end
        4'd11: // c.ge.s
        begin
        Result <= greater || equal;
        end
        4'd13: // c.le.s
        begin
        Result <= less || equal;
        end
        endcase
        Zero = equal;
        Gt = greater;
    end
    
endmodule

module float_comparator(
    input[31:0] A, B,
    output reg [31:0] less,greater,equal
);

always@(*) begin
                if(A[31] > B[31]) begin
                    less <= 32'd1;
                    greater <= 32'b0;
                    equal <= 32'b0;
                end
                else if(A[31] < B[31]) begin
                    less <= 32'd0;
                    greater <= 32'b1;
                    equal <= 32'b0;
                end
                else begin
                    if(A[30:23] < B[30:23]) begin
                        less <= 32'd1;
                        greater <= 32'b0;
                        equal <= 32'b0;
                    end
                    else if(A[30:23] > B[30:23]) begin
                        less <= 32'd0;
                        greater <= 32'b1;
                        equal <= 32'b0;
                    end
                    else begin
                        if(A[22:0] < B[22:0]) begin
                            less <= 32'd1;
                            greater <= 32'b0;
                            equal <= 32'b0;
                        end
                        else if(A[22:0] > B[22:0]) begin
                            less <= 32'd0;
                            greater <= 32'b1;
                            equal <= 32'b0;
                        end
                        else begin
                            less <= 32'd0;
                            greater <= 32'b0;
                            equal <= 32'b1;
                        end
                    end
                end
             end

    
endmodule
module float_add(
    input  [31:0] a,
    input  [31:0] b,
    output reg [31:0] sum,
    output reg        c_overflow
);

    // Extract fields
    wire       a_sign     = a[31];
    wire       b_sign     = b[31];
    wire [7:0] a_exp      = a[30:23];
    wire [7:0] b_exp      = b[30:23];
    wire [22:0] a_mant    = a[22:0];
    wire [22:0] b_mant    = b[22:0];

    // Detect pure zero (exponent=0 and mantissa=0)
    wire a_is_zero = (a[30:0] == 31'b0);
    wire b_is_zero = (b[30:0] == 31'b0);

    // Full mantissas with implicit leading 1
    reg  [23:0] fa, fb;
    reg  [8:0]  exp_diff;
    reg  [7:0]  result_exp;
    reg  [24:0] tmp;

    always @(*) begin
        // 1) Zero shortcuts
        if (a_is_zero) begin
            sum        = b;
            c_overflow = 1'b0;
        end
        else if (b_is_zero) begin
            sum        = a;
            c_overflow = 1'b0;
        end
        else begin
            c_overflow = 1'b0;

            // 2) Align mantissas
            if (a_exp > b_exp) begin
                exp_diff   = a_exp - b_exp;
                result_exp = a_exp;
                fa         = {1'b1, a_mant};
                fb         = {1'b1, b_mant} >> exp_diff;
            end else begin
                exp_diff   = b_exp - a_exp;
                result_exp = b_exp;
                fa         = {1'b1, a_mant} >> exp_diff;
                fb         = {1'b1, b_mant};
            end

            // 3) Add/Sub based on sign
            if (a_sign == b_sign) begin
                tmp = fa + fb;
                // handle carry out
                {c_overflow, sum[30:23]} = result_exp + tmp[24];
                sum[22:0]                = tmp[23:1];
                sum[31]                  = a_sign;
            end else begin
                tmp = fa - fb;
                sum[31] = (tmp[24] == 1) ? b_sign : a_sign;
                // make magnitude positive
                if (tmp[24]) tmp[23:0] = -tmp[23:0];
                // normalized subtraction
                if (tmp[23:0] == 24'b0) begin
                    sum[30:0] = 31'b0;
                end else begin
                    // normalize leading one
                    while (tmp[23] == 1'b0) begin
                        tmp        = tmp << 1;
                        result_exp = result_exp - 1;
                    end
                    sum[22:0]  = tmp[22:0];
                    sum[30:23]= result_exp;
                end
            end

            // 4) Check for overflow to infinity
            if (c_overflow) begin
                sum[31]   = a_sign;
                sum[30:23]= 8'hFF;
                sum[22:0] = 23'b0;
            end
        end
    end

endmodule
