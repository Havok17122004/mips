module hazard_handling_unit(
    input MemRead_ID_EX,
    input [4:0] write_reg_ID_EX,
    input [4:0] rs_IF_ID,
    input [4:0] rt_IF_ID,
    output reg ControlUnitRst,
    output reg pc_WE,
    output reg WE_if_id
);

    always @(*) begin
        if (MemRead_ID_EX &&
            ((write_reg_ID_EX == rs_IF_ID) || (write_reg_ID_EX == rt_IF_ID))) begin
            ControlUnitRst = 1'b1;
            pc_WE = 1'b0;
            WE_if_id = 1'b0;
        end else begin
            ControlUnitRst = 1'b0;
            pc_WE = 1'b1;
            WE_if_id = 1'b1;
        end
    end

endmodule
