// 16kb_memory using 4kb_memory

module memory_16kb (
    input wire clk,
    input wire [13:0] addr,   // 14-bit address for 16KB (2^14 = 16384 locations)
    input wire [7:0] data_in, // 8-bit input data
    input wire we,            // Write enable
    output reg [7:0] data_out // 8-bit output data
);

    wire [7:0] data_out0, data_out1, data_out2, data_out3;
    wire [11:0] local_addr = addr[11:0]; // Lower 12 bits for the 4KB block address
    reg [1:0] block_select;              // Upper 2 bits to select the block

    // Instantiate 4 4KB memory blocks
    memory_4kb mem0 (.clk(clk), .addr(local_addr), .data_in(data_in), .we(we & (block_select == 2'b00)), .data_out(data_out0));
    memory_4kb mem1 (.clk(clk), .addr(local_addr), .data_in(data_in), .we(we & (block_select == 2'b01)), .data_out(data_out1));
    memory_4kb mem2 (.clk(clk), .addr(local_addr), .data_in(data_in), .we(we & (block_select == 2'b10)), .data_out(data_out2));
    memory_4kb mem3 (.clk(clk), .addr(local_addr), .data_in(data_in), .we(we & (block_select == 2'b11)), .data_out(data_out3));

    always @(*) begin
        block_select = addr[13:12]; // Upper 2 bits of address select the memory block
        case (block_select)
            2'b00: data_out = data_out0;
            2'b01: data_out = data_out1;
            2'b10: data_out = data_out2;
            2'b11: data_out = data_out3;
        endcase
    end
endmodule


// Sub module for 4kb memory :


module memory_4kb (
    input wire clk,
    input wire [11:0] addr,   // 12-bit address for 4KB (2^12 = 4096 locations)
    input wire [7:0] data_in, // 8-bit input data
    input wire we,            // Write enable
    output reg [7:0] data_out // 8-bit output data
);
    reg [7:0] mem_array [0:4095]; // 4KB memory array (4096 x 8 bits)

    always @(posedge clk) begin
        if (we) begin
            mem_array[addr] <= data_in; // Write operation
        end else begin
            data_out <= mem_array[addr]; // Read operation
        end
    end
endmodule


// output :
/*
# Data read from Block 0: a5 (Expected: A5)
# Data read from Block 1: 5a (Expected: 5A)
# Data read from Block 2: 3c (Expected: 3C)
# Data read from Block 3: c3 (Expected: C3)
# ** Note: $finish    : 16kb_memory_tb.v(90)
#    Time: 155 ps  Iteration: 1  Instance: /tb_memory_16kb
# 1
*/
