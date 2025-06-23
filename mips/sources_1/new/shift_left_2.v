module shift_left_2(
    input [31:0] shiftin,
    output [31:0] shiftout
);

assign shiftout = shiftin << 2;


endmodule
