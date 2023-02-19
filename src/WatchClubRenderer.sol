//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchClubWatchRenderer.sol";
import "./interfaces/IWatchClubRenderer.sol";
import "./interfaces/IWatchClubPersonRenderer.sol";
import "./interfaces/IWatchClubTraitParser.sol";

// TODO: update function visibilities

contract WatchClubRenderer is Ownable, IWatchClubRenderer {
    error TraitNotFound();

    uint256 public constant NUM_TRAITS = 7;

    address public watchRenderer;
    address public personRenderer;
    address public traitParser;
    
    constructor() {}

    function setPersonRenderer(address _personRenderer) external onlyOwner {
        personRenderer = _personRenderer;
    }

    function setWatchRenderer(address _watchRenderer) external onlyOwner {
        watchRenderer = _watchRenderer;
    }

    function setTraitParser(address _traitParser) external onlyOwner {
        traitParser = _traitParser;
    }

    // @dev __shirtTraitIndex is not used unless the category is 1
    function _getTraitIndex(uint256 category, uint16 numberFromDna, uint8 __shirtTraitIndex) public pure returns (uint8) {
        if (category == 0) {
            return _getWatchTraitIndex(numberFromDna);
        }

        uint8[10] memory GLASSES_WEIGHTS = [24, 49, 59, 69, 99, 0, 0, 0, 0, 0];
        uint8[10] memory EARPHONE_WEIGHTS = [19, 99, 0, 0, 0, 0, 0, 0, 0, 0];
        uint8[10] memory SHIRT_WEIGHTS = [12, 25, 37, 50, 63, 75, 87, 99, 0, 0];
        uint8[10] memory MOUTH_WEIGHTS = [49, 99, 0, 0, 0, 0, 0, 0, 0, 0];
        uint8[10] memory BACKGROUND_WEIGHTS = [12, 25, 37, 50, 63, 75, 87, 99, 0, 0];
        uint8[10][10] memory HAT_WEIGHTS;
        // To prevent shirt + hat combos that look bad, HAT_WEIGHTS[x][y] is a 2D array 
        // where x is the shirt type and y is the hat type
        HAT_WEIGHTS[0] = [14, 28, 0, 42, 56, 70, 84, 0, 99, 0];
        HAT_WEIGHTS[1] = [16, 33, 49, 66, 0, 0, 83, 0, 99, 0];
        HAT_WEIGHTS[2] = [14, 28, 0, 42, 56, 70, 84, 0, 99, 0];
        HAT_WEIGHTS[3] = [16, 33, 0, 49,66, 0, 83, 0, 99, 0];
        HAT_WEIGHTS[4] = [19, 0, 0, 39, 0, 59, 79, 0, 99, 0];
        HAT_WEIGHTS[5] = [14, 28, 0, 42, 0, 56, 70, 84, 99, 0];
        HAT_WEIGHTS[6] = [16, 0, 0, 0, 33, 49, 66, 83, 99, 0];
        HAT_WEIGHTS[7] = [11, 22, 33, 44, 55, 66, 77, 88, 99, 0];

        uint8[10] memory weightsArray;
        if (category == 1) {
            weightsArray = HAT_WEIGHTS[__shirtTraitIndex];
        } else if (category == 2) {
            weightsArray = GLASSES_WEIGHTS;
        } else if (category == 3) {
            weightsArray = EARPHONE_WEIGHTS;
        } else if (category == 4) {
            weightsArray = SHIRT_WEIGHTS;
        } else if (category == 5) {
            weightsArray = MOUTH_WEIGHTS;
        } else if (category == 6) {
            weightsArray = BACKGROUND_WEIGHTS;
        } else {
            revert TraitNotFound();
        }
        
        uint8 i;
        for (; i < weightsArray.length;) {
            if (weightsArray[i] >= numberFromDna) {
                return i;
            }
            ++i;
        }
        revert TraitNotFound();
    }

    function _getWatchTraitIndex(uint16 numberFromDna) public pure returns (uint8) {
        uint16[64] memory WATCH_WEIGHTS = [
            2, 8, 14, 20, 25,  // PP
            31, 37, 43, 49, 54, 59, 62,  // AP
            69, 76, 83, 89,  // VC
            107, 125, 135, 153, 163, 173, 183, 193, 203,  // SUB
            211, 219,  // YACHT
            231, 243, 255, 267, 272, 284, 296,  // OP
            308, 320, 332, 344, 354,  // DJ
            364, 374,  // EXP
            384, 394, 404, 412, 420, 425, 430,  // DD
            445, 460, 475, 490,  // AQUA
            500, 510, 520, 525,  // PILOT
            527,  // SENATOR
            537,  // GS
            547, 555, 563,  // TANK
            565, 567, 569  // TANK F
        ];
        uint8 i;
        for (; i < WATCH_WEIGHTS.length;) {
            if (WATCH_WEIGHTS[i] >= numberFromDna) {
                return i;
            }
            ++i;
        }
        revert TraitNotFound();
    }

    function splitDna(uint256 dna) public pure returns (uint16[7] memory) {
        uint16[NUM_TRAITS] memory numbers;
        uint256 i;
        unchecked {
            for (; i < numbers.length; ) {
                if (i == 0) {
                    numbers[i] = uint16(dna % 1000);
                    dna /= 1000;
                } else {
                    numbers[i] = uint16(dna % 100);
                    dna /= 100;
                }
                ++i;
            }
            return numbers;
        }
    }

    function renderWatch(uint256 dna) public view returns (string memory) {
        uint16[NUM_TRAITS] memory numbersFromDna = splitDna(dna);
        return IWatchClubWatchRenderer(watchRenderer).renderWatch(
            IWatchClubWatchRenderer.WatchType(_getWatchTraitIndex(numbersFromDna[0]))
        );
    }

    // @dev this redundantly takes dna instead of separate traits as uint16 to avoid stack too deep
    function renderPerson(uint256 dna) public view returns (string memory) {
        uint16[NUM_TRAITS] memory numbersFromDna = splitDna(dna);
        uint8 shirt = _getTraitIndex(4, numbersFromDna[4], 0);
        string memory person = IWatchClubPersonRenderer(personRenderer).renderPerson(
            IWatchClubPersonRenderer.HatType(_getTraitIndex(1, numbersFromDna[1], shirt)),
            IWatchClubPersonRenderer.GlassesType(_getTraitIndex(2, numbersFromDna[2], shirt)),
            IWatchClubPersonRenderer.EarType(_getTraitIndex(3, numbersFromDna[3], shirt)),
            IWatchClubPersonRenderer.ShirtType(shirt),
            IWatchClubPersonRenderer.MouthType(_getTraitIndex(5, numbersFromDna[5], shirt)),
            IWatchClubPersonRenderer.BackgroundType(_getTraitIndex(6, numbersFromDna[6], shirt))
        );
        return person;
    }

    function renderScript(uint256 dna) public pure returns (string memory) {
        uint16[NUM_TRAITS] memory numbersFromDna = splitDna(dna);
        IWatchClubWatchRenderer.WatchType watchType = IWatchClubWatchRenderer.WatchType(_getWatchTraitIndex(numbersFromDna[0]));

        string memory watchZoomX;
        string memory watchZoomY;
        string memory handsZoomX;
        string memory handsZoomY;

        if (watchType <= IWatchClubWatchRenderer.WatchType.PP_CHOCOLATE) {
            watchZoomX = "172.3";
            watchZoomY = "170.55";
            handsZoomX = "179.65";
            handsZoomY = "180.75";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.AP_BLACK_CERAMIC) {
            watchZoomX = "169";
            watchZoomY = "170";
            handsZoomX = "179.25";
            handsZoomY = "180";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.VC_BLUE_RG) {
            watchZoomX = "171.5";
            watchZoomY = "170.5";
            handsZoomX = "179.2";
            handsZoomY = "180.25";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.YACHT_BLUE) {
            watchZoomX = "170.75";
            watchZoomY = "170.5";
            handsZoomX = "178.25";
            handsZoomY = "179.75";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.EXP_TT) {
            watchZoomX = "171.5";
            watchZoomY = "170.5";
            handsZoomX = "178.25";
            handsZoomY = "179.75";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.DD_OLIVE_P) {
            watchZoomX = "171";
            watchZoomY = "170.5";
            handsZoomX = "178.25";
            handsZoomY = "179.75";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.AQ_BLACK) {
            watchZoomX = "171.6";
            watchZoomY = "170.25";
            handsZoomX = "177.9";
            handsZoomY = "179.2";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.SENATOR) {
            watchZoomX = "172";
            watchZoomY = "168.75";
            handsZoomX = "178.65";
            handsZoomY = "179.25";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.GS) {
            watchZoomX = "171.5";
            watchZoomY = "170";
            handsZoomX = "177.8";
            handsZoomY = "179.25";
        } else if (watchType <= IWatchClubWatchRenderer.WatchType.TANK_YG) {
            watchZoomX = "174.5";
            watchZoomY = "170";
            handsZoomX = "182";
            handsZoomY = "182.75";
        } else {
            // TANK_F
            watchZoomX = "178";
            watchZoomY = "174.25";
            handsZoomX = "183.5";
            handsZoomY = "184.5";
        }
        
        string[5] memory scriptParts;
        scriptParts[0] = '<script> let style = document.getElementById("mainStyle"); let date = new Date(); let hours = date.getHours(); let minutes = date.getMinutes(); let seconds = date.getSeconds(); let secondsDeg = seconds * 6 - 175; let minutesDeg = minutes * 6 + seconds * 0.1 - 175; let hoursDeg = hours * 30 + minutes * 0.5 - 175; style.innerHTML += `#closeButton { display: none; } #watch, #watchHands { cursor: pointer; pointer-events: bounding-box; }`;style.innerHTML += `@keyframes rotateSecondHand { from { -webkit-transform: rotate(${secondsDeg}deg); -moz-transform: rotate(${secondsDeg}deg); -ms-transform: rotate(${secondsDeg}deg); -o-transform: rotate(${secondsDeg}deg); transform: rotate(${secondsDeg}deg); } to { -webkit-transform: rotate(${secondsDeg + 360}deg); -moz-transform: rotate(${secondsDeg + 360}deg); -ms-transform: rotate(${secondsDeg + 360}deg); -o-transform: rotate(${secondsDeg + 360}deg); transform: rotate(${secondsDeg + 360}deg); }} @keyframes rotateMinuteHand { from { -webkit-transform: rotate(${minutesDeg}deg); -moz-transform: rotate(${minutesDeg}deg); -ms-transform: rotate(${minutesDeg}deg); -o-transform: rotate(${minutesDeg}deg); transform: rotate(${minutesDeg}deg); } to { -webkit-transform: rotate(${minutesDeg + 360}deg); -moz-transform: rotate(${minutesDeg + 360}deg); -ms-transform: rotate(${minutesDeg + 360}deg); -o-transform: rotate(${minutesDeg + 360}deg); transform: rotate(${minutesDeg + 360}deg); }} @keyframes rotateHourHand { from { -webkit-transform: rotate(${hoursDeg}deg); -moz-transform: rotate(${hoursDeg}deg); -ms-transform: rotate(${hoursDeg}deg); -o-transform: rotate(${hoursDeg}deg); transform: rotate(${hoursDeg}deg); } to { -webkit-transform: rotate(${hoursDeg + 360}deg); -moz-transform: rotate(${hoursDeg + 360}deg); -ms-transform: rotate(${hoursDeg + 360}deg); -o-transform: rotate(${hoursDeg + 360}deg); transform: rotate(${hoursDeg + 360}deg); }}`; let watch = document.getElementById("watch");let watchHands = document.getElementById("watchHands");let closeButton = document.getElementById("closeButton");let onWristWatchViewBox = watch.getAttribute("viewBox");let onWristWatchX = watch.getAttribute("x");let onWristWatchY = watch.getAttribute("y");let onWristHandsViewBox = watchHands.getAttribute("viewBox");let onWristHandsX = watchHands.getAttribute("x");let onWristHandsY = watchHands.getAttribute("y"); function onClick() { style.innerHTML += `#person { display: none; } #watch, #watchHands { cursor: default; } svg { -webkit-transform: rotate(175deg) scale(5); -moz-transform: rotate(175deg) scale(5); -ms-transform: rotate(175deg) scale(5); -o-transform: rotate(175deg) scale(5); transform: rotate(175deg) scale(5); } #closeButton, #background { -webkit-transform: rotate(-175deg) scale(0.2); -moz-transform: rotate(-175deg) scale(0.2); -ms-transform: rotate(-175deg) scale(0.2); -o-transform: rotate(-175deg) scale(0.2); transform: rotate(-175deg) scale(0.2); } #closeButton { cursor: pointer; display: block; pointer-events: bounding-box; }`; watch.setAttribute("x", "';
        scriptParts[1] = '"); watch.setAttribute("y", "';
        scriptParts[2] = '"); watchHands.setAttribute("x", "';
        scriptParts[3] = '"); watchHands.setAttribute("y", "';
        scriptParts[4] = '"); } function onClose() { style.innerHTML += `#closeButton { display: none; } svg, #background { -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); } #person { display: inline; } #watch, #watchHands { cursor: pointer; }`; watch.setAttribute("viewBox", onWristWatchViewBox); watch.setAttribute("x", onWristWatchX); watch.setAttribute("y", onWristWatchY); watchHands.setAttribute("viewBox", onWristHandsViewBox); watchHands.setAttribute("x", onWristHandsX); watchHands.setAttribute("y", onWristHandsY); } watch.addEventListener("click", onClick); watchHands.addEventListener("click", onClick); closeButton.addEventListener("click", onClose); </script> ';
        return string(abi.encodePacked(
            scriptParts[0], 
            watchZoomX,
            scriptParts[1], 
            watchZoomY,
            scriptParts[2],
            handsZoomX,
            scriptParts[3],
            handsZoomY,
            scriptParts[4]
        ));
    }

    function renderSvg(uint256 dna) public view returns (string memory) {
        string memory person = renderPerson(dna);
        string memory watch = renderWatch(dna);

        string[2] memory svgParts;
        svgParts[0] = '<svg height="380" viewBox="0 0 380 380" fill="none" xmlns="http://www.w3.org/2000/svg"> <g id="background"> <rect width="380" height="380" fill="#E5E4EB"/> </g> <g id="closeButton"><line x1="322.121" y1="19" x2="362.426" y2="59.3051" stroke="#C8C8C8" stroke-width="3" stroke-linecap="round"/><line x1="322" y1="58.8787" x2="362.305" y2="18.5736" stroke="#C8C8C8" stroke-width="3" stroke-linecap="round"/></g>';
        svgParts[1] = '</svg>';
        
        return string(abi.encodePacked(
            svgParts[0],
            person,
            watch,
            svgParts[1]
        ));
    }

    function getFormattedTraitsArray(uint256 dna) public view returns (string memory) {
        string memory traits;
        uint16[NUM_TRAITS] memory numbersFromDna = splitDna(dna);
        uint8 shirt = _getTraitIndex(4, numbersFromDna[4], 0);
        uint256 i;
        for (; i < NUM_TRAITS; ) {
            traits = string(abi.encodePacked(
                traits,
                '{ "trait_type": "',
                IWatchClubTraitParser(traitParser).getCategoryName(i),
                '", "value": "',
                IWatchClubTraitParser(traitParser).getTraitName(i, _getTraitIndex(i, numbersFromDna[i], shirt)),
                '" }'
            ));

            if (i != (NUM_TRAITS - 1))
                traits = string(abi.encodePacked(traits, ","));

            unchecked {
                ++i;
            }
        }

        return string(abi.encodePacked("[ ", traits, " ]"));
    }

    function tokenUriJson(uint256 tokenId, uint256 dna) public view returns (bytes memory) {
        string memory svg = renderSvg(dna);
        string memory script = renderScript(dna);
        string memory html = string(abi.encodePacked(
            '<html><head><meta charset="utf-8"></head><body style="margin:0;padding:0;height:100vh;display:flex;justify-content:center;align-items:center;"> <div id="container">',
            svg,
            script,
            '</body></html>'
        ));

        // TODO make metadata
        return 
            abi.encodePacked(
            "{"
            '"name": "watchmfer ',
            toString(tokenId),
            '",'
            '"description": "watchmfers by 0xPATERSON",',
            string(abi.encodePacked('"attributes": ', getFormattedTraitsArray(dna), ',')),
            '"animation_url": "data:text/html;base64,',
            encode(bytes(html)),
            '","image": "data:image/svg+xml;base64,',
            encode(bytes(svg)),
            '"}'
        );
    }

    function tokenURI(uint256 tokenId, uint256 dna) public view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    encode(bytes(tokenUriJson(tokenId, dna)))
                )
            );
    }

    /*==============================================================
    ==              Utils - copied from other libs                ==
    ==============================================================*/

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}