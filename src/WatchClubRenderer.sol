//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchClubWatchRenderer.sol";
import "./interfaces/IWatchClubRenderer.sol";
import "./interfaces/IWatchClubPersonRenderer.sol";

// TODO: update function visibilities

contract WatchClubRenderer is Ownable, IWatchClubRenderer {
    error TraitNotFound();

    address public watchRenderer;
    address public personRenderer;
    
    constructor() {}

    function setPersonRenderer(address _personRenderer) external onlyOwner {
        personRenderer = _personRenderer;
    }

    function setWatchRenderer(address _watchRenderer) external onlyOwner {
        watchRenderer = _watchRenderer;
    }

    function _getTraitNumberFromWeightsArray(uint8[10] memory weightsArray, uint16 numberFromDna) public pure returns (uint8) {
        uint8 i;
        for (; i < weightsArray.length;) {
            if (weightsArray[i] >= numberFromDna) {
                return i;
            }
            ++i;
        }
        revert TraitNotFound();
    }

    // same with getTraitNumberFromWeightsArray, just with an 64 length
    function _getWatchType(uint16[64] memory weightsArray, uint16 numberFromDna) public pure returns (uint8) {
        uint8 i;
        for (; i < weightsArray.length;) {
            if (weightsArray[i] >= numberFromDna) {
                return i;
            }
            ++i;
        }
        revert TraitNotFound();
    }

    function splitDna(uint256 dna) public pure returns (uint16[7] memory) {
        uint16[7] memory numbers;
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
        uint16[7] memory numbersFromDna = splitDna(dna);
        string memory watch = IWatchClubWatchRenderer(watchRenderer).renderWatch(
            IWatchClubWatchRenderer.WatchType(_getWatchType(WATCH_WEIGHTS, numbersFromDna[0]))
        );
        return watch;

    }

    function renderPerson(uint256 dna) public view returns (string memory) {
        uint8[10] memory GLASSES_WEIGHTS = [24, 49, 59, 69, 99, 0, 0, 0, 0, 0];
        uint8[10] memory EAR_WEIGHTS = [19, 99, 0, 0, 0, 0, 0, 0, 0, 0];
        uint8[10] memory SHIRT_WEIGHTS = [12, 25, 37, 50, 63, 75, 87, 99, 0, 0];
        uint8[10] memory MOUTH_WEIGHTS = [49, 99, 0, 0, 0, 0, 0, 0, 0, 0];
        uint8[10] memory BACKGROUND_WEIGHTS = [12, 25, 37, 50, 63, 75, 87, 99, 0, 0];
        uint8[10][10] memory HAT_WEIGHTS;
        // To prevent shirt + hat combos that look bad, HAT_WEIGHTS[x][y] is a 2D array where x is the shirt type and y is the hat type
        HAT_WEIGHTS[0] = [14, 28, 0, 42, 56, 70, 84, 0, 99, 0];
        HAT_WEIGHTS[1] = [16, 33, 49, 66, 0, 0, 83, 0, 99, 0];
        HAT_WEIGHTS[2] = [14, 28, 0, 42, 56, 70, 84, 0, 99, 0];
        HAT_WEIGHTS[3] = [16, 33, 0, 49,66, 0, 83, 0, 99, 0];
        HAT_WEIGHTS[4] = [19, 0, 0, 39, 0, 59, 79, 0, 99, 0];
        HAT_WEIGHTS[5] = [14, 28, 0, 42, 0, 56, 70, 84, 99, 0];
        HAT_WEIGHTS[6] = [16, 0, 0, 0, 33, 49, 66, 83, 99, 0];
        HAT_WEIGHTS[7] = [11, 22, 33, 44, 55, 66, 77, 88, 99, 0];

        uint16[7] memory numbersFromDna = splitDna(dna);
        uint8 shirt = _getTraitNumberFromWeightsArray(SHIRT_WEIGHTS, numbersFromDna[4]);
        string memory person = IWatchClubPersonRenderer(personRenderer).renderPerson(
            IWatchClubPersonRenderer.HatType(_getTraitNumberFromWeightsArray(HAT_WEIGHTS[shirt], numbersFromDna[1])),
            IWatchClubPersonRenderer.GlassesType(_getTraitNumberFromWeightsArray(GLASSES_WEIGHTS, numbersFromDna[2])),
            IWatchClubPersonRenderer.EarType(_getTraitNumberFromWeightsArray(EAR_WEIGHTS, numbersFromDna[3])),
            IWatchClubPersonRenderer.ShirtType(shirt),
            IWatchClubPersonRenderer.MouthType(_getTraitNumberFromWeightsArray(MOUTH_WEIGHTS, numbersFromDna[5])),
            IWatchClubPersonRenderer.BackgroundType(_getTraitNumberFromWeightsArray(BACKGROUND_WEIGHTS, numbersFromDna[6]))
        );
        return person;
    }

    function tokenURI(uint256 tokenId, uint256 dna) external pure returns (string memory) {
        // TODO: fill this out
        return string(abi.encodePacked(
            tokenId,
            dna
        ));
    }
}