// Vortex instructions definitions

def OPC_VORTEX : RISCVOpcode<0b0000110>;

let hasSideEffects = 1, mayStore = 1 , mayLoad = 1 in {

def VX_TMC : RVInstS<0, OPC_VORTEX, (outs), (ins GPR:$rs1), "vx_tmc", "$rs1">, Sched<[]> {
    let rs2   = 0;
    let imm12 = 0;
}

def VX_PRED : RVInstS<0, OPC_VORTEX, (outs), (ins GPR:$rs1), "vx_pred", "$rs1">, Sched<[]> {
    let rs2   = 1;
    let imm12 = 0;
}

def VX_SPLIT : RVInstS<2, OPC_VORTEX, (outs), (ins GPR:$rs1), "vx_split", "$rs1">, Sched<[]> {
    let rs2   = 0;
    let imm12 = 0;
}

def VX_JOIN : RVInstS<3, OPC_VORTEX, (outs), (ins), "vx_join", "">, Sched<[]> {
    let rs1   = 0;
    let rs2   = 0;
    let imm12 = 0;
}
}

def CSR_TMASK : SysReg<"tmask", 0xCC4>;

def : Pat<(int_riscv_vx_tmask), (CSRRS CSR_TMASK.Encoding, X0)>;

def : Pat<(int_riscv_vx_tmc i32:$rs1), (VX_TMC GPR:$rs1)>;

def : Pat<(int_riscv_vx_pred i32:$rs1), (VX_PRED GPR:$rs1)>;

def : Pat<(int_riscv_vx_split i32:$rs1), (VX_SPLIT GPR:$rs1)>;

def : Pat<(int_riscv_vx_join), (VX_JOIN)>;