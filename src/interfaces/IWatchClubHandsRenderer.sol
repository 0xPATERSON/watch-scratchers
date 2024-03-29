//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWatchClubHandsRenderer {
    enum HandType { DRESS_ROLEX, DRESS, ROUND, SPORT, TANK, TANK_F, SENATOR, DRESS_DD, TRINITY, PILOT, AQUA, DAUPHINE }

    function renderHands(
        string memory viewBox,
        string memory x, 
        string memory y,
        HandType handType
    ) external pure returns (string memory);
}