//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWatchClubTraitParser {
    function getTraitName(uint256 category, uint16 trait) external view returns (string memory);

    function getCategoryName(uint256 category) external pure returns (string memory);
}