`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2025 04:25:14 PM
// Design Name: 
// Module Name: processor
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


module processor(
    input clk,rst,
    input [31:0] pc
);
wire [31:0] instr,imm_ext_data,reg_read1,reg_read2,alu_src_muxout,alu_out,mem_read_data,mem_to_reg_muxout,next_pc_muxout;
wire [4:0] write_reg_muxout;
wire RegDst,Jump,Branch,MemRead,MemToReg,Memwrite,AluSrc,RegWrite;
wire [1:0] AluOp;

PC pc_inst(clk,rst,next_pc_muxout,pc);
instruction_memory instr_mem_inst(pc,instr);
mux2_1 regwrite_mux_inst(instr[20:16],instr[15:11],RegDst,write_reg_muxout);
register_file reg_file_inst(clk,instr[25:21],instr[20:16],write_reg_muxout,mem_to_reg_muxout,RegWrite,reg_read1,reg_read2);
sign_extender sign_ext_inst(instr[15:0],imm_ext_data);


ALU alu_inst();

endmodule


module mux2_1(A,B,Sel,mux_out);

parameter W = 5;
input [W-1:0] A,B;
input Sel;
output [W-1:0] mux_out;

assign mux_out = (Sel == 0) ? A:B;

endmodule

module PC(
    input clk,
    input rst,
    input [31:0] pcin,
    output reg [31:0] pcout    
);
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            pcout <= 32'd0;
        end
        else begin
            pcout <= pcin;
        end
    end
endmodule

module instruction_memory(
    input [31:0] addr,
    output reg [31:0] instr
);
    reg [31:0] instr_mem[0:1024];
    
  
    always@(addr) begin
        instr <= instr_mem[addr];
    end
endmodule

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
    
    always@(posedge clk) begin
        if(reg_write) begin
            register_file[write_reg] <= write_data;
        end
        else begin
            register_file[write_reg] <= register_file[write_reg];
        end
    end
    
endmodule


module sign_extender(
    input [15:0] datain,
    output [32:0] dataout
);
    assign dataout = (datain[15] == 1'b1) ? {16'b1111111111111111,datain}:{16'b0000000000000000,datain};

endmodule

module shift_left2(
    input [31:0] shiftin,
    output [31:0] shiftout
);
    assign shiftout = shiftin;

endmodule

module data_memory(
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data,
    input mem_write,
    input mem_read
);
    reg [31:0] data_mem[0:1024];
    always@(*) begin
        if(mem_write) begin
            data_mem[addr] <= write_data;
        end
        else begin
            read_data <= data_mem[addr];
        end
    end
    
endmodule


reg [31:0] hi,lo;

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [5:0] AluCtl,
    input inv_zero,
    output reg [31:0] AluOut,
    output reg zero
);

reg [63:0] temp;

always@(*) begin
    case(AluCtl)
        1: AluOut <= A + B; //add
        2: AluOut <= A - B; //sub
        3: begin 
            temp <= A * B;    //mul
            hi <= temp[63:32];
            lo <= temp[31:0];
           end
        4: begin 
            temp <= A * B;
            hi <= hi + temp[63:32]; //madd
            lo <= lo + temp[31:0];
           end
        5: AluOut <= A << B; //sll
        6: AluOut <= A >> B; //srl
        7: AluOut <= $signed(A) >>> B; // sra
        8: AluOut <= $signed(A) <<< B; // sla
        9: AluOut <= A | B; // or
        10: AluOut <= A & B; // and
        11: AluOut <= A ^ B; // a xor b
        12: AluOut <= ~A; // not
        13: AluOut <= (A < B)? 32'd1:32'd0; // slt
        14: AluOut <= (A > B); //sgt
        
    endcase
    zero <= (inv_zero == 1'b1)? (AluOut != 0):(AluOut == 0);

end


endmodule

module ALUControl(
    input [5:0] opcode,
    input [5:0] funct,
    output reg inv_zero,
    output reg [5:0] AluCtl
);

    always@(*) begin
    if (opcode == 6'd0) begin
    
        case(funct)
            1: begin AluCtl <= 1;inv_zero <= 0; end
            2: begin AluCtl <= 2; inv_zero <= 0; end
            3: begin AluCtl <= 1; inv_zero <= 0; end
            4: begin AluCtl <= 2; inv_zero <= 0; end
            5: begin AluCtl <= 4; inv_zero <= 0; end
            6: begin AluCtl <= 4; inv_zero <= 0; end
            7: begin AluCtl <= 3; inv_zero <= 0; end
            8: begin AluCtl <= 10; inv_zero <= 0; end
            9: begin AluCtl <= 9; inv_zero <= 0; end
            10: begin AluCtl <= 12; inv_zero <= 0; end
            11: begin AluCtl <= 11; inv_zero <= 0; end
            12: begin AluCtl <= 13; inv_zero <= 0; end
        endcase
     end
     else if (opcode[5] == 1'b1) begin
        
            case(opcode[4:0])
                    6'd13: begin AluCtl <= 2; inv_zero <= 0; end
                    6'd14: begin AluCtl <= 2; inv_zero <= 1; end
                    6'd15: begin AluCtl <= 14; inv_zero <= 1; end
                    6'd16: begin AluCtl <= 13; inv_zero <= 0; end
                    6'd17: begin AluCtl <= 13; inv_zero <= 1; end
                    6'd18: begin AluCtl <= 14; inv_zero <= 0; end
                    6'd19: begin AluCtl <= 13; inv_zero <= 1; end
                    6'd20: begin AluCtl <= 14; inv_zero <= 1; end
            endcase
              
        end
    end
    
endmodule

module ControlUnit(
    input [5:0] opcode,
    output reg RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,
    output reg [1:0] AluOp
);
    always@(*) begin
        case(opcode)
            // r type
            6'b000000: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        AluOp <= 2'b10;
                        Jump <= 1'b0;
                       end
            // branch instructions
            6'b101101: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        AluOp <= 2'b10;
                        Jump <= 1'b0;            
                       end
            6'b101110: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b101111: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b110000: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b110001: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b110010: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b110011: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            6'b110100: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end   
            // lw
            6'b101010: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b1;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b1;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            // sw
            6'b101011: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b1;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
            // j
            6'b010001: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b1;
                        AluOp <= 2'b10;
                       end
            // jr
            6'b010010: begin // need to change architecture. not done yet.
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b1;
                        Branch <= 1'b0;
                        Jump <= 1'b1;
                        AluOp <= 2'b10;
                       end
            // jal 
            6'b010011: begin // need to change architecture. not done yet
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b1;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                       end
                       
            default: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                     end 
        endcase
    
    end

endmodule

module shift_left_2(
    input [31:0] shiftin,
    output [31:0] shiftout
);

assign shiftout = shiftin << 2;


endmodule
