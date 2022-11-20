//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEthereumWatchCoWatchRenderer {
    enum WatchType { 
        // 0
        PP_TIFFANY, PP_BLUE, PP_GREEN, PP_WHITE, PP_CHOCOLATE,
        // 5
        AP_WHITE, AP_BLUE, AP_GREY, AP_BLACK, AP_BLUE_RG, AP_BLACK_RG, AP_BLUE_YG,
        // 12
        VC_BLUE, VC_BLACK, VC_WHITE, VC_BLUE_RG,
        // 16
        SUB_BLACK, SUB_GREEN, SUB_BLUE, SUB_GREEN_BLACK, SUB_BLUE_BLACK, SUB_BLACK_TT, SUB_BLUE_TT, SUB_BLACK_YG, SUB_BLUE_YG,
        // 25
        YACHT_RHODIUM, YACHT_BLUE,
        // 27
        OP_YELLOW, OP_GREEN, OP_CORAL, OP_TIFFANY, OP_PINK, OP_BLACK, OP_BLUE,
        // 34
        DJ_WHITE, DJ_BLUE, DJ_RHODIUM, DJ_BLACK, DJ_WHITE_TT, DJ_RHODIUM_TT, DJ_CHAMPAGNE_TT,
        // 41
        EXP, EXP_TT,
        // 43
        DD_WHITE_YG, DD_CHAMPAGNE_YG, DD_BLACK_YG, DD_OLIVE_RG, DD_CHOCOLATE_RG, DD_WHITE_RG, DD_ICE_P, DD_OLIVE_P,
        // 51
        AQ_WHITE, AQ_BLUE, AQ_GREY, AQ_BLACK,
        // 55
        PILOT_BLACK, PILOT_WHITE, PILOT_BLUE, PILOT_TG, 
        // 59
        SENATOR,
        // 60
        GS,
        // 61
        TANK, TANK_RG, TANK_YG,
        // 64
        TANK_F, TANK_F_RG, TANK_F_YG
    }

    function renderWatch(WatchType watchType)
        external
        view
        returns (string memory);
        
}