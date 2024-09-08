module crc32_parallel (
    input clk, rst, load, d_finish,
    input [7:0] data_in,
    output reg [31:0] crc_out
);

    reg [31:0] crc_register;
    reg [3:0] counter;
    reg [1:0] current_state;
    wire [31:0] next_crc_register;

    parameter IDLE_STATE = 2'b00;
    parameter COMPUTE_STATE = 2'b01;
    parameter FINISH_STATE = 2'b10;

    // Polynomial for CRC-32: 0x04C11DB7
    assign next_crc_register[0]  = data_in[7] ^ crc_register[31];
    assign next_crc_register[1]  = data_in[6] ^ crc_register[30];
    assign next_crc_register[2]  = data_in[5] ^ crc_register[29];
    assign next_crc_register[3]  = data_in[4] ^ crc_register[28];
    assign next_crc_register[4]  = data_in[3] ^ crc_register[27];
    assign next_crc_register[5]  = data_in[2] ^ crc_register[26];
    assign next_crc_register[6]  = data_in[1] ^ crc_register[25];
    assign next_crc_register[7]  = data_in[0] ^ crc_register[24];
    assign next_crc_register[8]  = crc_register[23];
    assign next_crc_register[9]  = crc_register[22];
    assign next_crc_register[10] = crc_register[21];
    assign next_crc_register[11] = crc_register[20];
    assign next_crc_register[12] = crc_register[19];
    assign next_crc_register[13] = crc_register[18];
    assign next_crc_register[14] = crc_register[17];
    assign next_crc_register[15] = crc_register[16];
    assign next_crc_register[16] = crc_register[15] ^ crc_register[31];
    assign next_crc_register[17] = crc_register[14] ^ crc_register[30];
    assign next_crc_register[18] = crc_register[13] ^ crc_register[29];
    assign next_crc_register[19] = crc_register[12] ^ crc_register[28];
    assign next_crc_register[20] = crc_register[11] ^ crc_register[27];
    assign next_crc_register[21] = crc_register[10] ^ crc_register[26];
    assign next_crc_register[22] = crc_register[9]  ^ crc_register[25];
    assign next_crc_register[23] = crc_register[8]  ^ crc_register[24];
    assign next_crc_register[24] = crc_register[7];
    assign next_crc_register[25] = crc_register[6];
    assign next_crc_register[26] = crc_register[5];
    assign next_crc_register[27] = crc_register[4];
    assign next_crc_register[28] = crc_register[3];
    assign next_crc_register[29] = crc_register[2];
    assign next_crc_register[30] = crc_register[1];
    assign next_crc_register[31] = crc_register[0] ^ crc_register[31];

    // State machine for CRC operation
    always @(posedge clk) begin
        case (current_state)
            IDLE_STATE: begin
                if (load) 
                    current_state <= COMPUTE_STATE;
                else 
                    current_state <= IDLE_STATE;
            end
            COMPUTE_STATE: begin
                if (d_finish)
                    current_state <= FINISH_STATE;
                else 
                    current_state <= COMPUTE_STATE;
            end
            FINISH_STATE: begin
                if (counter == 4'd3) // Counter for 4 cycles to output all CRC bits
                    current_state <= IDLE_STATE;
                else
                    current_state <= FINISH_STATE;
            end
        endcase
    end

    // CRC calculation and counter update logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_register <= 32'b0;
            current_state <= IDLE_STATE;
            counter <= 4'b0;
            crc_out <= 8'b0;
        end else begin
            case (current_state)
                IDLE_STATE: begin
                    crc_register <= 32'b0;
                    counter <= 4'b0;
                end
                COMPUTE_STATE: begin
                    crc_register <= next_crc_register;
                    crc_out <= data_in;
                end
                FINISH_STATE: begin
                    crc_out <= crc_register[31:24];  // Output top 8 bits
                    crc_register <= {crc_register[23:0], 8'b0};  // Shift out bits
                    counter <= counter + 1;  // Increment counter to track shifting
                end
            endcase
        end
    end
endmodule

// output :
/*
# Time = 50 | data_in = 00100100 | crc_out = 00000000
# Time = 70 | data_in = 10000001 | crc_out = 10000001
# Time = 90 | data_in = 00001001 | crc_out = 00001001
# Time = 110 | data_in = 01100011 | crc_out = 01100011
# Time = 130 | data_in = 00001101 | crc_out = 00001101
# Time = 150 | data_in = 10001101 | crc_out = 10001101
# Time = 170 | data_in = 01100101 | crc_out = 01100101
# Time = 190 | data_in = 00010010 | crc_out = 00010010
# Time = 210 | data_in = 00000001 | crc_out = 00000001
# Time = 230 | data_in = 00001101 | crc_out = 00001101
# Time = 1370 | data_in = 01110110 | crc_out = 00000000 | d_finish = 0
# Time = 1375 | data_in = 01110110 | crc_out = 01110110 | d_finish = 0
# Time = 1380 | data_in = 00111101 | crc_out = 01110110 | d_finish = 0
# Time = 1385 | data_in = 00111101 | crc_out = 00111101 | d_finish = 0
# Time = 1390 | data_in = 00111101 | crc_out = 00111101 | d_finish = 0
# Time = 1400 | data_in = 11101101 | crc_out = 00111101 | d_finish = 0
# Time = 1405 | data_in = 11101101 | crc_out = 11101101 | d_finish = 0
# Time = 1410 | data_in = 11101101 | crc_out = 11101101 | d_finish = 0
# Time = 1420 | data_in = 10001100 | crc_out = 11101101 | d_finish = 0
# Time = 1425 | data_in = 10001100 | crc_out = 10001100 | d_finish = 0
# Time = 1430 | data_in = 10001100 | crc_out = 10001100 | d_finish = 0
# Time = 1440 | data_in = 11111001 | crc_out = 10001100 | d_finish = 0
# Time = 1445 | data_in = 11111001 | crc_out = 11111001 | d_finish = 0
# Time = 1450 | data_in = 11111001 | crc_out = 11111001 | d_finish = 0
# Time = 1460 | data_in = 11000110 | crc_out = 11111001 | d_finish = 0
# Time = 1465 | data_in = 11000110 | crc_out = 11000110 | d_finish = 0
# Time = 1470 | data_in = 11000110 | crc_out = 11000110 | d_finish = 0
# Time = 1480 | data_in = 11000101 | crc_out = 11000110 | d_finish = 0
# Time = 1485 | data_in = 11000101 | crc_out = 11000101 | d_finish = 0
# Time = 1490 | data_in = 11000101 | crc_out = 11000101 | d_finish = 0
# Time = 1500 | data_in = 10101010 | crc_out = 11000101 | d_finish = 0
# Time = 1505 | data_in = 10101010 | crc_out = 10101010 | d_finish = 0
# Time = 1510 | data_in = 10101010 | crc_out = 10101010 | d_finish = 0
# Time = 1520 | data_in = 11100101 | crc_out = 10101010 | d_finish = 0
# Time = 1525 | data_in = 11100101 | crc_out = 11100101 | d_finish = 0
# Time = 1530 | data_in = 11100101 | crc_out = 11100101 | d_finish = 0
# Time = 1540 | data_in = 01110111 | crc_out = 11100101 | d_finish = 0
# Time = 1545 | data_in = 01110111 | crc_out = 01110111 | d_finish = 0
# Time = 1550 | data_in = 01110111 | crc_out = 01110111 | d_finish = 0
# ** Note: $finish    : crc32_tb.v(63)
#    Time: 2550 ps  Iteration: 0  Instance: /crc32_parallel_tb
*/
