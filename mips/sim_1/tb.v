`timescale 1ns / 1ps

module processor_tb;

    // Clock, reset, and instruction-feed signals
    reg         clk       = 0;
    reg         rst       = 1;
    reg  [9:0]  init_pc   = 10'd0;
    reg         instr_we  = 0;
    reg  [31:0] instr_feed;

    // DUT instantiation
    processor uut (
        .clk(clk),
        .rst(rst),
        .init_pc(init_pc),
        .instr_we(instr_we),
        .instr_feed(instr_feed)
        // Add additional DUT output ports here for monitoring, if needed
    );

    // Clock: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    // Memory to hold the binary instructions
    reg [31:0] instructions [0:255];
    integer i;
    integer num_instr = 3; // Update this based on your machine_code.txt

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
            $display("[%0dns] Feeding instruction %0d: %032b (0x%08h)", $time, i, instr_feed, instr_feed);
            #10;
        end

        instr_we = 0;
        $display("\n[%0dns] Instruction feed complete. Processor running...\n", $time);

        // 4) Let the processor run
        repeat (100) #10;

        $display("\n================== Simulation End ==================\n");
        $finish;
    end

    // Continuous signal monitoring
    initial begin
        $display("Time   clk  rst  init_pc  instr_we  instr_feed (binary / hex)");
        $monitor("%4dns   %b    %b    %3d       %b      %032b / 0x%08h",
                 $time, clk, rst, init_pc, instr_we, instr_feed, instr_feed);
    end

endmodule
