`timescale 1ns / 1ps

module ALU_tb;
    reg [31:0] A, B;
    reg [3:0] AluCtl;
    wire [31:0] Result;
    wire Zero, Gt;
    wire [31:0] hi, lo;
    ALU uut (
        .A(A),
        .B(B),
        .AluCtl(AluCtl),
        .Result(Result),
        .Zero(Zero),
        .Gt(Gt),
        .hi(hi),
        .lo(lo)
    );

    integer i;

    initial begin
        $display("Time\tCtl\tA\t\tB\t\tResult\t\tZero\tGt\tHi\t\tLo");

        // Initialize A and B to sample values
        A = 32'd20;
        B = 32'd5;
$monitor("%0dns\t%d\t%h\t%h\t%h\t%b\t%b\t%h\t%h",
                     $time, AluCtl, A, B, Result, Zero, Gt, hi, lo);
        // Loop through all ALU control values
//        for (i = 13; i < 32; i = i + 1) begin
//            AluCtl = i;
//            #20;
//            $display("%0dns\t%d\t%h\t%h\t%h\t%b\t%b\t%h\t%h",
//                     $time, AluCtl, A, B, Result, Zero, Gt, hi, lo);
//        end
//        A = -32'd20;
//        B = 32'd1;

//        // Loop through all ALU control values
//        for (i = 13; i < 32; i = i + 1) begin
//            AluCtl = i;
//            #20;
//            $display("%0dns\t%d\t%h\t%h\t%h\t%b\t%b\t%h\t%h",
//                     $time, AluCtl, A, B, Result, Zero, Gt, hi, lo);
//        end
            #20;
            AluCtl = 4'd13;
            
                     #20;
            AluCtl = 4'd14;
//            $display("%0dns\t%d\t%h\t%h\t%h\t%b\t%b\t%h\t%h",
//                     $time, AluCtl, A, B, Result, Zero, Gt, hi, lo);
                     #20;
            AluCtl = 4'd15;
//            $display("%0dns\t%d\t%h\t%h\t%h\t%b\t%b\t%h\t%h",
//                     $time, AluCtl, A, B, Result, Zero, Gt, hi, lo);
                     #20;
            A = -32'd20;
            B = 32'd1;
            #20;
            AluCtl = 4'd0;
            #20;
            AluCtl = 4'd1;
           
                     #20;
            AluCtl = 4'd2;
                     #20;
            AluCtl = 4'd3;
                     #20;#20;
            AluCtl = 4'd4;
                     #20;
            AluCtl = 4'd5;
                     #20;
            AluCtl = 4'd6;
                     #20;#20;
            AluCtl = 4'd7;
                     #20;
            AluCtl = 4'd8;
                     #20;
            AluCtl = 4'd9;
                     #20;#20;
            AluCtl = 4'd10;
                     #20;
            AluCtl = 4'd11;
                     #20;
            AluCtl = 4'd12;
                     #20;#20;
            AluCtl = 4'd13;
                     #20;
            AluCtl = 4'd14;
                     #20;
            AluCtl = 4'd15;
                     #20;
                     
    end
endmodule
