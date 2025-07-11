`timescale 1ns / 1ps

module tb1;

    // Clock, reset, and instruction-feed signals
    reg         clk       = 0;
    reg         rst       = 1;
    reg  [9:0]  init_pc   = 10'd0;
    reg         instr_we  = 0;
    reg  [31:0] instr_feed;
    reg [9:0] instr_write_address;
// Output wires from DUT
wire [9:0]  pc;
wire [31:0] instr;

//wire [31:0] general_reg_read1_out;
//wire [31:0] general_reg_read2_out;
//wire [31:0] general_final_read2_out;
// wire [31:0] write_data;
// wire [4:0]  write_reg;
//wire        GeneralRegWrite;
//wire        GeneralZero;
//wire        GeneralGt;
//wire [31:0] GeneralResult;

//wire [31:0] float_reg_read1_out;
//wire [31:0] float_reg_read2_out;
//wire        FloatRegWrite;
//wire        FloatEnable;
//wire        FloatZero;
//wire        FloatGt;
//wire [31:0] FloatResult;

//wire        AluSrc;
//wire [3:0]  AluOp;
//wire [1:0]  RegDst;
//wire [1:0]  MemtoReg;
//wire        MemWrite;
//wire        Branch;
//wire        Jump;
//wire [2:0]  BranchOp;
//wire        Branch_final;
//wire        hilo_enable;

//wire        Zero;
//wire        Gt;
//wire [31:0] Result;
wire End_signal;
wire Print;
wire [31:0] toBePrinted;

// Remove or comment out unused outputs
// wire [9:0]  pc;
// wire [31:0] instr;
// wire [31:0] write_data;
// wire [4:0]  write_reg;
// wire [31:0] hi;
// wire [31:0] lo;

processor uut(
    .clk(clk),
    .rst(rst),
    .init_pc(init_pc),
    .instr_we(instr_we),
    .instr_feed(instr_feed),
    .instr_write_address(instr_write_address),
    .End_signal(End_signal),
    .Print(Print),
    .toBePrinted(toBePrinted)
);

    // DUT instantiation
//processor uut (
//    // Inputs
//    .clk(clk),
//    .rst(rst),
//    .init_pc(init_pc),
//    .instr_we(instr_we),
//    .instr_feed(instr_feed),
//    .instr_write_address(instr_write_address),
//    // Outputs
//    .pc(pc),
//    .instr(instr),
//    .general_reg_read1_out(general_reg_read1_out),
//    .general_reg_read2_out(general_reg_read2_out),
//    .general_final_read2_out(general_final_read2_out),
//    .write_data(write_data),
//    .write_reg(write_reg),
//    .GeneralRegWrite(GeneralRegWrite),
//    .GeneralZero(GeneralZero),
//    .GeneralGt(GeneralGt),
//    .GeneralResult(GeneralResult),

//    .float_reg_read1_out(float_reg_read1_out),
//    .float_reg_read2_out(float_reg_read2_out),
//    .FloatRegWrite(FloatRegWrite),
//    .FloatEnable(FloatEnable),
//    .FloatZero(FloatZero),
//    .FloatGt(FloatGt),
//    .FloatResult(FloatResult),

//    .AluSrc(AluSrc),
//    .AluOp(AluOp),
//    .RegDst(RegDst),
//    .MemtoReg(MemtoReg),
//    .MemWrite(MemWrite),
//    .Branch(Branch),
//    .Jump(Jump),
//    .BranchOp(BranchOp),
//    .Branch_final(Branch_final),
//    .hilo_enable(hilo_enable),

//    .Zero(Zero),
//    .Gt(Gt),
//    .Result(Result),
//    .hi(hi),
//    .lo(lo),
//    .MemOut(MemOut),

//    .sign_extended_imm(sign_extended_imm)
//);


    // Clock: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    // Memory to hold the binary instructions
    reg [31:0] instructions [0:255];
    integer i;
    integer num_instr = 60; // Update this based on your machine_code.txt
//    initial begin
//        $display("Time | PC | Instr | ALU Result | GeneralWrite | FloatWrite | WriteData | WriteReg | Read1Out | Read2Out");
//        $monitor("%4dns | %d | %h | %h | %b | %b", 
//                 $time, pc, instr, Result, GeneralRegWrite, FloatRegWrite, write_data, write_reg, general_reg_read1_out, general_final_read2_out);
//    end

//    initial begin
//        $display("Time   clk  rst  init_pc  instr_we  instr_feed (binary / hex)");
//        $monitor("%4dns   %b    %b    %3d       %b      %032b / 0x%08h",
//                 $time, clk, rst, init_pc, instr_we, instr_feed, instr_feed);
//    end
    always @(posedge clk) begin
        if (Print)
            $display("[%0dns] toBePrinted = 0x%08h (%0d)", $time, toBePrinted, toBePrinted);
        if (End_signal)
            $finish;
    end

    initial begin
        $display("\n================== Simulation Start ==================");
        $display("Reading instructions from machine_code.txt...");

        // 1) Load instructions
        $readmemb("machine_code.txt", instructions);

        // 2) Assert reset for a short time
        #10 rst = 0;
        $display("[%0dns] Reset deasserted. Starting instruction feed.\n", $time);

        // 3) Feed each instruction
        for (i = 0; i < num_instr; i = i + 1) begin
            instr_feed = instructions[i];
            instr_we   = 1;
            instr_write_address = i;
            $display("[%0dns] Feeding instruction %0d: %032b (0x%08h)", $time, i, instr_feed, instr_feed);
            #10;
        end

        instr_we = 0;
        rst = 1;
        #20 rst = 0;
        $display("\n[%0dns] Instruction feed complete. Processor running...\n", $time);

        // 4) Let the processor run
        repeat (100) #10;

        $display("\n================== Simulation End ==================\n");
//        $finish;
    end

    // Continuous signal monitoring
    

endmodule
