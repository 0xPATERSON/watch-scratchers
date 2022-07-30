// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {IWatchScratchers} from "./IWatchScratchers.sol";
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
                    unchecked { j++; }
                }
                unchecked{ i += 6; }
            }
            else {
                resultBytes[i] = _stringBytes[i];
            }
            unchecked{ i++; }
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
        svgParts[5] = '.hand { transition: -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); transition: transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275), -webkit-transform 200ms cubic-bezier(0.175, 0.885, 0.32, 1.275); } .hour-hand { animation: rotateHourHand 216000s linear infinite; } .hand-outer { stroke-width: 4px; color: var(--color-hand-outer); } .hand-inner { stroke-width: 2px; color: var(--color-hand-inner); } .minute-hand { animation: rotateMinuteHand 3600s linear infinite; } .second-hand { color: var(--color-accent); stroke-width: 2px; animation: rotateSecondHand 60s linear infinite; } ';
        return string(abi.encodePacked(
            svgParts[0],
            svgParts[1],
            svgParts[2],
            svgParts[3],
            svgParts[4],
            svgParts[5]
        ));
    }

    enum HandTypes {DRESS, ROUND, SPORT, TANK, SENATOR }

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
        if (handType == HandTypes.DRESS) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" y1="25" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="28" x2="50" y2="40"></line> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" y1="15" x2="50" y2="60"></line> <line class="hand-inner" x1="50" y1="18" x2="50" y2="40"></line> </g> <circle class="circle" cx="50" cy="50" r="3"></circle> <g class="hand second-hand"> <line x1="50" y1="10" x2="50" y2="65"></line> <circle cx="50" cy="50" r="3"></circle> </g> </g> </svg> ';
        } else if (handType == HandTypes.SPORT) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <circle class="hand-outer" cx="50" cy="33" r="5"/> <line class="hand-inner" x1="50" x2="50" y1="27" y2="50"/> <circle class="hand-inner" cx="50" cy="33" r="3.5"/> </g> <g class="hand minute-hand"> <line class="hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="17" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="65" r="2"/> <circle cx="50" cy="20" r="3"/> <circle class="hand-inner" cx="50" cy="20" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandTypes.ROUND) {
            svgParts[5] = '</style> <g> <g class="hand hour-hand"> <line class="hand-outer" x1="50" x2="50" y1="25" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="25" y2="50"/> </g> <g class="hand minute-hand"> <line class="hand hand-outer" x1="50" x2="50" y1="15" y2="50"/> <line class="hand-inner" x1="50" x2="50" y1="15" y2="50"/> </g> <circle class="circle" cx="50" cy="50" r="3"/> <g class="hand second-hand"> <line x1="50" x2="50" y1="10" y2="65"/> <circle cx="50" cy="50" r="1.5"/> </g> </g> </svg> ';
        } else if (handType == HandTypes.TANK) {
            // TODO
        } else if (handType == HandTypes.SENATOR) {
            // TODO 
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

    // function renderPP() private view returns(string memory) {

    // }

    // function _renderDJ() public pure returns (string memory) {
    //     string[4] memory svgParts;
    //     svgParts[0] = '<svg width="600" height="600" viewBox="0 0 600 600" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <rect width="600" height="600" fill="#FBF6E9" /> ';
    //     svgParts[1] = '<svg x="155.15" y="100" width="499" height="683" viewBox="0 0 852 1166" xmlns="http://www.w3.org/2000/svg"> <rect x="77" y="125" width="37" height="45" fill="#B2B2B2"/> <rect x="343" y="125" width="37" height="45" fill="#B2B2B2"/> <rect x="289" y="19" width="41" height="119" fill="#B2B2B2"/> <rect x="132" y="20" width="44" height="119" fill="#B2B2B2"/> <rect x="195" y="20" width="79" height="119" fill="#EBEBEB"/> <rect transform="matrix(1 0 0 -1 77 563)" width="37" height="45" fill="#B2B2B2"/> <rect transform="matrix(1 0 0 -1 343 563)" width="37" height="45" fill="#B2B2B2"/> <rect transform="matrix(1 0 0 -1 289 669)" width="41" height="119" fill="#B2B2B2"/> <rect transform="matrix(1 0 0 -1 132 668)" width="44" height="119" fill="#B2B2B2"/> <rect transform="matrix(1 0 0 -1 195 668)" width="79" height="119" fill="#EBEBEB"/> <rect x="445" y="314" width="42" height="75" fill="#B2B2B2"/> <circle cx="229" cy="345" r="215" fill="#B2B2B2" stroke="#000" stroke-width="28"/> <circle cx="228.5" cy="344.5" r="174.5" fill="#F5F5F5" stroke="#000" stroke-width="28"/> <line x1="443" x2="499" y1="311" y2="311" stroke="#000" stroke-width="28"/> <line x1="485" x2="485" y1="317" y2="406" stroke="#000" stroke-width="28"/> <line x1="443" x2="482.2" y1="392" y2="392" stroke="#000" stroke-width="28"/> <line transform="matrix(-.07171 -.99743 -.99743 .07171 326 156)" x2="153.4" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line x1="54.553" x2="85.553" y1="219.1" y2="112.1" stroke="#000" stroke-width="28"/> <line transform="matrix(-.27828 -.9605 -.9605 .27828 390 223)" x2="111.4" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line x1="75.132" x2="118.13" y1="121.3" y2="112.3" stroke="#000" stroke-width="28"/> <line transform="matrix(-.97879 -.20486 -.20486 .97879 380 135)" x2="43.932" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line x1="118.04" x2="129.04" y1="155" y2="1.996" stroke="#000" stroke-width="28"/> <line x1="115" x2="343" y1="15" y2="15" stroke="#000" stroke-width="28"/> <line x1="185" x2="185" y1="25" y2="129.02" stroke="#000" stroke-width="28"/> <line x1="278" x2="278" y1="27" y2="131.02" stroke="#000" stroke-width="28"/> <line x1="132" x2="171.01" y1="98" y2="98" stroke="#000" stroke-width="28"/> <line x1="287" x2="326.01" y1="98" y2="98" stroke="#000" stroke-width="28"/> <line x1="190" x2="269" y1="75" y2="75" stroke="#000" stroke-width="28"/> <line x1="339.96" x2="328.96" y1="534" y2="687" stroke="#000" stroke-width="28"/> <line transform="matrix(.27828 .9605 .9605 -.27828 68 466)" x2="111.4" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line x1="403.45" x2="372.45" y1="469.9" y2="576.9" stroke="#000" stroke-width="28"/> <line transform="matrix(.97879 .20486 .20486 -.97879 78 554)" x2="43.932" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line x1="382.87" x2="339.87" y1="567.7" y2="576.7" stroke="#000" stroke-width="28"/> <line transform="matrix(.07171 .99743 .99743 -.07171 132 533)" x2="153.4" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(1 0 0 -1 115 660)" x2="228" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(0 -1 -1 0 171 664)" x2="104.02" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(0 -1 -1 0 264 662)" x2="104.02" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(1 0 0 -1 132 577)" x2="39.013" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(1 0 0 -1 287 577)" x2="39.013" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <line transform="matrix(1 0 0 -1 190 600)" x2="79" y1="-14" y2="-14" stroke="#000" stroke-width="28"/> <rect transform="rotate(-32.703 147.18 219.72)" x="147.18" y="219.72" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="matrix(.84148 .54028 .54028 -.84148 146.38 469.44)" x="1.3818" y="-.3012" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="rotate(147.3 307.12 470.44)" x="307.12" y="470.44" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect x="224" y="459" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="matrix(-.84148 -.54028 -.54028 .84148 306.12 218.8)" x="-1.3818" y=".3012" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="rotate(-61.388 97.357 276.17)" x="97.357" y="276.17" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="matrix(.47888 .87788 .87788 -.47888 96.357 414.46)" x="1.3568" y=".39901" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="rotate(118.61 361.52 415.46)" x="361.52" y="415.46" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="rotate(-90 79 350.03)" x="79" y="350.03" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect transform="matrix(-.47888 -.87788 -.87788 .47888 360.52 275.17)" x="-1.3568" y="-.39901" width="10.034" height="35.72" fill="#EDEDED" stroke="#5C5F60" stroke-width="2"/> <rect x="308" y="314" width="79" height="62" rx="31" fill="#F9F8F8" stroke="#5C5F60" stroke-width="2"/> <path d="m210.21 205.19 18.288-11.991 18.288 11.991-6.941 19.28h-22.694l-6.941-19.28z" fill="#E3E3E3" stroke="#78797A" stroke-width="2"/> <path d="m243 227c0 2.628-1.499 5.104-4.119 6.963-2.617 1.857-6.284 3.037-10.381 3.037s-7.764-1.18-10.381-3.037c-2.62-1.859-4.119-4.335-4.119-6.963s1.499-5.104 4.119-6.963c2.617-1.857 6.284-3.037 10.381-3.037s7.764 1.18 10.381 3.037c2.62 1.859 4.119 4.335 4.119 6.963z" fill="#E3E3E3" stroke="#78797A" stroke-width="2"/> <path d="m235 229c0 2.565-2.69 5-6.5 5s-6.5-2.435-6.5-5 2.69-5 6.5-5 6.5 2.435 6.5 5z" fill="#fff" stroke="#66686A" stroke-width="2"/> </svg> ';
    //     svgParts[2] = _renderDressHands("0 0 280 280", "182", "195", "#B2B2B2", "#B2B2B2", "#E8E8E8", 150, 342, 60);
    //     svgParts[3] = '</svg>';
    //     string memory output = string(abi.encodePacked(
    //         svgParts[0], 
    //         svgParts[1], 
    //         svgParts[2], 
    //         svgParts[3]
    //     ));
    //     return output;
    // }

    // function renderWatchSvg(uint256 configuration, uint256 timezone) public view returns (string memory) {

    // }

    // function render() {
    // /*
    //     Arrays containing the probability weights of each trait. 
    //         0. watch
    //         1. background
    //         2. species
    //         3. eyes
    //         4. mouth
    //         5. head
    //         6. ear
            

    //     Credits to Chain Runners for the inspiration.
    // */
    // uint16[][NUM_TRAITS] WEIGHTS;
    // // watches
    // WEIGHTS[0] = [
    //     // PP - tiffany
    //     3, 
    //     // PP - chocolate
    //     8, 
    //     // PPs - green, blue, white
    //     14, 19, 24, 
    //     // Subs - steel - black, black nd, sbucks, hulk
    //     38, 52, 66, 80, 
    //     // Subs - two tone - black, blue
    //     93, 106,
    //     // Subs - gold - smurf, blueberry, black, blue
    //     116, 126, 136, 146,
    //     // Explorers - two tone, steel
    //     159, 173,
    //     // DDs - yellow gold - white, champagne, black
    //     183, 193, 203, 
    //     // DDs - rose gold - olive, chocolate, white
    //     213, 223, 233,
    //     // DDs - platinum - olive, ice blue
    //     240, 247, 254,
    //     // AP ceramic black
    //     258, 
    //     // APs - steel - white, blue, slate, black
    //     268, 278, 288, 298,
    //     // APs - gold - rose blue, rose black, yellow blue
    //     305, 312, 319,
    //     // VCs - steel - blue, black, white
    //     329, 339, 349,
    //     // VC - rose gold blue
    //     356,
    //     // Snowflake
    //     400,
    //     // Tanks - steel, rose, yellow
    //     420, 434, 448,
    //     // Francaise - steel, rose, yellow
    //     450, 463, 476,
    //     // Pilots - black, white, blue
    //     489, 502, 515,
    //     // Pilot - ceramic black
    //     520, 
    //     // Senator
    //     530, 
    //     // Luminor
    //     550,
    //     // YM - rhodium, blue
    //     560, 570,
    //     // AT - white blue, gray, black
    //     610, 650, 690, 730,
    //     // DJs - steel - white, blue, rhodium, black, pink
    //     760, 790, 820, 850, 880,
    //     // DJs - two tone - white, rhodium, champagne, rose rhodium
    //     895, 910, 925, 940,
    //     // OPs - yellow, green, coral, tiffany, black, blue
    //     950, 960, 970, 980, 990, 999
    // ];
    // // background - cream, gray, pink, light gray, tiffany
    // WEIGHTS[1] = [200, 400, 600, 800, 999];
    // // type - normal, robot, alien
    // WEIGHTS[2] = [750, 900, 999];
    // // eyes - shades, red shades, blue shades, purple shades, zala, 3d, bandit, none
    // WEIGHTS[3] = [200, 300, 400, 500, 533, 566, 599, 999];
    // // mouth - smile, open
    // WEIGHTS[4] = [500, 999];
    // // head
    // WEIGHTS[5] = [
    //     // top hats - black, white
    //     16, 32,
    //     // fedoras - mafia, agent
    //     64, 96,
    //     // headbands - orange, neon, red, yellow, klein blue, ninja
    //     128, 160, 192, 224, 256, 270,
    //     // caps - orange, neon, red, yellow, klein blue, black, lavender, designer brown, designer black, tennis
    //     302, 334, 366, 398, 430, 462, 494, 510, 526, 542,
    //     // beanies - orange, red, klein blue, brown, black, purple, gray, sniper
    //     574, 606, 638, 670, 702, 734, 766, 782,
    //     // none
    //     999
    // ];
    // // ear - airpods, none
    // WEIGHTS[6] = [100, 999];
    // }
    
}