// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../WatchClubRenderer.sol";
import "../WatchClubPersonRenderer.sol";
import "../interfaces/IWatchClubPersonRenderer.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract WatchClubRendererTest is DSTest {

    WatchClubRenderer testRenderer = new WatchClubRenderer();


    function testSplitDnaZero() public {
        uint16[7] memory actualOutput = testRenderer.splitDna(0);
        uint16[7] memory expectedOutput;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    function testSplitDnaLowNumber() public {
        uint16[7] memory actualOutput = testRenderer.splitDna(9);
        uint16[7] memory expectedOutput;
        expectedOutput[0] = 9;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    function testSplitDnaRealistic() public {
        uint16[7] memory actualOutput = testRenderer.splitDna(77556791590383325132439153495973134093244746956003644054096759101232413273441);
        uint16[7] memory expectedOutput;
        expectedOutput[0] = 441;
        expectedOutput[1] = 73;
        expectedOutput[2] = 32;
        expectedOutput[3] = 41;
        expectedOutput[4] = 32;
        expectedOutput[5] = 12;
        expectedOutput[6] = 10;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    function testGetTrait() public {
        uint8[10] memory test_weights = [14, 28, 0, 42, 56, 70, 84, 0, 99, 0];
        uint16[7] memory test_dna_split = [555,73,32,41,32,12,10];
        assertEq(testRenderer._getTraitNumberFromWeightsArray(test_weights, test_dna_split[1]), 6);
    }

    function testGetWatchType() public {
        assertEq(testRenderer._getWatchType(69), 12);
    }
}
