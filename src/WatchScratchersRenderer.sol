//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchScratchersWatchCaseRenderer.sol";

contract WatchScratchersRenderer is Ownable {
    
    constructor() {}
    enum HandType {DRESS_ROLEX, DRESS, ROUND, SPORT, TANK_F, TANK, SENATOR }
    enum WatchType { PP_TIFFANY, PP_BLUE, PP_GREEN, PP_WHITE, PP_CHOCOLATE, AP_WHITE, AP_BLUE, AP_GREY, AP_BLACK, AP_BLUE_RG, AP_BLACK_RG, AP_BLUE_YG }
    mapping (IWatchScratchersWatchCaseRenderer.CaseType => address) public caseRenderers;
    mapping (WatchType => mapping (bytes => bytes)) public colorReplacements;
    mapping (bytes => bytes) greenPatek;

    function setCaseRenderer(
        IWatchScratchersWatchCaseRenderer.CaseType caseType, 
        address caseRenderer
    ) external onlyOwner {
        caseRenderers[caseType] = caseRenderer;
    }

    function setColorReplacement(WatchType watchType, bytes[] memory oldColors, bytes[] memory newColors) external onlyOwner {
        unchecked {
            uint256 i;
            for (; i < oldColors.length; ) {
                colorReplacements[watchType][oldColors[i]] = newColors[i];
                ++i;
            }
        }
    }

    // substring [inclusive, exclusive)
    function _substringBytes(bytes memory str, uint256 start, uint256 end) private pure returns (bytes memory) {
    bytes memory result = new bytes(end - start);
    for(uint i = start; i < end;) {
        result[i - start] = str[i];
        unchecked{ ++i; }
    }
    return result;
}

    // Replaces all occurances of _oldValue with _newValue in _string. _oldValue and _newValue will always be length 7.
    function _colorReplace(string memory _string, WatchType watchType) public view returns (string memory) {
        bytes memory _stringBytes = bytes(_string);
        bytes memory resultBytes = new bytes(_stringBytes.length);
        
        for (uint256 i; i < _stringBytes.length;) {
            uint256 sevenAfter = i + 7;
            if (sevenAfter <= _stringBytes.length) {
                bytes memory currentSubstring = _substringBytes(_stringBytes, i, sevenAfter);
                if (colorReplacements[watchType][currentSubstring].length != 0) {
                    bytes memory replacementBytes = bytes(colorReplacements[watchType][currentSubstring]);
                    for (uint256 j = i; j < sevenAfter;) {
                        resultBytes[j] = replacementBytes[j - i];
                        unchecked { ++j; }
                    }
                    unchecked{ i += 6; }
                }
                else {
                    resultBytes[i] = _stringBytes[i];
                }
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
        if (handType == HandType.ROUND) {
            svgParts[4] = '.dial line { stroke: currentColor; stroke-linecap: round; } ';
        } else {
            svgParts[4] = '.dial line { stroke: currentColor; } ';
        }
        if (handType == HandType.SENATOR) {
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
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="48"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="48"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="3"/> </g> </g> </svg> ';
        } else if (handType == HandType.TANK_F) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="30" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="20" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> </g> </svg> ';
        } else if (handType == HandType.SENATOR) {
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

    function renderPP(
        WatchType watchType
    ) public view returns (string memory) {
        string memory caseSvgStart = '<svg viewBox="0 0 9000 9000" x="150" y="302">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.PP]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.PP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == WatchType.PP_TIFFANY || watchType == WatchType.PP_WHITE) {
            watchHands = _renderHands('0 0 2200 2200', '155.8', '311.4', '#041418', '#041418', '#FEFEFD', 234, 342, 57, HandType.ROUND);
        } else if (watchType == WatchType.PP_GREEN || watchType == WatchType.PP_BLUE) {
            watchHands = _renderHands('0 0 2200 2200', '155.8', '311.4', '#B4B8B2', '#B4B8B2', '#FEFEFD', 234, 342, 57, HandType.ROUND); 
        } else if (watchType == WatchType.PP_CHOCOLATE) {
            watchHands = _renderHands('0 0 2200 2200', '155.8', '311.4', '#EFCCAC', '#EFCCAC', '#FEFEFD', 234, 342, 57, HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function renderAP(
        WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 7500 7500" x="148" y="302">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.AP]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.AP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == WatchType.AP_WHITE || watchType == WatchType.AP_BLUE || watchType == WatchType.AP_GREY || watchType == WatchType.AP_BLACK) {
            watchHands = _renderHands('0 0 2100 2100', '157', '310.7', '#D5D5D5', '#868582', '#F8F8F8', 234, 342, 57, HandType.ROUND);
        } else if (watchType == WatchType.AP_BLUE_RG || watchType == WatchType.AP_BLACK_RG) {
            watchHands = _renderHands('0 0 2100 2100', '157', '310.7', '#D8AB8B', '#D8AB8B', '#F8F8F8', 234, 342, 57, HandType.ROUND); 
        } else if (watchType == WatchType.AP_BLUE_YG) {
            watchHands = _renderHands('0 0 2100 2100', '157', '310.7', '#F0CD94', '#F0CD94', '#F8F8F8', 234, 342, 57, HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }
}