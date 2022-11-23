//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEthereumWatchCoWatchHandsRenderer {
    enum HandType { DRESS_ROLEX, DRESS, ROUND, SPORT, TANK, TANK_F, SENATOR, DRESS_DD }
    // 
    enum TimeZoneType { 
        MINUS_12, MINUS_11, MINUS_10,  MINUS_9, MINUS_8, MINUS_7, MINUS_6, MINUS_5, 
        MINUS_4,  MINUS_3, MINUS_2, MINUS_1, UTC, PLUS_1, PLUS_2, PLUS_3,  PLUS_4,  PLUS_5,   
        PLUS_6,  PLUS_7, PLUS_8,  PLUS_9,  PLUS_10,  PLUS_11, PLUS_12, PLUS_13, PLUS_14,
        MINUS_930, MINUS_330, PLUS_330, PLUS_430, PLUS_530, PLUS_545, PLUS_630, PLUS_845, 
        PLUS_930, PLUS_1030, PLUS_1345
    }

    function renderHands(
        string memory viewBox,
        string memory x, 
        string memory y, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor,
        uint256 secondHandPos,
        uint256 minuteHandPos,
        uint256 hourHandPos,
        HandType handType
    ) external pure returns (string memory);
}