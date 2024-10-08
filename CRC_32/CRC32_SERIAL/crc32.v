module crc32_serial (
    input clk,            // Clock signal
    input rst,            // Reset signal (active low)
    input load,           // Start encoding signal
    input d_finish,       // Encoding end signal
    input crc_in,         // Input data bit for encoding
    output reg crc_out    // Output encoded bit
);

    reg [31:0] mem;       // 32-bit shift register for CRC-32 computation
    reg [1:0] state;      // 2-bit state register
    reg [5:0] count;      // 6-bit counter for 32-bit CRC computation (0-32)
    
    // State parameters
    parameter idle = 2'b00;      // Idle state
    parameter compute = 2'b01;   // Compute state
    parameter finish = 2'b10;    // Finish state

    // CRC-32 polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
    parameter [31:0] POLY = 32'h04C11DB7;

    // State transition logic
    always @(posedge clk) begin
        case (state)
            idle: begin
                if (load)
                    state <= compute;
                else
                    state <= idle;
            end
            compute: begin
                if (d_finish)
                    state <= finish;
                else
                    state <= compute;
            end
            finish: begin
                if (count == 32)
                    state <= idle;
                else
                    count <= count + 1;
            end
            default: state <= idle;
        endcase
    end

    // CRC logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            count <= 6'b000000;
            state <= idle;
            crc_out <= 0;
        end else begin
            case (state)
                idle: begin
                    mem <= 32'h00000000;    // Initialize memory to zero
                end
                compute: begin
                    // Compute CRC-32: shift in data bit and apply polynomial
                    mem[0] <= crc_in ^ mem[31];          // XOR with the input and MSB of the register
                    mem[1] <= mem[0];
                    mem[2] <= mem[1];
                    mem[3] <= mem[2];
                    mem[4] <= mem[3];
                    mem[5] <= mem[4] ^ (mem[31] ? POLY[5] : 0);
                    mem[6] <= mem[5];
                    mem[7] <= mem[6] ^ (mem[31] ? POLY[7] : 0);
                    mem[8] <= mem[7];
                    mem[9] <= mem[8];
                    mem[10] <= mem[9];
                    mem[11] <= mem[10];
                    mem[12] <= mem[11] ^ (mem[31] ? POLY[12] : 0);
                    mem[13] <= mem[12];
                    mem[14] <= mem[13] ^ (mem[31] ? POLY[14] : 0);
                    mem[15] <= mem[14];
                    mem[16] <= mem[15];
                    mem[17] <= mem[16];
                    mem[18] <= mem[17];
                    mem[19] <= mem[18];
                    mem[20] <= mem[19];
                    mem[21] <= mem[20];
                    mem[22] <= mem[21] ^ (mem[31] ? POLY[22] : 0);
                    mem[23] <= mem[22] ^ (mem[31] ? POLY[23] : 0);
                    mem[24] <= mem[23];
                    mem[25] <= mem[24];
                    mem[26] <= mem[25] ^ (mem[31] ? POLY[26] : 0);
                    mem[27] <= mem[26];
                    mem[28] <= mem[27];
                    mem[29] <= mem[28];
                    mem[30] <= mem[29];
                    mem[31] <= mem[30] ^ (mem[31] ? POLY[31] : 0);
                    
                    crc_out <= crc_in;      // Output the input data as it is
                end
                finish: begin
                    crc_out <= mem[31];     // Output the MSB of the shift register
                    mem <= {mem[30:0], 1'b0};  // Shift the register left
                end
            endcase
        end
    end

endmodule

// output :
/*
# Time : 0, clk : 0, rst : 0, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 5, clk : 1, rst : 0, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 10, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 15, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 20, clk : 0, rst : 0, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 25, clk : 1, rst : 0, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 30, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 35, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 40, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 45, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 50, clk : 0, rst : 1, load : 1 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 55, clk : 1, rst : 1, load : 1 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 60, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 65, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 70, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 75, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 80, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 85, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 90, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 95, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 100, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 105, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 110, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 115, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 120, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 125, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 130, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 135, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 140, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 145, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 150, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 155, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 160, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 165, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 170, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 175, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 180, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 185, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 190, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 195, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 200, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 205, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 210, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 215, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 220, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 225, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 230, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 235, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 240, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 245, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 250, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 255, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 260, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 265, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 270, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 275, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 280, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 285, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 290, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 295, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 300, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 305, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 310, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 315, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 320, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 325, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 330, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 335, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 340, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 345, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 350, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 355, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 360, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 365, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 370, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 375, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 380, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 385, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 390, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 395, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 400, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 405, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 410, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 415, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 420, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 425, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 430, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 435, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 440, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 445, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 450, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 455, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 460, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 465, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 470, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 475, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 480, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 485, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 490, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 495, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 500, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 505, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 510, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 515, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 520, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 525, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 530, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 535, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 540, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 545, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 550, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 555, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 560, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 565, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 570, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 575, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 580, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 585, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 590, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 595, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 600, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 605, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 610, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 615, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 620, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 625, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 630, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 635, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 640, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 645, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 650, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 655, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 660, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 665, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 670, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 675, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 680, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 685, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 690, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 695, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 700, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 705, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 710, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 715, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 720, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 725, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 730, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 735, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 740, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 745, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 750, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 755, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 760, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 765, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 770, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 775, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 780, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 785, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 790, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 795, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 800, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 805, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 810, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 815, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 820, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 825, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 830, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 835, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 840, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 845, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 850, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 855, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 860, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 865, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 870, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 1
# Time : 875, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 1
# Time : 880, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 885, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 890, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 895, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 900, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 905, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 910, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 915, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 920, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 925, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 930, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 935, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 940, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 945, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 950, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 955, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 960, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 1 d_finish : 0
# Time : 965, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 970, clk : 0, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 975, clk : 1, rst : 1, load : 0 crc_in : 1 crc_out : 0 d_finish : 0
# Time : 980, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# Time : 985, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 990, clk : 0, rst : 1, load : 0 crc_in : 0 crc_out : 1 d_finish : 0
# Time : 995, clk : 1, rst : 1, load : 0 crc_in : 0 crc_out : 0 d_finish : 0
# ** Note: $finish    : crc32_tb.v(55)
#    Time: 1 ns  Iteration: 0  Instance: /crc32_serial_tb
*/

