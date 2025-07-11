`timescale 1ns / 1ps

module processor(
    input         clk,
    input         rst,
    input  [9:0]  init_pc,
    input         instr_we,
    input  [31:0] instr_feed,
    input [9:0] instr_write_address,
    // output [31:0] write_data,
    // output [4:0]  write_reg,
    // output [31:0] hi,
    // output [31:0] lo,
    output End_signal,
    output Print, 
    output [31:0] toBePrinted
);
    wire [31:0] write_data,
    wire [4:0]  write_reg,
    wire [31:0] hi,
    wire [31:0] lo,
    wire [9:0]  pc; 
    wire [31:0] instr;
    wire [4:0] ra_address = 5'd5;
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
wire ControlUnitRst;
wire MemRead;

reg [9:0] pc_if_id;
reg [31:0] instr_if_id;
wire pc_WE;

initial begin
    pc_if_id = 0;
end

PC pc_inst(clk, rst, init_pc, sign_extended_imm, Branch, Branch_final, Jump, general_reg_read1_out[9:0], instr_if_id[9:0], pc_WE, pc_if_id, pc);
// BUG: (possible) wrong jump/branch address might be done. Because it doesnt use the pipelined registers.
//assign pc = 0;

     
// need to rst first and then updates automatically. updates on negedge.
instruction_memory_wrapper instr_mem_inst(.dpra(pc), .clk(clk), .dpo(instr), .we(instr_we), .d(instr_feed), .a(instr_write_address));
// at each posedge, instr gets fetched from the memory according to the pc.

wire WE_if_id, flush_if_id;
assign flush_if_id = Jump | Branch_final;
always @(posedge clk or posedge flush_if_id) begin
    if(WE_if_id) begin
        if (flush_if_id) begin
            instr_if_id <= 32'd0;
        end else begin
            pc_if_id <= pc+10'd1;
            instr_if_id <= instr;
        end
    end
end


sign_extender imm_sign_extend(instr_if_id[9:0], sign_extended_imm);
//assign sign_extended_imm = 0;

// in case of immediate, used rt as the write destination.
BranchControl branch_control_inst(Branch, BranchOp, Zero, Gt, Branch_final);
//assign Branch_final = 0;


register_file general_registers(clk, instr_if_id[25:21], instr_if_id[20:16], write_reg_MEM_WB, write_data_MEM_WB, GeneralRegWrite_MEM_WB & ~hilo_enable_MEM_WB, general_reg_read1_out, general_reg_read2_out);
// if hilo_enable is on, then dont write in the register in reg file.

register_file floating_registers(clk, instr_if_id[25:21], instr_if_id[20:16], write_reg_MEM_WB, write_data_MEM_WB, FloatRegWrite_MEM_WB, float_reg_read1_out, float_reg_read2_out);


ControlUnit control_inst(ControlUnitRst | !(|instr_if_id), instr_if_id[31:26], AluSrc,FloatRegWrite, GeneralRegWrite, MemWrite, Branch, Jump, FloatEnable, MemRead, RegDst, MemtoReg, BranchOp, AluOp, End_signal, Print);
// TODO: Ensure that NOP commands work as intended. 

assign toBePrinted = (Print) ? (FloatEnable ? float_reg_read1_out : general_reg_read1_out) : 32'd0;

wire [3:0] AluCtl;
wire shift;
ALUControl generalaluctrl(AluOp, instr_if_id[5:0], AluCtl, hilo_enable, shift);
//assign AluCtl = 0; assign hilo_enable = 0;

mux4_1 #(.W(5)) inst1(RegDst, instr_if_id[20:16], instr_if_id[15:11], ra_address, 5'd0, write_reg);
//assign write_reg = 0;

assign Zero = Branch ? (general_reg_read1_out == general_reg_read2_out) : 1'b0;
assign Gt   = Branch ? (general_reg_read1_out >  general_reg_read2_out) : 1'b0;

reg [31:0] general_reg_read1_out_ID_EX, general_reg_read2_out_ID_EX, float_reg_read1_out_ID_EX, float_reg_read2_out_ID_EX;
reg [4:0] write_reg_ID_EX, rs_ID_EX, rt_ID_EX;
reg [31:0] offset_ID_EX;
reg        AluSrc_ID_EX, MemWrite_ID_EX, MemRead_ID_EX;
reg [1:0]  RegDst_ID_EX, MemtoReg_ID_EX;
reg [3:0]  AluCtl_ID_EX, AluOp_ID_EX; // remove AluOp from here later.
reg FloatRegWrite_ID_EX, hilo_enable_ID_EX, GeneralRegWrite_ID_EX;
reg shift_ID_EX, FloatEnable_ID_EX;
reg [9:0] pc_ID_EX; 

always @(posedge clk) begin
    general_reg_read1_out_ID_EX = general_reg_read1_out;
    general_reg_read2_out_ID_EX = general_reg_read2_out; FloatEnable_ID_EX = FloatEnable;
    float_reg_read1_out_ID_EX = float_reg_read1_out; AluOp_ID_EX = AluOp;
    float_reg_read2_out_ID_EX = float_reg_read2_out; shift_ID_EX = shift;
    write_reg_ID_EX = write_reg; offset_ID_EX = sign_extended_imm; AluSrc_ID_EX = AluSrc;
    MemWrite_ID_EX = MemWrite; RegDst_ID_EX = RegDst; MemtoReg_ID_EX = MemtoReg; AluCtl_ID_EX = AluCtl;
    FloatRegWrite_ID_EX = FloatRegWrite; hilo_enable_ID_EX = hilo_enable; GeneralRegWrite_ID_EX = GeneralRegWrite;
    pc_ID_EX = pc_if_id; rs_ID_EX = instr_if_id[25:21]; rt_ID_EX = instr_if_id[20:16]; MemRead_ID_EX = MemRead;
end

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


wire [31:0] shift_or_gen_final_read2_out;
assign general_final_read2_out = (AluSrc_ID_EX)? offset_ID_EX : general_reg_read2_out_ID_EX;
assign shift_or_gen_final_read2_out = (shift_ID_EX)? {27'd0, instr[10:6]} : general_final_read2_out;

hazard_handling_unit haz_handle_unit_inst(MemRead_ID_EX, write_reg_ID_EX, instr_if_id[25:21], instr_if_id[20:16], ControlUnitRst, pc_WE, WE_if_id);


wire [1:0] forwardA, forwardB;
wire [31:0] forwardResAg, forwardResBg, forwardResAf, forwardResBf;
forwarding_unit instancee(FloatRegWrite_MEM_WB, GeneralRegWrite_MEM_WB, write_reg_MEM_WB, GeneralRegWrite_EX_MEM, FloatRegWrite_EX_MEM, write_reg_EX_MEM, rs_ID_EX, rt_ID_EX, forwardA, forwardB);
mux4_1 mux_forwardAg(forwardA, general_reg_read1_out_ID_EX, Result_EX_MEM, write_data_MEM_WB, 32'd0, forwardResAg);
mux4_1 mux_forwardBg(forwardB, shift_or_gen_final_read2_out, Result_EX_MEM, write_data_MEM_WB, 32'd0, forwardResBg);
mux4_1 mux_forwardAf(forwardA, float_reg_read1_out_ID_EX, Result_EX_MEM, write_data_MEM_WB, 32'd0, forwardResAf);
mux4_1 mux_forwardBf(forwardB, float_reg_read2_out_ID_EX, Result_EX_MEM, write_data_MEM_WB, 32'd0, forwardResBf);


ALU alu_inst( forwardResAg, forwardResBg, AluCtl_ID_EX, GeneralResult, hi, lo);
//assign GeneralResult = 0; assign GeneralZero = 1; assign hi = 0; assign lo = 0;
FPU fpu_inst( forwardResAf, forwardResBf, AluOp_ID_EX, FloatResult); // want to use AluCtl
//assign FloatResult = 0;
//assign FloatZero = 0;
//assign FloatGt = 0;

// assign Zero = (FloatEnable_ID_EX)? FloatZero : GeneralZero;
assign Result = (FloatEnable_ID_EX)? FloatResult : GeneralResult;
// assign Gt = (FloatEnable_ID_EX)? FloatGt : GeneralGt;

reg [31:0] Result_EX_MEM, offset_EX_MEM, general_reg_read2_out_EX_MEM;
reg [4:0] write_reg_EX_MEM;
reg [9:0] pc_EX_MEM;
reg MemWrite_EX_MEM, FloatRegWrite_EX_MEM, hilo_enable_EX_MEM, GeneralRegWrite_EX_MEM;
reg [1:0] MemtoReg_EX_MEM;

always @(posedge clk) begin
    Result_EX_MEM = Result; offset_EX_MEM = offset_ID_EX;
    general_reg_read2_out_EX_MEM = general_reg_read2_out_ID_EX;
    write_reg_EX_MEM = write_reg_ID_EX; pc_EX_MEM = pc_ID_EX;
    MemWrite_EX_MEM = MemWrite_ID_EX; MemtoReg_EX_MEM = MemtoReg_ID_EX;
    FloatRegWrite_EX_MEM = FloatRegWrite_ID_EX; hilo_enable_EX_MEM = hilo_enable_ID_EX;
    GeneralRegWrite_EX_MEM = GeneralRegWrite_ID_EX;
end


memory_wrapper data_mem_inst(.a(Result_EX_MEM[11:0]), .d(general_reg_read2_out_EX_MEM), .dpra(Result_EX_MEM[11:0]), .clk(clk), .we(MemWrite_EX_MEM), .dpo(MemOut));
// read address - dpra, wire uska dpo. we - write enable, a - write address, d - write data

mux4_1 mux_memtoreginst(MemtoReg_EX_MEM, Result_EX_MEM, MemOut, {22'b0, pc_EX_MEM}, offset_EX_MEM, write_data);
//assign write_data = 0;

reg [31:0] write_data_MEM_WB;
reg hilo_enable_MEM_WB, GeneralRegWrite_MEM_WB, FloatRegWrite_MEM_WB;
reg [4:0] write_reg_MEM_WB;

always @(posedge clk) begin
    write_data_MEM_WB = write_data; hilo_enable_MEM_WB = hilo_enable_EX_MEM; 
    GeneralRegWrite_MEM_WB = GeneralRegWrite_EX_MEM; FloatRegWrite_MEM_WB = FloatRegWrite_EX_MEM;
    write_reg_MEM_WB = write_reg_EX_MEM;
end

endmodule
