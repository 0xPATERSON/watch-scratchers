//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IEthereumWatchCoWatchHandsRenderer.sol";

contract EthereumWatchCoWatchHandsRenderer is IEthereumWatchCoWatchHandsRenderer {
    // [hour, minutes, minus/plus (0/1)]
    uint256[3][38] public hourAndMinuteAdjustments;
    constructor() {
        // minuses
        hourAndMinuteAdjustments[0] = [12, 0, 0];
        hourAndMinuteAdjustments[1] = [11, 0, 0];
        hourAndMinuteAdjustments[2] = [10, 0, 0];
        hourAndMinuteAdjustments[3] = [9, 0, 0];
        hourAndMinuteAdjustments[4] = [8, 0, 0];
        hourAndMinuteAdjustments[5] = [7, 0, 0];
        hourAndMinuteAdjustments[6] = [6, 0, 0];
        hourAndMinuteAdjustments[7] = [5, 0, 0];
        hourAndMinuteAdjustments[8] = [4, 0, 0];
        hourAndMinuteAdjustments[9] = [3, 0, 0];
        hourAndMinuteAdjustments[10] = [2, 0, 0];
        hourAndMinuteAdjustments[11] = [1, 0, 0];
        // utc
        hourAndMinuteAdjustments[12] = [0, 0, 1];
        // pluses
        hourAndMinuteAdjustments[13] = [1, 0, 1];
        hourAndMinuteAdjustments[14] = [2, 0, 1];
        hourAndMinuteAdjustments[15] = [3, 0, 1];
        hourAndMinuteAdjustments[16] = [4, 0, 1];
        hourAndMinuteAdjustments[17] = [5, 0, 1];
        hourAndMinuteAdjustments[18] = [6, 0, 1];
        hourAndMinuteAdjustments[19] = [7, 0, 1];
        hourAndMinuteAdjustments[20] = [8, 0, 1];
        hourAndMinuteAdjustments[21] = [9, 0, 1];
        hourAndMinuteAdjustments[22] = [10, 0, 1];
        hourAndMinuteAdjustments[23] = [11, 0, 1];
        hourAndMinuteAdjustments[24] = [12, 0, 1];
        hourAndMinuteAdjustments[25] = [13, 0, 1];
        hourAndMinuteAdjustments[26] = [14, 0, 1];
        // fractionals
        hourAndMinuteAdjustments[27] = [9, 30, 0];
        hourAndMinuteAdjustments[28] = [3, 30, 0];
        hourAndMinuteAdjustments[29] = [3, 30, 1];
        hourAndMinuteAdjustments[30] = [4, 30, 1];
        hourAndMinuteAdjustments[31] = [5, 30, 1];
        hourAndMinuteAdjustments[32] = [5, 45, 1];
        hourAndMinuteAdjustments[33] = [6, 30, 1];
        hourAndMinuteAdjustments[34] = [8, 45, 1];
        hourAndMinuteAdjustments[35] = [9, 30, 1];
        hourAndMinuteAdjustments[36] = [10, 30, 1];
        hourAndMinuteAdjustments[37] = [13, 45, 1];
    }

    function _renderHandAnimation(
        string memory handName,
        uint256 handPosition
    ) private pure returns(string memory) {
        string memory output;
        string memory startPosition = string(abi.encodePacked(Strings.toString(handPosition), 'deg'));
        string memory endPosition = string(abi.encodePacked(Strings.toString(handPosition + 360), 'deg'));
        string memory rotateFrom = string(abi.encodePacked(
            ' { from { -webkit-transform: rotate(',
            startPosition,
            '); -moz-transform: rotate(',
            startPosition,
            '); -ms-transform: rotate(',
            startPosition,
            '); -o-transform: rotate(',
            startPosition,
            '); transform: rotate(',
            startPosition
        ));
        string memory rotateTo = string(abi.encodePacked(
            '); } to { -webkit-transform: rotate(',
            endPosition,
            '); -moz-transform: rotate(',
            endPosition,
            '); -ms-transform: rotate(',
            endPosition,
            '); -o-transform: rotate(',
            endPosition,
            '); transform: rotate(',
            endPosition
        ));
        output = string(abi.encodePacked(
            '@keyframes rotate',
            handName,
            rotateFrom,
            rotateTo,
            '); } } '
        ));
        return output;
    }

    function _renderHandStyle(
        HandType handType, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor
    ) private pure returns(string memory) {
        string[6] memory svgParts;
        svgParts[0] = string(abi.encodePacked(
            '<style>g, line, circle { --color-accent: ', 
            accentColor, 
            '; --color-hand-outer: ', 
            outerHandColor, 
            '; --color-hand-inner: ', 
            innerHandColor,
            '; '
        ));
        svgParts[1] = '-webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } ';
        if (handType == HandType.ROUND || handType == HandType.SPORT) {
            svgParts[2] = '.circle { color: var(--color-accent); } ';
        } else {
            svgParts[2] = '.circle { color: var(--color-hand-outer); } ';
        }
        svgParts[3] = '.dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } ';
        if (handType == HandType.ROUND || handType == HandType.TANK || handType == HandType.TANK_F || handType == HandType.SENATOR) {
            svgParts[4] = '.dial line { stroke: currentColor; stroke-linecap: round; } ';
        } else {
            svgParts[4] = '.dial line { stroke: currentColor; } ';
        }
        if (handType == HandType.SENATOR) {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 3px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        } else if (handType == HandType.TANK || handType == HandType.TANK_F) {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        } else if (handType == HandType.DRESS_ROLEX || handType == HandType.ROUND) {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        } else {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        }
        
        return string(abi.encodePacked(
            svgParts[0],
            svgParts[1],
            svgParts[2],
            svgParts[3],
            svgParts[4],
            svgParts[5]
        ));
    }

    // Returns SVG of the watch hands, with a trailing space
    function renderHands(
        string memory viewBox,
        string memory x, 
        string memory y, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor,
        uint256 secondHandPos,
        uint256 minuteHandPos,
        uint256 hourHandPos,
        HandType handType
    ) public pure returns (string memory) {
        string[6] memory svgParts;
        svgParts[0] = string(abi.encodePacked('<svg class="dial" viewBox="', viewBox, '" x="', x, '" y="', y, '"> '));
        svgParts[1] = _renderHandStyle(handType, accentColor, outerHandColor, innerHandColor);
        // second hand animation
        svgParts[2] = _renderHandAnimation("SecondHand", secondHandPos);
        svgParts[3] = _renderHandAnimation("MinuteHand", minuteHandPos);
        svgParts[4] = _renderHandAnimation("HourHand", hourHandPos);
        if (handType == HandType.DRESS_ROLEX) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="28" x2="50" y2="40"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="18" x2="50" y2="40"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        } else if (handType == HandType.SPORT) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <circle class="hand-outer" cx="50" cy="33" r="5"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="50"/> <circle class="hand-inner" cx="50" cy="33" r="3.5"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="65" r="2"/> <circle cx="50" cy="20" r="3"/> <circle class="hand-inner" cx="50" cy="20" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandType.ROUND) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandType.DRESS) {
            svgParts[5] = '</style> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="26.5" x2="50" y2="48.5"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="50"></line> <line class="hand-inner" x1="50" y1="16.5" x2="50" y2="48.5"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        } else if (handType == HandType.SENATOR) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="12" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="3"/> <circle cx="50" cy="65" r="2"/> </g> </g> </svg> ';
        } else if (handType == HandType.DRESS_DD) {
            svgParts[5] = '</style> <g id="hands-container"> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="26.5" x2="50" y2="58.5"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="16.5" x2="50" y2="58.5"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        } else if (handType == HandType.TANK_F) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
        } else {
            // TANK
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="30" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="5"/> </g> </svg> ';
        }
        string memory output = string(abi.encodePacked( // 12
            svgParts[0],
            svgParts[1],
            svgParts[2],
            svgParts[3],
            svgParts[4],
            svgParts[5]
        ));
        return output;
    }
}