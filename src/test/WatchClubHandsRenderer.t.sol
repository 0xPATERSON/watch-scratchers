// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../WatchClubHandsRenderer.sol";
import "../WatchClubWatchAndStyleRenderer.sol";
import "../PpApRenderer.sol";
import "../interfaces/IWatchClubHandsRenderer.sol";

contract WatchClubHandsRendererTest is DSTest {

    WatchClubHandsRenderer testHandsRenderer = new WatchClubHandsRenderer();
    
    function testDressRolexHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.DRESS_ROLEX);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="27" x2="50" y2="40"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="17" x2="50" y2="40"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDressHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.DRESS);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="26.5" x2="50" y2="48.5"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="16.5" x2="50" y2="48.5"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testRoundHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.ROUND);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"></line> <circle class="circle" cx="50" cy="50" r="1.5"/> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testSportHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.SPORT);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="50"></line> <circle class="hand-outer circle" cx="50" cy="33" r="5"></circle> <line class="hand-inner" x1="50" y1="27" x2="50" y2="50"></line> <circle fill="var(--color-hand-inner)" cx="50" cy="33" r="3.5"></circle> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="17" x2="50" y2="50"></line> </g> <circle class="circle" cx="50" cy="50" r="4"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="65" r="2"></circle> <circle class="circle" cx="50" cy="20" r="3"></circle> <circle fill="var(--color-hand-inner)" cx="50" cy="20" r="1.5"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }
    
    function testTankHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.TANK);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="30" y2="50"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"></line> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testTankFHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.TANK_F);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="17" y2="50"></line> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testSenatorHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.SENATOR);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="12" y2="50"></line> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"></line> <line x1="47.5" x2="52.5" y1="65" y2="65"></line> <line x1="47.5" x2="52.5" y1="62.5" y2="62.5"></line> <circle class="circle" cx="50" cy="50" r="3"/> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDaydateHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.DRESS_DD);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="26.5" x2="50" y2="58.5"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="16.5" x2="50" y2="58.5"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testTrinityHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.TRINITY);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="43"></line> <line class="hand-inner" x1="50" y1="25" x2="50" y2="43"></line> <line class="hand hand-outer-connection" x1="50" y1="45.5" x2="50" y2="50"></line> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" y1="15" x2="50" y2="43"></line> <line class="hand-inner" x1="50" y1="15" x2="50" y2="43"></line> <line class="hand hand-outer-connection" x1="50" y1="45.5" x2="50" y2="50"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testPilotHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.PILOT);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <path d="M53 41.527L52 49.5H48L47 41.527L50 20L53 41.527Z" class="hand-outer" stroke-width="2"/><path d="M52 41.5269L51 48H49L48 41.5269L50 27.335L52 41.5269Z" class="hand-inner"/> </g> <g class="hand minute-hand"> <path d="M53 38.1567L51.8 49.5H48.2L47 38.1567L50 9.5L53 38.1567Z" class="hand-outer" stroke-width="2"/> <path d="M51.5 38.2001L50.5 48.0453H49.5L48.5 38.2001L50 23.9001L51.5 38.2001Z" class="hand-inner"/> </g> <circle fill="var(--color-hand-outer)" cx="50" cy="50" r="4"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle fill="var(--color-accent)" cx="50" cy="50" r="2"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testAquaHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.AQUA);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <path d="M50 24L53 48.8108L50.5 56H49.5L47 48.8108L50 24Z" class="hand-outer" stroke-width="2"/> <path d="M50 32.4536L52 48.8105L50.05 54.6665H49.95L48 48.8105L50 32.4536Z" class="hand-inner"/> </g> <g class="hand minute-hand"> <path d="M52.5 49.675L50.5 56H49.5L47.5 49.675L50 12.875L52.5 49.675Z" class="hand-outer" fill="var(--color-hand-inner)" stroke-width="2"/> <path d="M46.7482 20.2125L50 12.5576L53.2518 20.2125H46.7482Z" class="hand-inner" stroke="var(--color-hand-outer)" stroke-width="2"/> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle fill="var(--color-accent)" cx="50" cy="50" r="2"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDauphineHands() public {
        string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", IWatchClubHandsRenderer.HandType.DAUPHINE);
        // emit log(actualOutput);
        string memory expectedOutput = '<svg id="watchHands" class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <g id="hands-container"> <g class="hand hour-hand"> <path d="M50 24L53 48.8108L50.5 56H49.5L47 48.8108L50 24Z" class="hand-outer" stroke-width="1"/> <path d="M50 32.4536L52 48.8105L50.05 54.6665H49.95L48 48.8105L50 32.4536Z" class="hand-inner"/> </g> <g class="hand minute-hand"> <path d="M50 10L53 45.6655L50.5 56H49.5L47 45.6655L50 10Z" class="hand-outer" stroke-width="1"/><path d="M50 22.1521L52 45.6651L50.05 54.0831H49.95L48 45.6651L50 22.1521Z" class="hand-inner" /> </g> <circle fill="var(--color-accent)" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle class="circle" cx="50" cy="50" r="1.5"></circle> </g> </g> </svg> ';
        bytes memory actualBytes = bytes(actualOutput);
        bytes memory expectedBytes = bytes(expectedOutput);
        assertEq(actualBytes.length, expectedBytes.length);
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }
}
