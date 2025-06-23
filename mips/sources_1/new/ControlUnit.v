module ControlUnit(
    input [5:0] opcode,
    output reg AluSrc,FloatRegWrite, GeneralRegWrite, MemWrite, Branch, Jump, FloatEnable,
    output reg [1:0] RegDst, MemtoReg,
    output reg [2:0] BranchOp,
    output reg [3:0] AluOp
);

// AluSrc --> The first source of ALU is readdata1. This figures out the second source. if 1, then source is sign extended immediate value. 
// if 0, source is readdata2
// FloatRegWrite --> write enable of the register file of floating points.
// GeneralRegWrite
// MemRead --> re of data memory read
// MemWrite --> we of data memory write
// Branch --> 1 if opcode of branch
// Jump --> 1 if opcode of jump.
// Mfc1 --> if 1, then mfc1 encountered
// Mtc1 --> if 1 then mtc1 encountered
// FloatEnable --> If 1, then the output of FPU is enabled
// RegDst --> 00 - write reg is rt. 01 -- write reg is rd. 10 -- write reg is $ra
// MemtoReg --> 00 -- Alu output to be written in reg. 01 -- Mem output, 10 -- PC+4, 11 -- immediate shifted left by 16.
// BranchOp --> in sequence -- beq, bne, bgt, bgte, ble, bleq, bleu, bgtu
// Aluop --> in sequen- R, add, addu, sub, subu, or, xor, seq, slt, sgt, sge, mov

    initial begin 
        AluSrc = 0;
        FloatRegWrite = 0;
        GeneralRegWrite = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
        FloatEnable = 0;
        RegDst = 2'b01;
        MemtoReg = 0;
        BranchOp = 0;
        AluOp = 0;
    end

    always@(*) begin
        case(opcode)
            // r type
            6'b000000: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b1; // what about multiplication. resolved.
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        AluOp <= 4'd0; // to be changed
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        FloatEnable <= 1'b0;
                        BranchOp <= 3'd0;
                       end
            // branch instructions
            6'b101001: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        AluOp <= 4'd4; // sub for beq
                        Jump <= 1'b0;            
                        FloatRegWrite <= 1'b0;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; // beq
                       end
            6'b101010: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        AluOp <= 4'd4; // to be changed
                        FloatRegWrite <= 1'b0;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd1; // bne
                       end
            6'b101011: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd4; 
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd2; // bgt
                       end
            6'b101100: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd4;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd3; // bgte
                       end
            6'b101101: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd4;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd4; // ble 
                       end
            6'b101110: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd4;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd5; // bleq
                       end
            6'b101111: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd5;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd6; // bleu
                       end
            6'b110000: begin
                        RegDst <= 1'b1;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd5;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd7; // bgtu 
                       end   
            // lw
            6'b100110: begin
                       RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b1;
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b1;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;  
                       end
            // sw
            6'b100111: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b01;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b1;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;  
                       end
            // j
            6'b010001: begin
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b1;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 2'b10; // dont care
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;  
                       end
            // jr
            6'b010010: begin 
                        RegDst <= 1'b0;
                        AluSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        Jump <= 1'b1;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 2'b10; // dont care
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; 
                       end
            // jal 
            6'b010011: begin 
                        RegDst <= 2'b10; // write into $ra
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b10; // write pc+4 into $ra
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b1;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 2'b10; // dont care
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; 
                       end
            6'b100001: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;  
                    end
            6'b100010: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd3;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;  
                    end
            6'b100011: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd1;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; 
                    end
            6'b100100: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd6;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; 
                    end
            6'b100101: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd7;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0; 
                    end
            // slti
            6'b110001: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd9;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;
                    end
            // seq
            6'b110010: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b0; // write alu output
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd8;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;
                    end
            // lui
            6'b101000: begin
                        RegDst <= 2'b00;
                        AluSrc <= 1'b1;
                        MemtoReg <= 2'b11; // write left shifted immediate
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 2'b10; // dont care
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;
                    end
            // float
            6'b000001: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            6'b000010: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd4; 
                       end
            6'b000011: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd8;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            6'b000100: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd13;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            6'b000101: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd9;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            6'b000110: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd11;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            6'b000111: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd10;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
           // mov
            6'b001000: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd2; 
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            // mfc1
            6'b001001: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b0;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b1; 
                        BranchOp <= 3'd0;
                       end
            // mtc1
            6'b001010: begin
                        RegDst <= 2'b01;
                        AluSrc <= 1'b0;
                        MemtoReg <= 2'b00; 
                        GeneralRegWrite <= 1'b0;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        FloatRegWrite <= 1'b1;
                        AluOp <= 4'd2;
                        FloatEnable <= 1'b0; 
                        BranchOp <= 3'd0;
                       end
            
            default: begin // hope so never called
                        RegDst <= 1'b0;
                        AluSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        GeneralRegWrite <= 1'b1;
//                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        Jump <= 1'b0;
                        AluOp <= 2'b10;
                     end 
        endcase
    // lui
    end

endmodule