`timescale 1ns / 1ps

module processor(
    input         clk,
    input         rst,
    input  [9:0]  init_pc,
    input         instr_we,
    input  [31:0] instr_feed,
    input [9:0] instr_write_address,

//    output [9:0]  pc,                     // current program counter
//    output [31:0] instr,                 // current instruction

    // General register file

    output [31:0] write_data,
    output [4:0]  write_reg,

    // Floating point register file

//    // Control

//    // ALU and memory

    output [31:0] hi,
    output [31:0] lo

//    // Immediate

);
    wire [9:0]  pc;                  // current program counter
    wire [31:0] instr;
wire [4:0] ra_address = 5'd5; // changeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
    wire [31:0] write_data;
    wire [4:0]  write_reg;
    wire [31:0] general_reg_read1_out;
    wire [31:0] general_reg_read2_out;
    wire [31:0] general_final_read2_out;
    wire [31:0] MemOut;
    wire        Zero;
    wire        Gt;
    wire [31:0] Result;
    wire [31:0] sign_extended_imm;
    wire        AluSrc;
    wire [3:0]  AluOp;
    wire [1:0]  RegDst;
    wire [1:0]  MemtoReg;
    wire        MemWrite;
    wire        Branch;
    wire        Jump;
    wire [2:0]  BranchOp;
    wire        Branch_final;
    wire        hilo_enable;
    wire [31:0] float_reg_read1_out;
    wire [31:0] float_reg_read2_out;
    wire        FloatRegWrite;
    wire        FloatEnable;
    wire        FloatZero;
    wire        FloatGt;
    wire [31:0] FloatResult;
    wire        GeneralRegWrite;
    wire        GeneralZero;
    wire        GeneralGt;
    wire [31:0] GeneralResult;



// in case of immediate, used rt as the write destination.
BranchControl branch_control_inst(Branch, BranchOp, Zero, Gt, Branch_final);
//assign Branch_final = 0;


sign_extender imm_sign_extend(instr[9:0], sign_extended_imm);
//assign sign_extended_imm = 0;


PC pc_inst(clk, rst, init_pc, sign_extended_imm, Branch, Branch_final, Jump, general_reg_read1_out[9:0], sign_extended_imm[9:0], Zero, pc);
//assign pc = 0;

     
// need to rst first and then updates automatically. updates on negedge.

instruction_memory_wrapper instr_mem_inst(.dpra(pc), .clk(clk), .dpo(instr), .we(instr_we), .d(instr_feed), .a(instr_write_address));
// at each posedge, instr gets fetched from the memory according to the pc.



memory_wrapper data_mem_inst(.a(Result[11:0]), .d(general_reg_read2_out), .dpra(Result[11:0]), .clk(clk), .we(MemWrite), .dpo(MemOut));
// read address - dpra, wire uska dpo. we - write enable, a - write address, d - write data

ControlUnit control_inst(instr[31:26], AluSrc,FloatRegWrite, GeneralRegWrite, MemWrite, Branch, Jump, FloatEnable, RegDst, MemtoReg, BranchOp, AluOp);
// control unit pending
//assign AluSrc = 0;
//       assign FloatRegWrite = 0;
//       assign GeneralRegWrite = 0;
//       assign MemWrite = 0;
//       assign Branch = 0;
//       assign Jump = 0;
//       assign FloatEnable = 0;
//       assign RegDst = 2'b01;
//       assign MemtoReg = 0;
//       assign BranchOp = 0;
//       assign AluOp = 0;

//module ControlUnit(
//    input [5:0] opcode,
//    wire reg AluSrc,FloatRegWrite, GeneralRegWrite, MemWrite, Branch, Jump, FloatEnable,
//    wire reg [1:0] RegDst, MemtoReg,
//    wire reg [2:0] BranchOp,
//    wire reg [3:0] AluOp
//);
// for reference
wire [3:0] AluCtl;
wire shift;
ALUControl generalaluctrl(AluOp, instr[5:0], AluCtl, hilo_enable, shift);
//assign AluCtl = 0; assign hilo_enable = 0;


mux4_1 mux_memtoreginst(MemtoReg, Result, MemOut, {22'b0, pc + 10'd1}, {instr[15:0], 16'b0}, write_data);
//assign write_data = 0;
mux4_1 #(.W(5)) inst1(RegDst, instr[20:16], instr[15:11], ra_address, 5'd0, write_reg);
//assign write_reg = 0;


wire [31:0] shift_or_gen_final_read2_out;
assign general_final_read2_out = (AluSrc)? sign_extended_imm : general_reg_read2_out;
assign shift_or_gen_final_read2_out = (shift)? {27'd0, instr[10:6]} : general_final_read2_out;
ALU alu_inst( general_reg_read1_out, shift_or_gen_final_read2_out, AluCtl, GeneralResult, GeneralZero, GeneralGt, hi, lo);
//assign GeneralResult = 0; assign GeneralZero = 1; assign hi = 0; assign lo = 0;
FPU fpu_inst( float_reg_read1_out, float_reg_read2_out, AluOp, FloatResult, FloatZero, FloatGt);
//assign FloatResult = 0;
//assign FloatZero = 0;
//assign FloatGt = 0;



assign Zero = (FloatEnable)? FloatZero : GeneralZero;
assign Result = (FloatEnable)? FloatResult : GeneralResult;
assign Gt = (FloatEnable)? FloatGt : GeneralGt;

register_file general_registers(clk, instr[25:21], instr[20:16], write_reg, write_data, GeneralRegWrite & ~hilo_enable, general_reg_read1_out, general_reg_read2_out);
// if hilo_enable is on, then dont write in the register in reg file.

register_file floating_registers(clk, instr[25:21], instr[20:16], write_reg, write_data, FloatRegWrite, float_reg_read1_out, float_reg_read2_out);


endmodule
