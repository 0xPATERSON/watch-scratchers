// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../WatchClub.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract WatchClubTraitParserTest is DSTest {

    WatchClub watchClub = new WatchClub();

    function testSetDna() public {
        uint256 dnaWithoutWatch = 77556791590383325132439153495973134093244746956003644054096759101232413273125;
        uint256 testTokenId = 123;
        uint256 testSeed = 12345678;
        uint256 watchDna =  uint256(
            keccak256(
                abi.encodePacked(
                    testTokenId,
                    block.coinbase,
                    block.timestamp,
                    testSeed
                )
            )
        ) % 570;
        emit log(Strings.toString(watchDna));
        uint256 actualOutput = watchClub.setDna(dnaWithoutWatch, watchDna);
        assertEq(actualOutput % 1000, watchDna);
    }
}
