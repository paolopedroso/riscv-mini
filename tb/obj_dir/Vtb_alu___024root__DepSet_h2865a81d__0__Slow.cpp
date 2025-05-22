// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_alu.h for the primary calling header

#include "Vtb_alu__pch.h"
#include "Vtb_alu___024root.h"

VL_ATTR_COLD void Vtb_alu___024root___eval_static(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vtb_alu___024root___eval_final(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__stl(Vtb_alu___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtb_alu___024root___eval_phase__stl(Vtb_alu___024root* vlSelf);

VL_ATTR_COLD void Vtb_alu___024root___eval_settle(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vtb_alu___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("tb_alu.sv", 10, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtb_alu___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__stl(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void Vtb_alu___024root___act_sequent__TOP__0(Vtb_alu___024root* vlSelf);

VL_ATTR_COLD void Vtb_alu___024root___eval_stl(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vtb_alu___024root___act_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vtb_alu___024root___eval_triggers__stl(Vtb_alu___024root* vlSelf);

VL_ATTR_COLD bool Vtb_alu___024root___eval_phase__stl(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtb_alu___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vtb_alu___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__act(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_alu___024root___dump_triggers__nba(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_alu___024root___ctor_var_reset(Vtb_alu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_alu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_alu___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->tb_alu__DOT__rs1_data = VL_RAND_RESET_I(16);
    vlSelf->tb_alu__DOT__rs2_data = VL_RAND_RESET_I(16);
    vlSelf->tb_alu__DOT__imm = VL_RAND_RESET_I(6);
    vlSelf->tb_alu__DOT__op = VL_RAND_RESET_I(3);
    vlSelf->tb_alu__DOT__func4 = VL_RAND_RESET_I(4);
    vlSelf->tb_alu__DOT__alu_o = VL_RAND_RESET_I(16);
    }
