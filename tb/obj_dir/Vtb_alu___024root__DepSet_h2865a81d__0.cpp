// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_alu.h for the primary calling header

#include "Vtb_alu__pch.h"
#include "Vtb_alu___024root.h"

VlCoroutine Vtb_alu___024root___eval_initial__TOP__Vtiming__0(Vtb_alu___024root* vlSelf);

void Vtb_alu___024root___eval_initial(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_initial\n"); );
    // Body
    Vtb_alu___024root___eval_initial__TOP__Vtiming__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vtb_alu___024root___eval_initial__TOP__Vtiming__0(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Body
    vlSelf->tb_alu__DOT__rs1_data = 0U;
    vlSelf->tb_alu__DOT__rs2_data = 0U;
    vlSelf->tb_alu__DOT__imm = 0U;
    vlSelf->tb_alu__DOT__op = 0U;
    vlSelf->tb_alu__DOT__func4 = 0U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "tb_alu.sv", 
                                       26);
    VL_WRITEF("Testing ALU unit...\nAdding 3 + 3...\n");
    vlSelf->tb_alu__DOT__rs1_data = 3U;
    vlSelf->tb_alu__DOT__rs2_data = 3U;
    vlSelf->tb_alu__DOT__op = 0U;
    vlSelf->tb_alu__DOT__func4 = 0U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "tb_alu.sv", 
                                       37);
    if ((6U != (IData)(vlSelf->tb_alu__DOT__alu_o))) {
        VL_WRITEF("E: ALU ADD incorrect! alu_o=%0#\n",
                  16,vlSelf->tb_alu__DOT__alu_o);
    } else {
        VL_WRITEF("ALU ADD Pass!\n");
    }
    VL_WRITEF("Subtracting 5 - 4...\n");
    vlSelf->tb_alu__DOT__rs1_data = 5U;
    vlSelf->tb_alu__DOT__rs2_data = 4U;
    vlSelf->tb_alu__DOT__func4 = 1U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "tb_alu.sv", 
                                       50);
    if ((1U != (IData)(vlSelf->tb_alu__DOT__alu_o))) {
        VL_WRITEF("E: ALU SUB incorrect! alu_o=%0#\n",
                  16,vlSelf->tb_alu__DOT__alu_o);
    } else {
        VL_WRITEF("ALU SUB Pass!\n");
    }
    VL_WRITEF("Inverting 2...\n");
    vlSelf->tb_alu__DOT__rs1_data = 2U;
    vlSelf->tb_alu__DOT__rs2_data = 0U;
    vlSelf->tb_alu__DOT__func4 = 2U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "tb_alu.sv", 
                                       63);
    if ((0xfffdU != (IData)(vlSelf->tb_alu__DOT__alu_o))) {
        VL_WRITEF("E: ALU INV incorrect! alu_o=%0#\n",
                  16,vlSelf->tb_alu__DOT__alu_o);
    } else {
        VL_WRITEF("ALU INV Pass!\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "tb_alu.sv", 
                                       80);
    VL_FINISH_MT("tb_alu.sv", 81, "");
}

VL_INLINE_OPT void Vtb_alu___024root___act_sequent__TOP__0(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___act_sequent__TOP__0\n"); );
    // Init
    SData/*15:0*/ tb_alu__DOT__dut__DOT__operand_b;
    tb_alu__DOT__dut__DOT__operand_b = 0;
    SData/*15:0*/ tb_alu__DOT__dut__DOT__imm_ex;
    tb_alu__DOT__dut__DOT__imm_ex = 0;
    // Body
    tb_alu__DOT__dut__DOT__imm_ex = ((0xffc0U & ((- (IData)(
                                                            (1U 
                                                             & ((IData)(vlSelf->tb_alu__DOT__imm) 
                                                                >> 5U)))) 
                                                 << 6U)) 
                                     | (IData)(vlSelf->tb_alu__DOT__imm));
    tb_alu__DOT__dut__DOT__operand_b = ((1U == (IData)(vlSelf->tb_alu__DOT__op))
                                         ? (IData)(tb_alu__DOT__dut__DOT__imm_ex)
                                         : (IData)(vlSelf->tb_alu__DOT__rs2_data));
    vlSelf->tb_alu__DOT__alu_o = ((8U & (IData)(vlSelf->tb_alu__DOT__func4))
                                   ? 0U : (0xffffU 
                                           & ((4U & (IData)(vlSelf->tb_alu__DOT__func4))
                                               ? ((2U 
                                                   & (IData)(vlSelf->tb_alu__DOT__func4))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(vlSelf->tb_alu__DOT__func4))
                                                    ? 
                                                   (((IData)(vlSelf->tb_alu__DOT__rs1_data) 
                                                     < (IData)(tb_alu__DOT__dut__DOT__operand_b))
                                                     ? 1U
                                                     : 0U)
                                                    : 
                                                   ((IData)(vlSelf->tb_alu__DOT__rs1_data) 
                                                    | (IData)(tb_alu__DOT__dut__DOT__operand_b)))
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelf->tb_alu__DOT__func4))
                                                    ? 
                                                   ((IData)(vlSelf->tb_alu__DOT__rs1_data) 
                                                    & (IData)(tb_alu__DOT__dut__DOT__operand_b))
                                                    : 
                                                   VL_SHIFTR_III(16,16,16, (IData)(vlSelf->tb_alu__DOT__rs1_data), (IData)(tb_alu__DOT__dut__DOT__operand_b))))
                                               : ((2U 
                                                   & (IData)(vlSelf->tb_alu__DOT__func4))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(vlSelf->tb_alu__DOT__func4))
                                                    ? 
                                                   VL_SHIFTL_III(16,16,16, (IData)(vlSelf->tb_alu__DOT__rs1_data), (IData)(tb_alu__DOT__dut__DOT__operand_b))
                                                    : 
                                                   (~ (IData)(vlSelf->tb_alu__DOT__rs1_data)))
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelf->tb_alu__DOT__func4))
                                                    ? 
                                                   ((IData)(vlSelf->tb_alu__DOT__rs1_data) 
                                                    - (IData)(tb_alu__DOT__dut__DOT__operand_b))
                                                    : 
                                                   ((IData)(vlSelf->tb_alu__DOT__rs1_data) 
                                                    + (IData)(tb_alu__DOT__dut__DOT__operand_b)))))));
}

void Vtb_alu___024root___eval_act(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vtb_alu___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vtb_alu___024root___eval_nba(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_alu___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vtb_alu___024root___timing_resume(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vtb_alu___024root___eval_triggers__act(Vtb_alu___024root* vlSelf);

bool Vtb_alu___024root___eval_phase__act(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtb_alu___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vtb_alu___024root___timing_resume(vlSelf);
        Vtb_alu___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtb_alu___024root___eval_phase__nba(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtb_alu___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__nba(Vtb_alu___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__act(Vtb_alu___024root* vlSelf);
#endif  // VL_DEBUG

void Vtb_alu___024root___eval(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtb_alu___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("tb_alu.sv", 10, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vtb_alu___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("tb_alu.sv", 10, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vtb_alu___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vtb_alu___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtb_alu___024root___eval_debug_assertions(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
