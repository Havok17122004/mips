module PC(
    input clk,
    input rst,
    input [9:0] init_pc,
    input [31:0] offset,
    input Branch,
    input Branch_final,
    input Jump,
    input [9:0] reg_read_out1,
    input [9:0] j_address,
    input Zero,
    output reg [9:0] out_pc
);
    reg [9:0] pc_reg;
    wire [9:0] add4_wire;
    wire [9:0] add4_offset;
    wire [9:0] next_pc;
    wire [1:0] sel;
    
    initial begin 
        pc_reg = 0;
    end

    assign add4_wire = pc_reg + 32'd1;
    assign add4_offset = add4_wire + offset;
    assign sel = {Jump, (Branch_final | (Branch & Jump))};

    mux4_1 #(.W(10)) inst_branch (
        .sel(sel),
        .one(add4_wire),        // PC + 4
        .two(add4_offset),      // PC + 4 + offset
        .three(j_address),        // direct jump address
        .four(reg_read_out1),    // register-based jump
        .out(next_pc)
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= init_pc;
        else
            pc_reg <= next_pc;
    end

    // Output assignment
    always @(*) begin
        out_pc = pc_reg;
    end
endmodule
