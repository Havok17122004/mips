module forwarding_unit(
    input        FloatRegWrite_MEM_WB,
    input        GeneralRegWrite_MEM_WB,
    input        GeneralRegWrite_EX_MEM,
    input        FloatRegWrite_EX_MEM,
    input [4:0]  write_reg_MEM_WB,
    input [4:0]  write_reg_EX_MEM,
    input [4:0]  rs_ID_EX,
    input [4:0]  rt_ID_EX,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

    always @(*) begin
        forwardA = 2'b00;
        forwardB = 2'b00;

        // EX hazard
        if ((GeneralRegWrite_EX_MEM || FloatRegWrite_EX_MEM) && (write_reg_EX_MEM != 5'd0) && (write_reg_EX_MEM == rs_ID_EX))
            forwardA = 2'b10;
        if ((GeneralRegWrite_EX_MEM || FloatRegWrite_EX_MEM) && (write_reg_EX_MEM != 5'd0) && (write_reg_EX_MEM == rt_ID_EX))
            forwardB = 2'b10;

        // MEM hazard
        if ((GeneralRegWrite_MEM_WB || FloatRegWrite_MEM_WB) && (write_reg_MEM_WB != 5'd0) && (write_reg_MEM_WB == rs_ID_EX) && !(write_reg_EX_MEM != 5'd0 && (write_reg_EX_MEM == rs_ID_EX) && (GeneralRegWrite_EX_MEM || FloatRegWrite_EX_MEM)))
            forwardA = 2'b01;
        if ((GeneralRegWrite_MEM_WB || FloatRegWrite_MEM_WB) && (write_reg_MEM_WB != 5'd0) && (write_reg_MEM_WB == rt_ID_EX) && !(write_reg_EX_MEM != 5'd0 && (write_reg_EX_MEM == rt_ID_EX) && (GeneralRegWrite_EX_MEM || FloatRegWrite_EX_MEM)))
            forwardB = 2'b01;
    end

endmodule
