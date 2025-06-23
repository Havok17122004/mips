`timescale 1ns / 1ps

module branchcontrol_tb;

    // Inputs
    reg Branch;
    reg [2:0] BranchOp;
    reg Zero;
    reg Gt;

    // Output
    wire final_wire;

    // Instantiate the Unit Under Test (UUT)
    BranchControl uut (
        .Branch(Branch),
        .BranchOp(BranchOp),
        .Zero(Zero),
        .Gt(Gt),
        .final_wire(final_wire)
    );

    integer i;

    initial begin
        $display("Time\tBranchOp\tBranch\tZero\tGt\tfinal_wire");

        // Loop through all BranchOp values
        for (i = 0; i < 8; i = i + 1) begin
            BranchOp = i[2:0];

            // Test with different combinations of Branch, Zero, Gt
            Branch = 1;
            Zero = 0; Gt = 0; #5 $display("%0dns\t%d\t\t%b\t%b\t%b\t%b", $time, BranchOp, Branch, Zero, Gt, final_wire);
            Zero = 1; Gt = 0; #5 $display("%0dns\t%d\t\t%b\t%b\t%b\t%b", $time, BranchOp, Branch, Zero, Gt, final_wire);
            Zero = 0; Gt = 1; #5 $display("%0dns\t%d\t\t%b\t%b\t%b\t%b", $time, BranchOp, Branch, Zero, Gt, final_wire);
            Zero = 1; Gt = 1; #5 $display("%0dns\t%d\t\t%b\t%b\t%b\t%b", $time, BranchOp, Branch, Zero, Gt, final_wire);

            // Also test when Branch is 0 (should always output 0)
            Branch = 0;
            Zero = 1; Gt = 1; #5 $display("%0dns\t%d\t\t%b\t%b\t%b\t%b", $time, BranchOp, Branch, Zero, Gt, final_wire);
        end

        $finish;
    end

endmodule
