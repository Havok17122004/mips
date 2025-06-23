`timescale 1ns / 1ps

module PC_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [9:0] init_pc;
    reg [9:0] offset;
    reg Branch;
    reg Branch_final;
    reg Jump;
    reg [9:0] reg_read_out1;
    reg [9:0] j_address;
    reg Zero;

    // Output
    wire [9:0] out_pc;

    // Instantiate the Unit Under Test (UUT)
    PC uut (
        .clk(clk),
        .rst(rst),
        .init_pc(init_pc),
        .offset(offset),
        .Branch(Branch),
        .Branch_final(Branch_final),
        .Jump(Jump),
        .reg_read_out1(reg_read_out1),
        .j_address(j_address),
        .Zero(Zero),
        .out_pc(out_pc)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        init_pc = 10'd100;
        offset = 10'd8;
        Branch = 0;
        Branch_final = 0;
        Jump = 0;
        reg_read_out1 = 10'd200;
        j_address = 10'd150;
        Zero = 0;

        // Wait for global reset
        #10;
        rst = 0;

        // Test 1: Normal increment
        #10;
        $display("Time=%0t out_pc=%0d (Expecting 104)", $time, out_pc);

        // Test 2: Branch taken (Branch_final = 1)
        #10
        Branch_final = 1;
        Branch = 1;
        offset = 10'd4;
        $display("Time=%0t out_pc=%0d (Expecting 108)", $time, out_pc);

        // Test 3: Jump taken
        #10;
        Branch = 0;
        Branch_final = 0;
        Jump = 1;
        j_address = 10'd180;
        
        $display("Time=%0t out_pc=%0d (Expecting 180)", $time, out_pc);

        // Test 4: Register Jump
        #10;
        Branch = 1;
        Branch_final = 0;
        Jump = 1;
        reg_read_out1 = 10'd250;
        
        $display("Time=%0t out_pc=%0d (Expecting 250)", $time, out_pc);
#10;
        Branch = 1;
        Jump = 0;
        Branch_final = 0;
        offset = 10'd16;
        $display("Time=%0t out_pc=%0d (Expecting 112)", $time, out_pc); // last was 108, +4
        // Test 5: Reset again
        #10;
        rst = 1;
        #10;
        rst = 0;
        
        $display("Time=%0t out_pc=%0d (Expecting 100)", $time, out_pc);
        
        
    end
endmodule
