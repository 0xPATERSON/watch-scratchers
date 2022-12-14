//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEthereumWatchCoRenderer {

    function tokenURI(uint256 tokenId, uint256 dna) external view returns (string memory);
}