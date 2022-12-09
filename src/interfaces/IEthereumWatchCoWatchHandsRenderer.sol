//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEthereumWatchCoWatchHandsRenderer {
    enum HandType { DRESS_ROLEX, DRESS, ROUND, SPORT, TANK, TANK_F, SENATOR, DRESS_DD }

    function renderHands(
        string memory viewBox,
        string memory x, 
        string memory y, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor,
        HandType handType
    ) external pure returns (string memory);
}