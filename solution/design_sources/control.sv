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
        s_start,
        s_shift0,
        s_shift1,
        s_shift2,
        s_shift3,
        s_done
    } curr_state, next_state;

    always_comb begin
        Ld_A     = 1'b0;
        Ld_B     = 1'b0;
        Shift_En = 1'b0;
        Ld_Out   = 1'b0;

        case (curr_state)
            s_start: begin
                Ld_A = LoadA;
                Ld_B = LoadB;
            end
            s_shift0, s_shift1, s_shift2, s_shift3:
                Shift_En = 1'b1;
            s_done:
                Ld_Out = 1'b1;
            default: ;
        endcase
    end

    always_comb begin
        next_state = curr_state;

        case (curr_state)
            s_start: begin
                if (Execute) begin
                    if (op[2])
                        next_state = s_shift0;
                    else
                        next_state = s_done;
                end
            end
            s_shift0: next_state = s_shift1;
            s_shift1: next_state = s_shift2;
            s_shift2: next_state = s_shift3;
            s_shift3: next_state = s_done;
            s_done:   if (~Execute) next_state = s_start;
            default:  next_state = s_start;
        endcase
    end

    always_ff @(posedge Clk) begin
        if (Reset)
            curr_state <= s_start;
        else
            curr_state <= next_state;
    end

endmodule
