// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../EthereumWatchCoRenderer.sol";
import "../EthereumWatchCoPersonRenderer.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract EthereumWatchCoRendererTest is DSTest {

    EthereumWatchCoRenderer testRenderer = new EthereumWatchCoRenderer();


    function testSplitDnaZero() public {
        uint8[8] memory actualOutput = testRenderer.splitDna(0);
        uint8[8] memory expectedOutput;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    function testSplitDnaLowNumber() public {
        uint8[8] memory actualOutput = testRenderer.splitDna(9);
        uint8[8] memory expectedOutput;
        expectedOutput[0] = 9;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    function testSplitDnaRealistic() public {
        uint8[8] memory actualOutput = testRenderer.splitDna(77556791590383325132439153495973134093244746956003644054096759101232413273441);
        uint8[8] memory expectedOutput;
        expectedOutput[0] = 41;
        expectedOutput[1] = 34;
        expectedOutput[2] = 27;
        expectedOutput[3] = 13;
        expectedOutput[4] = 24;
        expectedOutput[5] = 23;
        expectedOutput[6] = 1;
        expectedOutput[7] = 91;
        for (uint256 i = 0; i < actualOutput.length; i++) {
            // emit log(Strings.toString(actualOutput[i]));
            assertEq(actualOutput[i], expectedOutput[i]);
        }
    }

    

}
