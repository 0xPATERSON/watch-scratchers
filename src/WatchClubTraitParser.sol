//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/IWatchClubTraitParser.sol";

contract WatchClubTraitParser is Ownable, IWatchClubTraitParser {
    error TraitNotFound();
    error CategoryNotFound();

    constructor() {}

    function getWatchName(uint16 watch) public pure returns (string memory) {
        if (watch > 63) {
            revert TraitNotFound();
        }

        string[64] memory names = [
            'tiffany nautilus', 'blue nautilus', 'green nautilus', 'white nautilus', 'chocolate nautilus',
            'white ap', 'blue ap', 'grey ap', 'black ap', 'blue ap rose gold', 'black ap rose gold', 'black ap ceramic',
            'blue overseas', 'black overseas', 'white overesas', 'blue overseas rose gold',
            'black sub', 'hulk sub', 'smurf sub', 'starbucks sub', 'blueberry sub', 'black sub two-tone', 'bluesy sub', 
            'black sub yellow gold', 'blue sub yellow gold',
            'rhodium yacht', 'blue yacht',
            'yellow op', 'green op', 'coral op', 'turquoise op', 'pink op', 'black op', 'blue op',
            'white datejust', 'blue datejust', 'rhodium datejust', 'black datejust', 'champagne datejust',
            'explorer', 'explorer two-tone',
            'white daydate yellow gold', 'champagne daydate', 'black daydate yellow gold', 'olive daydate rose gold', 
            'chocolate daydate', 'ice blue daydate', 'olive daydate platinum',
            'white aquaterra', 'blue aquaterra', 'grey aquaterra', 'black aquaterra',
            'black pilot', 'white pilot', 'blue pilot', 'top gun pilot',
            'senator', 'snowflake', 
            'tank', 'tank rose gold', 'tank yellow gold',
            'tank f', 'tank f rose gold', 'tank f yellow gold'
        ];

        return names[watch];
    }

    function getTraitName(uint256 category, uint16 trait) public pure returns (string memory) {
        string[9] memory hatNames = ['black', 'brown', 'red', 'blue', 'navy', 'lavender', 'white', 'denim', 'none'];
        string[5] memory glassesNames = ['round', 'aviator', 'gold round', 'gold aviator', 'none'];
        string[2] memory earphoneNames = ['airpods', 'none'];
        string[8] memory shirtNames = ['blue', 'red', 'purple', 'brown', 'navy', 'cream', 'grey', 'white'];
        string[2] memory mouthNames = ['smile', 'serious'];
        string[8] memory backgroundNames = ['cream', 'ice blue', 'silver', 'platinum', 'rose', 'gold', 'olive', 'pink'];

        if (category == 0 && trait < 64) {
            return getWatchName(trait);
        } else if (category == 1 && trait < 9) {
            return hatNames[trait];
        } else if (category == 2 && trait < 5) {
            return glassesNames[trait];
        } else if (category == 3 && trait < 2) {
            return earphoneNames[trait];
        } else if (category == 4 && trait < 8) {
            return shirtNames[trait];
        } else if (category == 5 && trait < 2) {
            return mouthNames[trait];
        } else if (category == 6 && trait < 8) {
            return backgroundNames[trait];
        } else {
            if (category > 6) {
                revert CategoryNotFound();
            }
            revert TraitNotFound();
        }
    }

    function getCategoryName(uint256 category) public pure returns (string memory) {
        if (category == 0) {
            return 'watch';
        } else if (category == 1) {
            return 'hat';
        } else if (category == 2) {
            return 'glasses';
        } else if (category == 3) {
            return 'earphones';
        } else if (category == 4) {
            return 'shirt';
        } else if (category == 5) {
            return 'mouth';
        } else if (category == 6) {
            return 'background';
        } else {
            revert CategoryNotFound();
        }
    }
}