module controller (
    input  logic       clk,
    input  logic       reset,
    input  logic [6:0] op,
    input  logic [2:0] funct3,
    input  logic       funct7b5,
    input  logic       zero,
    output logic [1:0] immsrc,
    output logic [1:0] alusrca, alusrcb,
    output logic [1:0] resultsrc,
    output logic       adrsrc,
    output logic [2:0] alucontrol,
    output logic       irwrite, pcwrite,
    output logic       regwrite, memwrite
);

    // Ara bağlantı kabloları (Figure 1'e göre)
    logic [1:0] aluop;
    logic       branch, pcupdate;

    // 1. Main FSM Bağlantısı
    mainfsm fsm (
        .clk(clk), .reset(reset), .op(op),
        .adrsrc(adrsrc), .irwrite(irwrite), .regwrite(regwrite), .memwrite(memwrite),
        .branch(branch), .pcupdate(pcupdate),
        .alusrca(alusrca), .alusrcb(alusrcb), .resultsrc(resultsrc), .aluop(aluop)
    );

    // 2. ALU Decoder Bağlantısı
    aludec ad (
        .opb5(op[5]), .funct3(funct3), .funct7b5(funct7b5),
        .ALUOp(aluop), .ALUControl(alucontrol)
    );

    // 3. Instruction Decoder Bağlantısı
    instrdec id (
        .op(op), .ImmSrc(immsrc)
    );

    // 4. PCWrite Mantığı (Figure 1'deki AND-OR kapısı) [cite: 101]
    assign pcwrite = (branch & zero) | pcupdate;

endmodule