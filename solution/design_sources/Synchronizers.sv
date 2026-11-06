// Synchronizer and debouncer for buttons and switches

`ifdef SYNTHESIS
localparam COUNTER_WIDTH = 15;
`else
localparam COUNTER_WIDTH = 1;
`endif

module sync_debounce (
    input  logic Clk,
    input  logic d,

    output logic q
);

    logic ff1, ff2;
    logic [COUNTER_WIDTH:0] counter;

    always_ff @(posedge Clk) begin
        ff1 <= d;
        ff2 <= ff1;

        if (~(ff1 ^ ff2)) begin
            if (~counter[COUNTER_WIDTH])
                counter <= counter + 1'b1;
            else
                q <= ff2;
        end else begin
            counter <= '0;
        end
    end

endmodule
