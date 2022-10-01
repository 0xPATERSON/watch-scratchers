//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

library WatchScratchersLibrary {
    /*
    Traits:
        1. watch
        2. species
        3. eyes
        4. mouth
        5. head
        6. ear

        mod by 10,000 gives you last 4 digits, 1000 gives you last 3, etc.
        then shift right by 14 for 10000, shift right by 10 for 1000
        I think i'll use 1000 and shift 10
    */
    uint256 public constant NUM_TRAITS = 6;

    enum HandTypes {R_DRESS, O_DRESS, ROUND, SPORT, TANK_F, TANK, SENATOR }

    // Replaces all occurances of _oldValue with _newValue in _string. _oldValue and _newValue will always be length 7.
    function _colorReplace(string memory _string, string memory _oldValue, string memory _newValue) public pure returns (string memory) {
        bytes memory _stringBytes = bytes(_string);
        bytes memory _oldValueBytes = bytes(_oldValue);
        bytes memory _newValueBytes = bytes(_newValue);
        bytes memory resultBytes = new bytes(_stringBytes.length);

        for (uint i = 0; i < _stringBytes.length;) {
            if (
                i + 6 < _stringBytes.length &&
                _stringBytes[i] == _oldValueBytes[0] && 
                _stringBytes[i + 1] == _oldValueBytes[1] && 
                _stringBytes[i + 2] == _oldValueBytes[2] && 
                _stringBytes[i + 3] == _oldValueBytes[3] && 
                _stringBytes[i + 4] == _oldValueBytes[4] && 
                _stringBytes[i + 5] == _oldValueBytes[5] && 
                _stringBytes[i + 6] == _oldValueBytes[6]
            ) {
                for (uint j = i; j < i + 7;) {
                    resultBytes[j] = _newValueBytes[j - i];
                    unchecked { ++j; }
                }
                unchecked{ i += 6; }
            }
            else {
                resultBytes[i] = _stringBytes[i];
            }
            unchecked{ ++i; }
        }
        return  string(resultBytes);
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
        HandTypes handType, 
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
        if (handType == HandTypes.ROUND || handType == HandTypes.SPORT) {
            svgParts[2] = '.circle { color: var(--color-accent); } ';
        } else {
            svgParts[2] = '.circle { color: var(--color-hand-outer); } ';
        }
        svgParts[3] = '.dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } ';
        if (handType == HandTypes.ROUND) {
            svgParts[4] = '.dial line { stroke: currentColor; stroke-linecap: round; } ';
        } else {
            svgParts[4] = '.dial line { stroke: currentColor; } ';
        }
        if (handType == HandTypes.SENATOR) {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 3px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        } else {
            svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
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
    function _renderHands(
        string memory viewBox,
        string memory x, 
        string memory y, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor,
        uint256 secondHandPos,
        uint256 minuteHandPos,
        uint256 hourHandPos,
        HandTypes handType
    ) public pure returns (string memory) {
        string[6] memory svgParts;
        svgParts[0] = string(abi.encodePacked('<svg class="dial" viewBox="', viewBox, '" x="', x, '" y="', y, '"> '));
        svgParts[1] = _renderHandStyle(handType, accentColor, outerHandColor, innerHandColor);
        // second hand animation
        svgParts[2] = _renderHandAnimation("SecondHand", secondHandPos);
        svgParts[3] = _renderHandAnimation("MinuteHand", minuteHandPos);
        svgParts[4] = _renderHandAnimation("HourHand", hourHandPos);
        if (handType == HandTypes.R_DRESS) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="28" x2="50" y2="40"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="18" x2="50" y2="40"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        } else if (handType == HandTypes.SPORT) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <circle class="hand-outer" cx="50" cy="33" r="5"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="50"/> <circle class="hand-inner" cx="50" cy="33" r="3.5"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="65" r="2"/> <circle cx="50" cy="20" r="3"/> <circle class="hand-inner" cx="50" cy="20" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandTypes.ROUND) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandTypes.O_DRESS) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="48"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="48"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="3"/> </g> </g> </svg> ';
        } else if (handType == HandTypes.TANK_F) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="30" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> </g> </svg> ';
        } else if (handType == HandTypes.SENATOR) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="12" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="3"/> <circle cx="50" cy="65" r="2"/> </g> </g> </svg> ';
        } else {
            // TANK
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="10" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="60"/> <circle cx="50" cy="50" r="1.5"/> </g> </g> </svg>';
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