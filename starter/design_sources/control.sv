// Control FSM

module control (
    input  logic       Clk,
    input  logic       Reset,
    input  logic       LoadA,
    input  logic       LoadB,
    input  logic       Execute,
    input  logic [2:0] op,

    output logic       Ld_A,
    output logic       Ld_B,
    output logic       Shift_En,
    output logic       Ld_Out
);

    enum logic [2:0] {
        s_start
        // add the other states for your logic here
    } curr_state, next_state;

    // Outputs
    always_comb begin //these are the control signals that we are sending out in the FSM. THink of what to do 
        Ld_A     = 1'b0;
        Ld_B     = 1'b0;
        Shift_En = 1'b0;
        Ld_Out   = 1'b0;

        case (curr_state)
            s_start: begin
                Ld_A = LoadA;
                Ld_B = LoadB;
            end
            // add the outputs for your other states
            default: ;
        endcase
    end

    // Next state
    always_comb begin
        next_state = curr_state;

        case (curr_state)
            s_start: begin
                // write here your logic for execut
            end
            // write here how to transition to your next states think in terms of the states and clock
            default: next_state = s_start;
        endcase
    end

    // State register
    always_ff @(posedge Clk) begin
        if (Reset)
            curr_state <= s_start;
        else
            curr_state <= next_state;
    end

endmodule
