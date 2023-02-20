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
        uint16[7] memory test_dna_split = [555,73,32,41,32,12,10];
        // glasses
        assertEq(testRenderer._getTraitIndex(2, test_dna_split[2], 0), 1);
        // earphones
        assertEq(testRenderer._getTraitIndex(3, test_dna_split[3], 0), 1);
        // shirt
        assertEq(testRenderer._getTraitIndex(4, test_dna_split[4], 0), 2);
        // mouth
        assertEq(testRenderer._getTraitIndex(5, test_dna_split[5], 0), 0);
        // background
        assertEq(testRenderer._getTraitIndex(6, test_dna_split[6], 0), 0);
        // hat (with shirt index 2)
        assertEq(testRenderer._getTraitIndex(1, test_dna_split[1], 2), 6);
    }

    function testGetWatchType() public {
        // watch is 555: TANK_RG
        assertEq(testRenderer._getTraitIndex(0, 555, 0), 59);
    }

    function testRenderScript() public {
        // watch is 555: TANK_RG
        string memory actualOutput = testRenderer.renderScript(77556791590383325132439153495973134093244746956003644054096759101232413273555);
        // emit log(actualOutput);
        string memory expectedOutput = '<script> let style = document.getElementById("mainStyle"); let date = new Date(); let hours = date.getHours(); let minutes = date.getMinutes(); let seconds = date.getSeconds(); let secondsDeg = seconds * 6 - 175; let minutesDeg = minutes * 6 + seconds * 0.1 - 175; let hoursDeg = hours * 30 + minutes * 0.5 - 175; style.innerHTML += `#closeButton { display: none; } #watch, #watchHands { cursor: pointer; pointer-events: bounding-box; }`;style.innerHTML += `@keyframes rotateSecondHand { from { -webkit-transform: rotate(${secondsDeg}deg); -moz-transform: rotate(${secondsDeg}deg); -ms-transform: rotate(${secondsDeg}deg); -o-transform: rotate(${secondsDeg}deg); transform: rotate(${secondsDeg}deg); } to { -webkit-transform: rotate(${secondsDeg + 360}deg); -moz-transform: rotate(${secondsDeg + 360}deg); -ms-transform: rotate(${secondsDeg + 360}deg); -o-transform: rotate(${secondsDeg + 360}deg); transform: rotate(${secondsDeg + 360}deg); }} @keyframes rotateMinuteHand { from { -webkit-transform: rotate(${minutesDeg}deg); -moz-transform: rotate(${minutesDeg}deg); -ms-transform: rotate(${minutesDeg}deg); -o-transform: rotate(${minutesDeg}deg); transform: rotate(${minutesDeg}deg); } to { -webkit-transform: rotate(${minutesDeg + 360}deg); -moz-transform: rotate(${minutesDeg + 360}deg); -ms-transform: rotate(${minutesDeg + 360}deg); -o-transform: rotate(${minutesDeg + 360}deg); transform: rotate(${minutesDeg + 360}deg); }} @keyframes rotateHourHand { from { -webkit-transform: rotate(${hoursDeg}deg); -moz-transform: rotate(${hoursDeg}deg); -ms-transform: rotate(${hoursDeg}deg); -o-transform: rotate(${hoursDeg}deg); transform: rotate(${hoursDeg}deg); } to { -webkit-transform: rotate(${hoursDeg + 360}deg); -moz-transform: rotate(${hoursDeg + 360}deg); -ms-transform: rotate(${hoursDeg + 360}deg); -o-transform: rotate(${hoursDeg + 360}deg); transform: rotate(${hoursDeg + 360}deg); }}`; let watch = document.getElementById("watch");let watchHands = document.getElementById("watchHands");let closeButton = document.getElementById("closeButton");let onWristWatchViewBox = watch.getAttribute("viewBox");let onWristWatchX = watch.getAttribute("x");let onWristWatchY = watch.getAttribute("y");let onWristHandsViewBox = watchHands.getAttribute("viewBox");let onWristHandsX = watchHands.getAttribute("x");let onWristHandsY = watchHands.getAttribute("y"); function onClick() { style.innerHTML += `#person { display: none; } #watch, #watchHands { cursor: default; } svg { -webkit-transform: rotate(175deg) scale(5); -moz-transform: rotate(175deg) scale(5); -ms-transform: rotate(175deg) scale(5); -o-transform: rotate(175deg) scale(5); transform: rotate(175deg) scale(5); } #closeButton, #background { -webkit-transform: rotate(-175deg) scale(0.2); -moz-transform: rotate(-175deg) scale(0.2); -ms-transform: rotate(-175deg) scale(0.2); -o-transform: rotate(-175deg) scale(0.2); transform: rotate(-175deg) scale(0.2); } #closeButton { cursor: pointer; display: block; pointer-events: bounding-box; }`; watch.setAttribute("x", "174.5"); watch.setAttribute("y", "170"); watchHands.setAttribute("x", "182"); watchHands.setAttribute("y", "182.75"); } function onClose() { style.innerHTML += `#closeButton { display: none; } svg, #background { -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); } #person { display: inline; } #watch, #watchHands { cursor: pointer; }`; watch.setAttribute("viewBox", onWristWatchViewBox); watch.setAttribute("x", onWristWatchX); watch.setAttribute("y", onWristWatchY); watchHands.setAttribute("viewBox", onWristHandsViewBox); watchHands.setAttribute("x", onWristHandsX); watchHands.setAttribute("y", onWristHandsY); } watch.addEventListener("click", onClick); watchHands.addEventListener("click", onClick); closeButton.addEventListener("click", onClose); </script> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }
}
