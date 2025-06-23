`timescale 1ns / 1ps

module instruction_file_tb;

    // Inputs
    reg [9:0] a, dpra;
    reg [31:0] d;
    reg clk, we;

    // Output
    wire [31:0] dpo;

    // Instantiate the module
    instruction_memory_wrapper uut (
        .a(a),
        .d(d),
        .dpra(dpra),
        .clk(clk),
        .we(we),
        .dpo(dpo)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        $display("Time\tWriteAddr\tDataIn\tReadAddr\tDataOut");

        // Initialize
        clk = 0;
        we = 0;
        a = 0;
        d = 0;
        dpra = 0;

        // Write data
        #10;
        we = 1;
        a = 10'd5;
        d = 32'h3AFEBABE;
        #10;

        a = 10'd15;
        d = 32'hFACEFEED;
        #10;

        we = 0;

        // Read from memory
        dpra = 10'd5; #10;
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        dpra = 10'd15; #10;
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        dpra = 10'd25; #10; // uninitialized address
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        $finish;
    end
endmodule
