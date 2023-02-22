// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../WatchClubHandsRenderer.sol";
import "../WatchClubWatchAndStyleRenderer.sol";
import "../PpApRenderer.sol";
import "../interfaces/IWatchClubHandsRenderer.sol";

contract WatchClubWatchAndStyleRendererTest is DSTest {

    WatchClubWatchAndStyleRenderer testRenderer = new WatchClubWatchAndStyleRenderer();

    function setUp() public {
        bytes[] memory oldColors = new bytes[](2);
        oldColors[0] = bytes("#88E3DE");
        oldColors[1] = bytes("#041418");
        bytes[] memory newColors = new bytes[](2);
        newColors[0] = bytes("#465941");
        newColors[1] = bytes("#B4B8B2");
        testRenderer.setColorReplacement(IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN, oldColors, newColors);
    }

    // color replace helper test
    function testColorReplaceHappyTrailing() public {
        string memory actualOutput = testRenderer.colorReplace("123#88E3DE", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "123#465941";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testColorReplaceHappyStarting() public {
        string memory actualOutput = testRenderer.colorReplace("#88E3DE123", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "#465941123";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testColorReplaceHappyOnly() public {
        string memory actualOutput = testRenderer.colorReplace("#88E3DE#041418#041418", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "#465941#B4B8B2#B4B8B2";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testColorReplaceNone() public {
        string memory actualOutput = testRenderer.colorReplace("#88E3DA#04AA18#041AA8", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "#88E3DA#04AA18#041AA8";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testColorReplaceHappyNoneShort() public {
        string memory actualOutput = testRenderer.colorReplace("#88", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "#88";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testColorReplaceHappyNoneEmptyString() public {
        string memory actualOutput = testRenderer.colorReplace("", IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN);
        string memory expectedOutput = "";
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    // render style tests
    function testDressRolexHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.DRESS_ROLEX, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDressHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.DRESS, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testRoundHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.ROUND, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); fill: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testSportHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.SPORT, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); fill: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testTankHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.TANK, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testTankFHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.TANK_F, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testSenatorHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.SENATOR, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 3px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDressDDHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.DRESS_DD, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); fill: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testTrinityHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); fill: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .hand-outer { stroke-width: 4.5px; color: var(--color-hand-outer); } .hand-outer-connection { stroke-width: 2px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testPilotHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.PILOT, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); stroke: currentColor; fill: currentColor; } .hand-outer { color: var(--color-hand-outer); stroke: currentColor; fill: currentColor; } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testAquaHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.AQUA, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); fill: currentColor; } .hand-outer { stroke: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

    function testDauphineHandsStyle() public {
        string memory actualOutput = testRenderer._renderStyle(IWatchClubHandsRenderer.HandType.DAUPHINE, "#E4E4E4", "#E4E4E4", "#F7FDFA");
        // emit log(actualOutput);
        string memory expectedOutput = '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: #E4E4E4; --color-hand-outer: #E4E4E4; --color-hand-inner: #F7FDFA; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); fill: var(--color-hand-inner); } .hand-outer { stroke: var(--color-hand-outer); fill: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
    }

}
