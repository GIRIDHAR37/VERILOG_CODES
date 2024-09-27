`include "16kb_4kb.v"

module tb_memory_16kb;

    reg clk;
    reg [13:0] addr;     // 14-bit address for 16KB memory
    reg [7:0] data_in;   // 8-bit input data
    reg we;              // Write enable
    wire [7:0] data_out; // 8-bit output data

    // Instantiate the 16KB memory module
    memory_16kb dut (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .we(we),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial block to initialize and run test scenarios
    initial begin
        // Initialize signals
        clk = 0;
        addr = 0;
        data_in = 0;
        we = 0;

        // Test case 1: Write data to memory block 0 (first 4KB)
        @(posedge clk);
        addr = 14'b0000_0000_0000_00; // Address in block 0
        data_in = 8'hA5;
        we = 1;
        @(posedge clk);
        we = 0; // Disable write

        // Test case 2: Write data to memory block 1 (second 4KB)
        @(posedge clk);
        addr = 14'b0100_0000_0000_00; // Address in block 1
        data_in = 8'h5A;
        we = 1;
        @(posedge clk);
        we = 0;

        // Test case 3: Write data to memory block 2 (third 4KB)
        @(posedge clk);
        addr = 14'b1000_0000_0000_00; // Address in block 2
        data_in = 8'h3C;
        we = 1;
        @(posedge clk);
        we = 0;

        // Test case 4: Write data to memory block 3 (fourth 4KB)
        @(posedge clk);
        addr = 14'b1100_0000_0000_00; // Address in block 3
        data_in = 8'hC3;
        we = 1;
        @(posedge clk);
        we = 0;

        // Read back data to verify

        // Read from block 0
        @(posedge clk);
        addr = 14'b0000_0000_0000_00;
        @(posedge clk);
        $display("Data read from Block 0: %h (Expected: A5)", data_out);

        // Read from block 1
        @(posedge clk);
        addr = 14'b0100_0000_0000_00;
        @(posedge clk);
        $display("Data read from Block 1: %h (Expected: 5A)", data_out);

        // Read from block 2
        @(posedge clk);
        addr = 14'b1000_0000_0000_00;
        @(posedge clk);
        $display("Data read from Block 2: %h (Expected: 3C)", data_out);

        // Read from block 3
        @(posedge clk);
        addr = 14'b1100_0000_0000_00;
        @(posedge clk);
        $display("Data read from Block 3: %h (Expected: C3)", data_out);

        // Test done
        $finish;
    end

endmodule

