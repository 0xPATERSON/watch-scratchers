//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchScratchersWatchCaseRenderer.sol";
import "./interfaces/IEthereumWatchCoWatchHandsRenderer.sol";
import "./interfaces/IEthereumWatchCoWatchRenderer.sol";
import "./interfaces/IEthereumWatchCoRenderer.sol";

// TODO: update function visibilities

contract EthereumWatchCoRenderer is Ownable, IEthereumWatchCoRenderer {
    address public watchRenderer;
    address public personRenderer;
    
    constructor() {}

    function renderSvg(uint256 dna) private view returns (string memory) {
        string[2] memory svgParts;
        return '';
    }

    function renderHtml(string memory svg) private pure returns (string memory) {
        string[2] memory htmlParts;
        htmlParts[0] = '<html><head><meta charset="utf-8"></head><body style="margin:0; padding:0; text-align:center;">';
        htmlParts[1] = '<script> let style = document.getElementById("watch-hands-style"); let date = new Date(); let hours = date.getHours(); let minutes = date.getMinutes(); let seconds = date.getSeconds(); let secondsDeg = seconds * 6 - 175; let minutesDeg = minutes * 6 + seconds * 0.1 - 175; let hoursDeg = hours * 30 + minutes * 0.5 - 175; style.innerHTML += `@keyframes rotateSecondHand { from { -webkit-transform: rotate(${secondsDeg}deg); -moz-transform: rotate(${secondsDeg}deg); -ms-transform: rotate(${secondsDeg}deg); -o-transform: rotate(${secondsDeg}deg); transform: rotate(${secondsDeg}deg); } to { -webkit-transform: rotate(${secondsDeg + 360}deg); -moz-transform: rotate(${secondsDeg + 360}deg); -ms-transform: rotate(${secondsDeg + 360}deg); -o-transform: rotate(${secondsDeg + 360}deg); transform: rotate(${secondsDeg + 360}deg); }} @keyframes rotateMinuteHand { from { -webkit-transform: rotate(${minutesDeg}deg); -moz-transform: rotate(${minutesDeg}deg); -ms-transform: rotate(${minutesDeg}deg); -o-transform: rotate(${minutesDeg}deg); transform: rotate(${minutesDeg}deg); } to { -webkit-transform: rotate(${minutesDeg + 360}deg); -moz-transform: rotate(${minutesDeg + 360}deg); -ms-transform: rotate(${minutesDeg + 360}deg); -o-transform: rotate(${minutesDeg + 360}deg); transform: rotate(${minutesDeg + 360}deg); }} @keyframes rotateHourHand { from { -webkit-transform: rotate(${hoursDeg}deg); -moz-transform: rotate(${hoursDeg}deg); -ms-transform: rotate(${hoursDeg}deg); -o-transform: rotate(${hoursDeg}deg); transform: rotate(${hoursDeg}deg); } to { -webkit-transform: rotate(${hoursDeg + 360}deg); -moz-transform: rotate(${hoursDeg + 360}deg); -ms-transform: rotate(${hoursDeg + 360}deg); -o-transform: rotate(${hoursDeg + 360}deg); transform: rotate(${hoursDeg + 360}deg); }}`; </script></body></html>';
        return string(abi.encodePacked(
            htmlParts[0],
            svg,
            htmlParts[1]
        ));
    }

    function tokenURI(uint256 tokenId, uint256 dna) external view returns (string memory) {
        string memory svg = renderSvg(dna);
        string memory html = renderHtml(svg);
        return 
        string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    base64Encode(
                        abi.encodePacked(
                            "{"
                            '"name": "EWC ',
                            toString(tokenId),
                            '",'
                            '"description": "description x",',
                            string(abi.encodePacked('"attributes": [ { "trait_type": "Type", "value": "Test" } ],')),
                            '"animation_url": "data:text/html;base64,',
                            base64Encode(bytes(html)),
                            '","image": "data:image/svg+xml;base64,',
                            base64Encode(bytes(svg)),
                            '"}'
                        )
                    )
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
    function base64Encode(bytes memory data) internal pure returns (string memory) {
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