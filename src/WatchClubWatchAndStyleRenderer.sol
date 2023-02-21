//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchClubCaseRenderer.sol";
import "./interfaces/IWatchClubHandsRenderer.sol";
import "./interfaces/IWatchClubWatchAndStyleRenderer.sol";

// TODO: update function visibilities

contract WatchClubWatchAndStyleRenderer is Ownable, IWatchClubWatchAndStyleRenderer {
    constructor() {}
    
    mapping (IWatchClubCaseRenderer.CaseType => address) public caseRenderers;
    mapping (IWatchClubWatchAndStyleRenderer.WatchType => mapping (bytes => bytes)) public colorReplacements;

    address public watchHandsRenderer;

    function setHandsRenderer(address _watchHandsRenderer) external onlyOwner {
        watchHandsRenderer = _watchHandsRenderer;
    }

    function setCaseRenderer(
        IWatchClubCaseRenderer.CaseType caseType, 
        address caseRenderer
    ) external onlyOwner {
        caseRenderers[caseType] = caseRenderer;
    }

    function setColorReplacement(IWatchClubWatchAndStyleRenderer.WatchType watchType, bytes[] memory oldColors, bytes[] memory newColors) external onlyOwner {
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
    function _colorReplace(string memory _string, IWatchClubWatchAndStyleRenderer.WatchType watchType) public view returns (string memory) {
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

    // @dev ideally this lives in WatchClubRenderer, but there are too much watch and hands dependent styling 
    // so easier to put here
    function _renderStyle(
        IWatchClubHandsRenderer.HandType handType, 
        string memory accentColor, 
        string memory outerHandColor, 
        string memory innerHandColor
    ) public pure returns (string memory) {
        string[6] memory svgParts;
        svgParts[0] = string(abi.encodePacked(
            '<style id="mainStyle"> #container svg { width: 100vmin; height: 100%; } #container { display:flex; align-items:center; justify-content:center; overflow: hidden; } g, line, circle { --color-accent: ', 
            accentColor, 
            '; --color-hand-outer: ', 
            outerHandColor, 
            '; --color-hand-inner: ', 
            innerHandColor,
            '; '
        ));
        svgParts[1] = '-webkit-transform-origin: inherit; transform-origin: inherit; display: flex; align-items: center; justify-content: center; margin: 0; } ';
        if (handType == IWatchClubHandsRenderer.HandType.ROUND || handType == IWatchClubHandsRenderer.HandType.SPORT || handType == IWatchClubHandsRenderer.HandType.TRINITY || handType == IWatchClubHandsRenderer.HandType.DRESS_DD) {
            svgParts[2] = '.circle { color: var(--color-accent); fill: var(--color-accent); } ';
        } else {
            svgParts[2] = '.circle { color: var(--color-hand-outer); fill: var(--color-hand-outer); } ';
        }
        svgParts[3] = '.dial { width: 60vmin; height: 60vmin; fill: currentColor; -webkit-transform-origin: 50px 50px; transform-origin: 50px 50px; -webkit-animation-name: fade-in; animation-name: fade-in; -webkit-animation-duration: 500ms; animation-duration: 500ms; -webkit-animation-fill-mode: both; animation-fill-mode: both; } ';
        if (handType == IWatchClubHandsRenderer.HandType.DRESS_ROLEX || handType == IWatchClubHandsRenderer.HandType.DRESS_DD || handType == IWatchClubHandsRenderer.HandType.SPORT) {
            svgParts[4] = '.dial line { stroke: currentColor; } ';
        } else {
            svgParts[4] = '.dial line { stroke: currentColor; stroke-linecap: round; } ';
        }
        if (handType == IWatchClubHandsRenderer.HandType.SENATOR) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 3px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else if (handType == IWatchClubHandsRenderer.HandType.TRINITY) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .hand-outer { stroke-width: 4.5px; color: var(--color-hand-outer); } .hand-outer-connection { stroke-width: 2px; color: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else if (handType == IWatchClubHandsRenderer.HandType.PILOT) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); stroke: currentColor; fill: currentColor; } .hand-outer { color: var(--color-hand-outer); stroke: currentColor; fill: currentColor; } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else if (handType == IWatchClubHandsRenderer.HandType.TANK || handType == IWatchClubHandsRenderer.HandType.TANK_F || handType == IWatchClubHandsRenderer.HandType.DRESS_ROLEX) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else if (handType == IWatchClubHandsRenderer.HandType.AQUA) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); fill: currentColor; } .hand-outer { stroke: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else if (handType == IWatchClubHandsRenderer.HandType.DAUPHINE) {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-inner { color: var(--color-hand-inner); fill: var(--color-hand-inner); } .hand-outer { stroke: var(--color-hand-outer); fill: var(--color-hand-outer); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style> ';
        } else {
            svgParts[5] = '.hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 5px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2.5px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } </style>';
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
    
    function _renderPP(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) {
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 7800 7800" x="150.5" y="300.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.PP]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.PP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.85', '310.7', IWatchClubHandsRenderer.HandType.TRINITY);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.PP_TIFFANY || watchType == IWatchClubWatchAndStyleRenderer.WatchType.PP_WHITE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, '#041418', '#041418', '#FEFEFD');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.PP_GREEN || watchType == IWatchClubWatchAndStyleRenderer.WatchType.PP_BLUE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, '#B4B8B2', '#B4B8B2', '#FEFEFD');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.PP_CHOCOLATE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, '#EFCCAC', '#EFCCAC', '#FEFEFD');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderAP(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6500 6500" x="146.7" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.AP]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.AP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309.8', IWatchClubHandsRenderer.HandType.TRINITY);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_WHITE || watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_BLUE || watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_GREY || watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_BLACK) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, '#D5D5D5', '#868582', '#F8F8F8');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_BLUE_RG || watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_BLACK_RG || watchType == IWatchClubWatchAndStyleRenderer.WatchType.AP_BLACK_CERAMIC) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TRINITY, '#D8AB8B', '#D8AB8B', '#F8F8F8');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderVC(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6550 6550" x="149.8" y="300.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.VC]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.VC);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.5', '310.3', IWatchClubHandsRenderer.HandType.ROUND);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.VC_BLUE || watchType == IWatchClubWatchAndStyleRenderer.WatchType.VC_BLACK) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.ROUND, '#C9C5C8', '#C9C5C8', '#FFFCFB');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.VC_WHITE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.ROUND, '#3E3C3A', '#3E3C3A', '#FFFCFB');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.VC_BLUE_RG) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.ROUND, '#EBB788', '#EBB788', '#FFFCFB');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderSUB(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6500 6500" x="149" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.SUB]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.SUB);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.6', '309.3', IWatchClubHandsRenderer.HandType.SPORT);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.SUB_BLACK_TT || watchType == IWatchClubWatchAndStyleRenderer.WatchType.SUB_BLUE_TT || watchType == IWatchClubWatchAndStyleRenderer.WatchType.SUB_BLACK_YG || watchType == IWatchClubWatchAndStyleRenderer.WatchType.SUB_BLUE_YG) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#FBECC8', '#FBECC8', '#F6F8F7');
        } else {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#C1C1C1', '#C1C1C1', '#F6F8F7');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderYACHT(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6500 6500" x="149" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.YACHT]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.YACHT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.6', '309.3', IWatchClubHandsRenderer.HandType.SPORT);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.YACHT_BLUE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#FA0029', '#C1C1C1', '#F6F8F7');
        } else {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#00ABD9', '#C1C1C1', '#F6F8F7');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderOpDjExp(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6200 6200" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        string memory style;
        
        if (watchType >= IWatchClubWatchAndStyleRenderer.WatchType.OP_YELLOW && watchType < IWatchClubWatchAndStyleRenderer.WatchType.DJ_WHITE) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.OP]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.OP);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.75', '308.7', IWatchClubHandsRenderer.HandType.DRESS_ROLEX);
            style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_ROLEX, '#E4E4E4', '#E4E4E4', '#F7FDFA');
        } else if (watchType >= IWatchClubWatchAndStyleRenderer.WatchType.DJ_WHITE && watchType < IWatchClubWatchAndStyleRenderer.WatchType.EXP) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DJ]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DJ);
            watchHands = watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.75', '308.7', IWatchClubHandsRenderer.HandType.DRESS_ROLEX);
            if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.DJ_CHAMPAGNE_TT) {
                style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_ROLEX, '#FBECC8', '#FBECC8', '#F7FDFA');
            } else {
                style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_ROLEX, '#E4E4E4', '#E4E4E4', '#F7FDFA');
            }
        } else {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.EXP]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.EXP);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.75', '308.7', IWatchClubHandsRenderer.HandType.SPORT);
            if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.EXP_TT) {
                style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#FBECC8', '#FBECC8', '#F7FDFA');
            } else {
                style = _renderStyle(IWatchClubHandsRenderer.HandType.SPORT, '#E4E4E4', '#E4E4E4', '#F7FDFA');
            }
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
    
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderDD(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6000 6000" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_ICE_P || watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_OLIVE_P) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DD_P]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DD_P);
        } else {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DD]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DD);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', IWatchClubHandsRenderer.HandType.DRESS_DD);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_OLIVE_P) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_DD, '#E4E4E4', '#E4E4E4', '#FEFBFF');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_ICE_P) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_DD, '#3E79B1', '#A0B8BF', '#FEFBFF');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_CHOCOLATE_RG || watchType == IWatchClubWatchAndStyleRenderer.WatchType.DD_OLIVE_RG) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_DD, '#F5C8BA', '#C18270', '#F5C8BA');
        } else {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.DRESS_DD, '#FBECC8', '#D8BE80', '#FBECC8');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderAQ(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 7500 7500" x="150.2" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.AQ]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.AQ);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '156.5', '308.9', IWatchClubHandsRenderer.HandType.AQUA);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.AQ_WHITE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.AQUA, '#F96C00', '#525353', '#FFFFFF');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.AQ_GREY) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.AQUA, '#00588B', '#00588B', '#FFFFFF');
        } else {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.AQUA, '#DDDDDD', '#B6B6B6', '#FFFFFF');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderPILOT(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6900 6900" x="150" y="298.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.PILOT]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.PILOT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.7', '309.25', IWatchClubHandsRenderer.HandType.PILOT);
        string memory style;
        if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.PILOT_WHITE) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.PILOT, '#0E0E0E', '#0E0E0E', '#FFFFFF');
        } else if (watchType == IWatchClubWatchAndStyleRenderer.WatchType.PILOT_TG) {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.PILOT, '#FFFFFF', '#0E0E0E', '#FFFFFF');
        } else {
            style = _renderStyle(IWatchClubHandsRenderer.HandType.PILOT, '#FFFFFF', '#D3D3D3', '#FFFFFF');
        }
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderTANK(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) { 
        string memory caseSvgStart;
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        string memory style;
        if (watchType >= IWatchClubWatchAndStyleRenderer.WatchType.TANK && watchType < IWatchClubWatchAndStyleRenderer.WatchType.TANK_F) {
            caseSvgStart = '<svg id="watch" viewBox="0 0 8500 8500" x="152" y="299.5">';
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.TANK]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.TANK);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 2500 2500', '159.3', '312.4', IWatchClubHandsRenderer.HandType.TANK);
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TANK, '#1C55B4', '#1C55B4', '#1C55B4');
        } else {
            caseSvgStart = '<svg id="watch" viewBox="0 0 9500 9500" x="153" y="303">';
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.TANK_F]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.TANK_F);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 2800 2800', '158.5', '313.25', IWatchClubHandsRenderer.HandType.TANK_F);
            style = _renderStyle(IWatchClubHandsRenderer.HandType.TANK_F, '#1C55B4', '#1C55B4', '#1C55B4');
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);

        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderGS() public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 7200 7200" x="149.5" y="299.75">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.GS]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.GS);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.9', '309.1', IWatchClubHandsRenderer.HandType.DAUPHINE);
        string memory style = _renderStyle(IWatchClubHandsRenderer.HandType.DAUPHINE, '#006AB4', '#B1B0AF', '#9A9998');
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function _renderSENATOR() public view returns (string[2] memory) { 
        string memory caseSvgStart = '<svg id="watch" viewBox="0 0 6900 6900" x="150" y="298.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.SENATOR]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.SENATOR);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.7', '309.25', IWatchClubHandsRenderer.HandType.SENATOR);
        string memory style = _renderStyle(IWatchClubHandsRenderer.HandType.SENATOR, '#0056A5', '#0056A5', '#0056A5');
        
        string[2] memory output;
        output[0] = string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
        output[1] = style;
        return output;
    }

    function renderWatchAndStyle(
        IWatchClubWatchAndStyleRenderer.WatchType watchType
    ) public view returns (string[2] memory) {
        if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.PP_CHOCOLATE) {
            return _renderPP(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.AP_BLACK_CERAMIC) {
            return _renderAP(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.VC_BLUE_RG) {
            return _renderVC(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.SUB_BLUE_YG) {
            return _renderSUB(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.YACHT_BLUE) {
            return _renderYACHT(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.EXP_TT) {
            return _renderOpDjExp(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.DD_OLIVE_P) {
            return _renderDD(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.AQ_BLACK) {
            return _renderAQ(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.PILOT_TG) {
            return _renderPILOT(watchType);
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.SENATOR) {
            return _renderSENATOR();
        } else if (watchType <= IWatchClubWatchAndStyleRenderer.WatchType.GS) {
            return _renderGS();
        } else {
            return _renderTANK(watchType);
        } 
    }
}