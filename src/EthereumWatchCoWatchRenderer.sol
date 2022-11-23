//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchScratchersWatchCaseRenderer.sol";
import "./interfaces/IEthereumWatchCoWatchHandsRenderer.sol";
import "./interfaces/IEthereumWatchCoWatchRenderer.sol";

// TODO: update function visibilities

contract EthereumWatchCoWatchRenderer is Ownable, IEthereumWatchCoWatchRenderer {
    constructor() {}
    
    mapping (IWatchScratchersWatchCaseRenderer.CaseType => address) public caseRenderers;
    mapping (IEthereumWatchCoWatchRenderer.WatchType => mapping (bytes => bytes)) public colorReplacements;

    address public watchHandsRenderer;

    function setHandsRenderer(address _watchHandsRenderer) external onlyOwner {
        watchHandsRenderer = _watchHandsRenderer;
    }

    function setCaseRenderer(
        IWatchScratchersWatchCaseRenderer.CaseType caseType, 
        address caseRenderer
    ) external onlyOwner {
        caseRenderers[caseType] = caseRenderer;
    }

    function setColorReplacement(IEthereumWatchCoWatchRenderer.WatchType watchType, bytes[] memory oldColors, bytes[] memory newColors) external onlyOwner {
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
    function _colorReplace(string memory _string, IEthereumWatchCoWatchRenderer.WatchType watchType) public view returns (string memory) {
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
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) {
        string memory caseSvgStart = '<svg viewBox="0 0 7800 7800" x="151" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.PP]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.PP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.PP_TIFFANY || watchType == IEthereumWatchCoWatchRenderer.WatchType.PP_WHITE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#041418', '#041418', '#FEFEFD', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.PP_GREEN || watchType == IEthereumWatchCoWatchRenderer.WatchType.PP_BLUE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#B4B8B2', '#B4B8B2', '#FEFEFD', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND); 
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.PP_CHOCOLATE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1900 1900', '157.7', '310.8', '#EFCCAC', '#EFCCAC', '#FEFEFD', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderAP(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="146.7" y="299">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.AP]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.AP);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_WHITE || watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_BLUE || watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_GREY || watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_BLACK) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309', '#D5D5D5', '#868582', '#F8F8F8', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_BLUE_RG || watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_BLACK_RG) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309', '#D8AB8B', '#D8AB8B', '#F8F8F8', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND); 
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.AP_BLUE_YG) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '156.9', '309', '#F0CD94', '#F0CD94', '#F8F8F8', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderVC(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6550 6550" x="150.3" y="299.6">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.VC]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.VC);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.VC_BLUE || watchType == IEthereumWatchCoWatchRenderer.WatchType.VC_BLACK) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#C9C5C8', '#C9C5C8', '#FFFCFB', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.VC_WHITE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#3E3C3A', '#3E3C3A', '#FFFCFB', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND); 
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.VC_BLUE_RG) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1800 1800', '157.1', '309.2', '#EBB788', '#EBB788', '#FFFCFB', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderSUB(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.SUB]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.SUB);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.SUB_BLACK_TT || watchType == IEthereumWatchCoWatchRenderer.WatchType.SUB_BLUE_TT || watchType == IEthereumWatchCoWatchRenderer.WatchType.SUB_BLACK_YG || watchType == IEthereumWatchCoWatchRenderer.WatchType.SUB_BLUE_YG) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#FBECC8', '#FBECC8', '#F6F8F7', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#C1C1C1', '#C1C1C1', '#F6F8F7', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderYACHT(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.YACHT]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.YACHT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.YACHT_BLUE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#FA0029', '#C1C1C1', '#F6F8F7', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1700 1700', '156.3', '308.9', '#00ABD9', '#C1C1C1', '#F6F8F7', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderOpDjExp(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6500 6500" x="150" y="300">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        
        if (watchType >= IEthereumWatchCoWatchRenderer.WatchType.OP_YELLOW && watchType < IEthereumWatchCoWatchRenderer.WatchType.DJ_WHITE) {
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.OP]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.OP);
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS_ROLEX);
        } else if (watchType >= IEthereumWatchCoWatchRenderer.WatchType.DJ_WHITE && watchType < IEthereumWatchCoWatchRenderer.WatchType.EXP) {
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.DJ]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.DJ);
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS_ROLEX);
        } else {
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.EXP]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.EXP);
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1750 1750', '156.5', '308.9', '#E4E4E4', '#E4E4E4', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
    
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderDD(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6000 6000" x="149" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_ICE_P || watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_OLIVE_P) {
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.DD_P]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.DD_P);
        } else {
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.DD]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.DD);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_OLIVE_P || watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_ICE_P) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#E4E4E4', '#E4E4E4', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_WHITE_RG || watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_CHOCOLATE_RG || watchType == IEthereumWatchCoWatchRenderer.WatchType.DD_OLIVE_RG) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#F5C8BA', '#F5C8BA', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        } else {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '156', '308.8', '#FBECC8', '#FBECC8', '#F7FDFA', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderAQ(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 7500 7500" x="150" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.AQ]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.AQ);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.AQ_WHITE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#F96C00', '#525353', '#FFFFFF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        } else if (watchType == IEthereumWatchCoWatchRenderer.WatchType.AQ_GREY) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#00588B', '#00588B', '#FFFFFF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.7', '308.4', '#DDDDDD', '#B6B6B6', '#FFFFFF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderPILOT(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6800 6800" x="150" y="298">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.PILOT]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.PILOT);
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);
        string memory watchHands;
        if (watchType == IEthereumWatchCoWatchRenderer.WatchType.PILOT_WHITE) {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#0E0E0E', '#0E0E0E', '#FFFFFF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.SPORT);
        } else {
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#FFFFFF', '#444444', '#FFFFFF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        }
        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderTANK(
        IEthereumWatchCoWatchRenderer.WatchType watchType
    ) public view returns (string memory) { 
        string memory caseSvgStart;
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase;
        string memory watchHands;
        if (watchType >= IEthereumWatchCoWatchRenderer.WatchType.TANK && watchType < IEthereumWatchCoWatchRenderer.WatchType.TANK_F) {
            caseSvgStart = '<svg viewBox="0 0 8500 8500" x="152" y="299.5">';
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.TANK]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.TANK);
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 2500 2500', '159.3', '312.4', '#1C55B4', '#1C55B4', '#1C55B4', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.TANK);
        } else {
            caseSvgStart = '<svg viewBox="0 0 8200 8200" x="153" y="299.5">';
            watchCase = IWatchScratchersWatchCaseRenderer(
                caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.TANK_F]
            ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.TANK_F);
            watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 2500 2500', '159.6', '311.7', '#1C55B4', '#1C55B4', '#1C55B4', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.TANK_F);
        }
        string memory coloredWatchCase = _colorReplace(watchCase, watchType);

        return string(abi.encodePacked(caseSvgStart, coloredWatchCase, caseSvgEnd, watchHands));
    }

    function _renderGS() public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 7200 7200" x="150" y="299.5">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.GS]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.GS);
        string memory watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1630 1630', '155.5', '308.7', '#006AB4', '#B1B0AF', '#B1B0AF', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.DRESS);
        
        return string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
    }

    function _renderSENATOR() public view returns (string memory) { 
        string memory caseSvgStart = '<svg viewBox="0 0 6800 6800" x="150" y="298">';
        string memory caseSvgEnd =  '</svg>';
        string memory watchCase = IWatchScratchersWatchCaseRenderer(
            caseRenderers[IWatchScratchersWatchCaseRenderer.CaseType.SENATOR]
        ).renderSvg(IWatchScratchersWatchCaseRenderer.CaseType.SENATOR);
        string memory watchHands = IEthereumWatchCoWatchHandsRenderer(watchHandsRenderer).renderHands('0 0 1650 1650', '155.7', '308.5', '#0056A5', '#0056A5', '#0056A5', 234, 342, 57, IEthereumWatchCoWatchHandsRenderer.HandType.ROUND);
        
        return string(abi.encodePacked(caseSvgStart, watchCase, caseSvgEnd, watchHands));
    }

    function renderWatch(IEthereumWatchCoWatchRenderer.WatchType watchType) public view returns (string memory) {
        if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.PP_CHOCOLATE) {
            return _renderPP(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.AP_BLUE_YG) {
            return _renderAP(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.VC_BLUE_RG) {
            return _renderVC(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.SUB_BLUE_YG) {
            return _renderSUB(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.YACHT_BLUE) {
            return _renderYACHT(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.EXP_TT) {
            return _renderOpDjExp(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.DD_OLIVE_P) {
            return _renderDD(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.AQ_BLACK) {
            return _renderAQ(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.PILOT_TG) {
            return _renderPILOT(watchType);
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.SENATOR) {
            return _renderSENATOR();
        } else if (watchType <= IEthereumWatchCoWatchRenderer.WatchType.GS) {
            return _renderGS();
        } else {
            return _renderTANK(watchType);
        } 
    }
}