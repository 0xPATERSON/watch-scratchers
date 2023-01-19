// // SPDX-License-Identifier: UNLICENSED
// pragma solidity 0.8.10;

// import "ds-test/test.sol";
// import "../EthereumWatchCoWatchRenderer.sol";
// import "../EthereumWatchCoWatchHandsRenderer.sol";
// import "../PpApRenderer.sol";
// import "../interfaces/IEthereumWatchCoWatchHandsRenderer.sol";

// contract EthereumWatchCoWatchRendererTest is DSTest {

//     EthereumWatchCoWatchRenderer testRenderer = new EthereumWatchCoWatchRenderer();
//     EthereumWatchCoWatchHandsRenderer testHandsRenderer = new EthereumWatchCoWatchHandsRenderer();

//     function setUp() public {
//         bytes[] memory oldColors = new bytes[](2);
//         oldColors[0] = bytes('#88E3DE');
//         oldColors[1] = bytes('#041418');
//         bytes[] memory newColors = new bytes[](2);
//         newColors[0] = bytes('#465941');
//         newColors[1] = bytes('#B4B8B2');
//         testRenderer.setColorReplacement(IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN, oldColors, newColors);
//     }

//     // color replace helper test
//     function testColorReplaceHappyTrailing() public {
//         string memory actualOutput = testRenderer._colorReplace("123#88E3DE", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "123#465941";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testColorReplaceHappyStarting() public {
//         string memory actualOutput = testRenderer._colorReplace("#88E3DE123", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "#465941123";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testColorReplaceHappyOnly() public {
//         string memory actualOutput = testRenderer._colorReplace("#88E3DE#041418#041418", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "#465941#B4B8B2#B4B8B2";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testColorReplaceNone() public {
//         string memory actualOutput = testRenderer._colorReplace("#88E3DA#04AA18#041AA8", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "#88E3DA#04AA18#041AA8";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testColorReplaceHappyNoneShort() public {
//         string memory actualOutput = testRenderer._colorReplace("#88", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "#88";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testColorReplaceHappyNoneEmptyString() public {
//         string memory actualOutput = testRenderer._colorReplace("", IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN);
//         string memory expectedOutput = "";
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }
    
//     // render hands test
//     function testRDressHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2100 2100", "157", "310.7", "#B2B2B2", "#B2B2B2", "#E8E8E8", IEthereumWatchCoWatchHandsRenderer.HandType.DRESS_ROLEX);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2100 2100" x="157" y="310.7"> <style>g, line, circle { --color-accent: #B2B2B2; --color-hand-outer: #B2B2B2; --color-hand-inner: #E8E8E8; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="28" x2="50" y2="40"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="18" x2="50" y2="40"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testRoundHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#B2B2B2", "#B2B2B2", "#E8E8E8", IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #B2B2B2; --color-hand-outer: #B2B2B2; --color-hand-inner: #E8E8E8; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="1.5"/> </g> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testSportHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#B2B2B2", "#B2B2B2", "#E8E8E8", IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #B2B2B2; --color-hand-outer: #B2B2B2; --color-hand-inner: #E8E8E8; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-accent); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <circle class="hand-outer" cx="50" cy="33" r="5"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="50"/> <circle class="hand-inner" cx="50" cy="33" r="3.5"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="65" r="2"/> <circle cx="50" cy="20" r="3"/> <circle class="hand-inner" cx="50" cy="20" r="1.5"/> </g> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testODressHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#B2B2B2", "#B2B2B2", "#E8E8E8", IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #B2B2B2; --color-hand-outer: #B2B2B2; --color-hand-inner: #E8E8E8; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="26.5" x2="50" y2="48.5"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="16.5" x2="50" y2="48.5"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testSenatorHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#0056A5", "#0056A5", "#0056A5", IEthereumWatchCoWatchHandsRenderer.HandType.SENATOR);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #0056A5; --color-hand-outer: #0056A5; --color-hand-inner: #0056A5; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 3px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="12" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="3"/> <circle cx="50" cy="65" r="2"/> </g> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testTankFHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#0056A5", "#0056A5", "#0056A5", IEthereumWatchCoWatchHandsRenderer.HandType.TANK_F);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #0056A5; --color-hand-outer: #0056A5; --color-hand-inner: #0056A5; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }

//     function testTankHands() public {
//         string memory actualOutput = testHandsRenderer.renderHands("0 0 2500 2500", "158.1", "309.7", "#1C55B4", "#1C55B4", "#1C55B4", IEthereumWatchCoWatchHandsRenderer.HandType.TANK);
//         // emit log(actualOutput);
//         string memory expectedOutput = '<svg class="dial" viewBox="0 0 2500 2500" x="158.1" y="309.7"> <style>g, line, circle { --color-accent: #1C55B4; --color-hand-outer: #1C55B4; --color-hand-inner: #1C55B4; -webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } .circle { color: var(--color-hand-outer); } .dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } .dial line { stroke: currentColor; stroke-linecap: round; } .hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="30" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
//         bytes memory actualBytes = bytes(actualOutput);
//         bytes memory expectedBytes = bytes(expectedOutput);
//         assertEq(actualBytes.length, expectedBytes.length);
//         assertEq(keccak256(abi.encodePacked(actualOutput)), keccak256(abi.encodePacked(expectedOutput)));
//     }
// }
