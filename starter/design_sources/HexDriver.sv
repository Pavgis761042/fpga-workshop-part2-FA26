// 7-segment display driver

module nibble_to_hex (
    input  logic [3:0] nibble,
    output logic [7:0] hex
);
    always_comb begin
        case (nibble)
            4'h0: hex = 8'b00111111;
            4'h1: hex = 8'b00000110;
            4'h2: hex = 8'b01011011;
            4'h3: hex = 8'b01001111;
            4'h4: hex = 8'b01100110;
            4'h5: hex = 8'b01101101;
            4'h6: hex = 8'b01111101;
            4'h7: hex = 8'b00000111;
            4'h8: hex = 8'b01111111;
            4'h9: hex = 8'b01101111;
            4'hA: hex = 8'b01110111;
            4'hB: hex = 8'b01111100;
            4'hC: hex = 8'b00111001;
            4'hD: hex = 8'b01011110;
            4'hE: hex = 8'b01111001;
            4'hF: hex = 8'b01110001;
        endcase
    end
endmodule

module HexDriver (
    input  logic       clk,
    input  logic       reset,
    input  logic [3:0] in [4],

    output logic [7:0] hex_seg,
    output logic [3:0] hex_grid
);

    logic [7:0] hex [4];

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : g_digit
            nibble_to_hex nibble_to_hex_ (
                .nibble (in[i]),
                .hex    (hex[i])
            );
        end
    endgenerate

    logic [16:0] counter;

    always_ff @(posedge clk) begin
        if (reset)
            counter <= '0;
        else
            counter <= counter + 1;
    end

    always_comb begin
        if (reset) begin
            hex_grid = '1;
            hex_seg  = '1;
        end else begin
            case (counter[16:15])
                2'b00: begin hex_seg = ~hex[0]; hex_grid = 4'b1110; end
                2'b01: begin hex_seg = ~hex[1]; hex_grid = 4'b1101; end
                2'b10: begin hex_seg = ~hex[2]; hex_grid = 4'b1011; end
                2'b11: begin hex_seg = ~hex[3]; hex_grid = 4'b0111; end
            endcase
        end
    end

endmodule
