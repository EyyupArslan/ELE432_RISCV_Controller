module instrdec (
    input  logic [6:0] op,
    output logic [1:0] ImmSrc
);
    always_comb
        case (op)
            7'b0110011: ImmSrc = 2'b00; // R-type (Don't care yerine 0) [cite: 15, 242]
            7'b0010011: ImmSrc = 2'b00; // I-type ALU [cite: 242]
            7'b0000011: ImmSrc = 2'b00; // lw [cite: 242]
            7'b0100011: ImmSrc = 2'b01; // sw [cite: 242]
            7'b1100011: ImmSrc = 2'b10; // beq [cite: 242]
            7'b1101111: ImmSrc = 2'b11; // jal [cite: 242]
            default:    ImmSrc = 2'b00; // Deterministic value [cite: 15]
        endcase
endmodule