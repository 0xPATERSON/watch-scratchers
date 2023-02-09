//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchClubCaseRenderer.sol";
import "./interfaces/IWatchClubHandsRenderer.sol";
import "./interfaces/IWatchClubWatchRenderer.sol";

// TODO: update function visibilities

contract WatchClubWatchRenderer is Ownable, IWatchClubWatchRenderer {
    constructor() {}
    
    mapping (IWatchClubCaseRenderer.CaseType => address) public caseRenderers;
    mapping (IWatchClubWatchRenderer.WatchType => mapping (bytes => bytes)) public colorReplacements;

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

    function setColorReplacement(IWatchClubWatchRenderer.WatchType watchType, bytes[] memory oldColors, bytes[] memory newColors) external onlyOwner {
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
    function _colorReplace(string memory _string, IWatchClubWatchRenderer.WatchType watchType) public view returns (string memory) {
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

    function _renderPP(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) {
        string memory caseSvgStart = '<svg viewBox="0 0 7800 7800" x="151" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.PP]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.PP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.PP_TIFFANY || watchType == IWatchClubWatchRenderer.WatchType.PP_WHITE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#041418', '#041418', '#FEFEFD', IWatchClubHandsRenderer.HandType.ROUND);
        } else if (watchType == IWatchClubWatchRenderer.WatchType.PP_GREEN || watchType == IWatchClubWatchRenderer.WatchType.PP_BLUE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#B4B8B2', '#B4B8B2', '#FEFEFD', IWatchClubHandsRenderer.HandType.ROUND); 
        } else if (watchType == IWatchClubWatchRenderer.WatchType.PP_CHOCOLATE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#EFCCAC', '#EFCCAC', '#FEFEFD', IWatchClubHandsRenderer.HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderAP(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="146.7" y="299">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.AP]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.AP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.AP_WHITE || watchType == IWatchClubWatchRenderer.WatchType.AP_BLUE || watchType == IWatchClubWatchRenderer.WatchType.AP_GREY || watchType == IWatchClubWatchRenderer.WatchType.AP_BLACK) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309', '#D5D5D5', '#868582', '#F8F8F8', IWatchClubHandsRenderer.HandType.ROUND);
        } else if (watchType == IWatchClubWatchRenderer.WatchType.AP_BLUE_RG || watchType == IWatchClubWatchRenderer.WatchType.AP_BLACK_RG || watchType == IWatchClubWatchRenderer.WatchType.AP_BLACK_CERAMIC) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309', '#D8AB8B', '#D8AB8B', '#F8F8F8', IWatchClubHandsRenderer.HandType.ROUND); 
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderVC(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6550 6550" x="150.3" y="299.6">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.VC]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.VC);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.VC_BLUE || watchType == IWatchClubWatchRenderer.WatchType.VC_BLACK) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#C9C5C8', '#C9C5C8', '#FFFCFB', IWatchClubHandsRenderer.HandType.ROUND);
        } else if (watchType == IWatchClubWatchRenderer.WatchType.VC_WHITE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#3E3C3A', '#3E3C3A', '#FFFCFB', IWatchClubHandsRenderer.HandType.ROUND); 
        } else if (watchType == IWatchClubWatchRenderer.WatchType.VC_BLUE_RG) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#EBB788', '#EBB788', '#FFFCFB', IWatchClubHandsRenderer.HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderSUB(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.SUB]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.SUB);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.SUB_BLACK_TT || watchType == IWatchClubWatchRenderer.WatchType.SUB_BLUE_TT || watchType == IWatchClubWatchRenderer.WatchType.SUB_BLACK_YG || watchType == IWatchClubWatchRenderer.WatchType.SUB_BLUE_YG) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#FBECC8', '#FBECC8', '#F6F8F7', IWatchClubHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#C1C1C1', '#C1C1C1', '#F6F8F7', IWatchClubHandsRenderer.HandType.SPORT);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderYACHT(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.YACHT]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.YACHT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.YACHT_BLUE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#FA0029', '#C1C1C1', '#F6F8F7', IWatchClubHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#00ABD9', '#C1C1C1', '#F6F8F7', IWatchClubHandsRenderer.HandType.SPORT);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderOpDjExp(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="150" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        
        if (watchType >= IWatchClubWatchRenderer.WatchType.OP_YELLOW && watchType < IWatchClubWatchRenderer.WatchType.DJ_WHITE) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.OP]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.OP);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', IWatchClubHandsRenderer.HandType.DRESS_ROLEX);
        } else if (watchType >= IWatchClubWatchRenderer.WatchType.DJ_WHITE && watchType < IWatchClubWatchRenderer.WatchType.EXP) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DJ]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DJ);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', IWatchClubHandsRenderer.HandType.DRESS_ROLEX);
        } else {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.EXP]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.EXP);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', IWatchClubHandsRenderer.HandType.SPORT);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
    
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderDD(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6000 6000" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        if (watchType == IWatchClubWatchRenderer.WatchType.DD_ICE_P || watchType == IWatchClubWatchRenderer.WatchType.DD_OLIVE_P) {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DD_P]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DD_P);
        } else {
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.DD]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.DD);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.DD_OLIVE_P || watchType == IWatchClubWatchRenderer.WatchType.DD_ICE_P) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#E4E4E4', '#E4E4E4', '#F7FDFA', IWatchClubHandsRenderer.HandType.DRESS);
        } else if (watchType == IWatchClubWatchRenderer.WatchType.DD_CHOCOLATE_RG || watchType == IWatchClubWatchRenderer.WatchType.DD_OLIVE_RG) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#F5C8BA', '#F5C8BA', '#F7FDFA', IWatchClubHandsRenderer.HandType.DRESS);
        } else {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#FBECC8', '#FBECC8', '#F7FDFA', IWatchClubHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderAQ(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 7500 7500" x="150" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.AQ]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.AQ);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.AQ_WHITE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#F96C00', '#525353', '#FFFFFF', IWatchClubHandsRenderer.HandType.SPORT);
        } else if (watchType == IWatchClubWatchRenderer.WatchType.AQ_GREY) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#00588B', '#00588B', '#FFFFFF', IWatchClubHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#DDDDDD', '#B6B6B6', '#FFFFFF', IWatchClubHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderPILOT(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6800 6800" x="150" y="298">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.PILOT]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.PILOT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IWatchClubWatchRenderer.WatchType.PILOT_WHITE) {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#0E0E0E', '#0E0E0E', '#FFFFFF', IWatchClubHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#FFFFFF', '#444444', '#FFFFFF', IWatchClubHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderTANK(
        IWatchClubWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart;
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        if (watchType >= IWatchClubWatchRenderer.WatchType.TANK && watchType < IWatchClubWatchRenderer.WatchType.TANK_F) {
            caseSvgStart = '<svg viewBox="0 0 8500 8500" x="152" y="299.5">';
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.TANK]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.TANK);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 2500 2500', '159.3', '312.4', '#1C55B4', '#1C55B4', '#1C55B4', IWatchClubHandsRenderer.HandType.TANK);
        } else {
            caseSvgStart = '<svg viewBox="0 0 8200 8200" x="153" y="299.5">';
            watchCase = IWatchClubCaseRenderer(
                caseRenderers[IWatchClubCaseRenderer.CaseType.TANK_F]
            ).renderSvg(IWatchClubCaseRenderer.CaseType.TANK_F);
            watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 2500 2500', '159.6', '311.7', '#1C55B4', '#1C55B4', '#1C55B4', IWatchClubHandsRenderer.HandType.TANK_F);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);

        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderGS() public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 7200 7200" x="150" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.GS]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.GS);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.5', '308.7', '#006AB4', '#B1B0AF', '#B1B0AF', IWatchClubHandsRenderer.HandType.DRESS);
        
        return string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
    }

    function _renderSENATOR() public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6800 6800" x="150" y="298">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchClubCaseRenderer(
            caseRenderers[IWatchClubCaseRenderer.CaseType.SENATOR]
        ).renderSvg(IWatchClubCaseRenderer.CaseType.SENATOR);
        string memory watchHands = IWatchClubHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#0056A5', '#0056A5', '#0056A5', IWatchClubHandsRenderer.HandType.ROUND);
        
        return string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
    }

    function renderWatch(IWatchClubWatchRenderer.WatchType watchType) public view returns (string memory) {
        if (watchType <= IWatchClubWatchRenderer.WatchType.PP_CHOCOLATE) {
            return _renderPP(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.AP_BLACK_CERAMIC) {
            return _renderAP(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.VC_BLUE_RG) {
            return _renderVC(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.SUB_BLUE_YG) {
            return _renderSUB(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.YACHT_BLUE) {
            return _renderYACHT(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.EXP_TT) {
            return _renderOpDjExp(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.DD_OLIVE_P) {
            return _renderDD(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.AQ_BLACK) {
            return _renderAQ(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.PILOT_TG) {
            return _renderPILOT(watchType);
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.SENATOR) {
            return _renderSENATOR();
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.GS) {
            return _renderGS();
        } else {
            return _renderTANK(watchType);
        } 
    }
}