// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../WatchClubRenderer.sol";
import "../WatchClubTraitParser.sol";
import "../interfaces/IWatchClubTraitParser.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract WatchClubTraitParserTest is DSTest {

    WatchClubTraitParser traitParser = new WatchClubTraitParser();

    function testGetTraitName() public {
        string memory actualOutput = traitParser.getTraitName(0, 39);
        string memory expectedOutput = 'explorer';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testGetCategoryName() public {
        string memory actualOutput = traitParser.getCategoryName(0);
        string memory expectedOutput = 'watch';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }
    
}
