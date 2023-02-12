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
        uint16[64] memory test_weights = [
            2, 8, 14, 20, 25,  // PP
            31, 37, 43, 49, 54, 59, 62,  // AP
            69, 76, 83, 89,  // VC
            107, 125, 135, 153, 163, 173, 183, 193, 203,  // SUB
            211, 219,  // YACHT
            231, 243, 255, 267, 272, 284, 296,  // OP
            308, 320, 332, 344, 354,  // DJ
            364, 374,  // EXP
            384, 394, 404, 412, 420, 425, 430,  // DD
            445, 460, 475, 490,  // AQUA
            500, 510, 520, 525,  // PILOT
            527,  // SENATOR
            537,  // GS
            547, 555, 563,  // TANK
            565, 567, 569  // TANK F
        ];
        assertEq(testRenderer._getWatchType(test_weights, 69), 12);
    }
}
