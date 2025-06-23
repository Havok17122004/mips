`timescale 1ns / 1ps

module memory_file_tb;

    // Inputs
    reg [11:0] a, dpra;
    reg [31:0] d;
    reg clk, we;

    // Output
    wire [31:0] dpo;

    // Instantiate the module
    memory_wrapper uut (
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
        a = 12'd10;
        d = 32'hDEADBEEF;
        #10;

        a = 12'd20;
        d = 32'h12345678;
        #10;

        we = 0;

        // Read from memory
        dpra = 12'd10; #10;
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        dpra = 12'd20; #10;
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        dpra = 12'd30; #10; // uninitialized address
        $display("%0dns\t%h\t%h\t%h\t%h", $time, a, d, dpra, dpo);

        $finish;
    end
endmodule
