//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract EthereumWatchCoPersonRenderer is Ownable {
    constructor() {}

    // TODO: these need to be numbers in an array, which I can then use to index into, enums are not necessary
    // checkout chain runners: https://mirror.xyz/0x88a0371fc2BefDfC6F675F9293DE32ef79D6f6c7/6BT2CYyZjqKJ2FKIohLt9cNb_TYJHjFBn_0sTKU5vOc 
    enum HatType { BROWN, BLACK, RED, BLUE, NAVY, LAVENDER, WHITE, NONE }
    enum GlassesType { ROUND, AVIATOR, ROUND_GOLD, AVIATOR_GOLD, NONE }
    enum EarType { AIRPODS, NONE }
    enum ShirtType { BLUE, RED, PURPLE, BROWN, NAVY, GREEN, GREY, BLACK, WHITE, GOLD }
    enum MouthType { SMILE, SERIOUS }
    enum BackgroundType { CREAM, ICE, SILVER, PLATINUM, BROWN, ROSE, GOLD, OLIVE, PINK}

    string[6] private HAT_COLORS = ['#7D5C49', '#322E32', '#D7002F', '#005AC6', '#193352', '#CBC2E6'];
    string[6] private HAT_SHADOW_COLORS = ['#664B3C', '#282528', '#AA0025', '#0049A0', '#132841', '#ADA5C5'];
    string[10] private SHIRT_COLORS = ['#005AC6', '#D7002F', '#9063D8', '#39322A', '#193352', '#00B661', '#62666C', '#322E32', '#F2F3F4', '#FFE200'];
    string[10] private SHIRT_SHADOW_COLORS = ['#0049A0', '#AA0025', '#634698', '#2C2620', '#132841', '#008044', '#43484B', '#282528', '#CDCDCF', '#FF9900'];
    string [9] private BACKGROUND_COLORS = ['#FBF6E9', '#C4EAF2', '#E5E4EB', '#FDFDFD', '#8C7A66', '#FFEDE6', '#FFFBE3', '#B8C6A9', '#FAD5DC'];

    function _renderHat(HatType hatType) private view returns (string memory) {
        if (hatType == HatType.NONE) {
            return '';
        }
        string memory color = HAT_COLORS[uint256(hatType)];
        string memory shadow = HAT_SHADOW_COLORS[uint256(hatType)];
        string memory partOne = '<path d="m254.32 130.77c0 3.302-1.809 7.212-6.78 11.512-4.953 4.287-12.471 8.419-22.28 12.009-19.571 7.163-47.006 11.711-77.602 11.711-30.595 0-58.03-4.548-77.601-11.711-9.8095-3.59-17.327-7.722-22.28-12.009-4.9704-4.3-6.7795-8.21-6.7795-11.512s1.8091-7.211 6.7795-11.512c4.9536-4.286 12.471-8.418 22.28-12.008 19.571-7.163 47.006-11.711 77.601-11.711 30.596 0 58.031 4.5484 77.602 11.711 9.809 3.59 17.327 7.722 22.28 12.008 4.971 4.301 6.78 8.21 6.78 11.512z" fill="';
        string memory partTwo = '" stroke="#161B1F" stroke-width="12"/><path d="m65.639 110.2 240.53 39.226c-5.388-70.084-65.145-123.06-133.74-118.42-49.222 3.3277-89.653 35.421-106.79 79.194z" clip-rule="evenodd" fill="';
        string memory partThree = '" fill-rule="evenodd"/><path d="m295.5 149.55c0.167-15-5.3-51.2-26.5-80" stroke="';
        string memory partFour = '" stroke-width="12"/><path d="m305.68 150.4-239.47-41.723c-1.1705-0.203 2.4386-7.611 4.3894-11.29 14.046-26.702 37.391-44.177 47.308-49.576 39.407-23.561 82.423-16.362 99.005-9.8171 55.014 16.885 78.87 63.811 85.838 88.354 3.121 10.995 6.015 24.542 2.926 24.052z" stroke="#161B1F" stroke-width="12"/><path d="m234.03 34.324c-1.096 3.1984-6.172 6.3409-13 4.0002-6.827-2.3407-8.907-7.9367-7.811-11.135 1.097-3.1984 6.173-6.3409 13-4.0002 6.828 2.3407 8.908 7.9367 7.811 11.135z" fill="';
        string memory partFive = '" stroke="#161B1F" stroke-width="12"/>';
        return string(abi.encodePacked(partOne, color, partTwo, color, partThree, shadow, partFour, color, partFive));
    }

    function _renderGlasses(GlassesType glassesType) private pure returns (string memory) {
        string memory blackLens = '#404042';
        string memory goldLens = '#FBECC8';
        string memory roundPartOne = '<line x1="150" y1="146" x2="174" y2="146" stroke="black" stroke-width="10"/><line x1="236" y1="146" x2="262" y2="146" stroke="black" stroke-width="10" stroke-linecap="round"/><line x1="74" y1="146" x2="84" y2="146" stroke="black" stroke-width="10" stroke-linecap="round"/><circle cx="114" cy="158" r="35" fill="';
        string memory roundPartTwo = '" stroke="black" stroke-width="10"/><circle cx="209" cy="158" r="35" fill="';
        string memory roundPartThree = '" stroke="black" stroke-width="10"/>';
        string memory aviatorPartOne = '<ellipse cx="112" cy="155.96" rx="39" ry="35.963" fill="';
        string memory aviatorPartTwo = '"/><ellipse cx="211" cy="155.96" rx="39" ry="35.963" fill="';
        string memory aviatorPartThree = '"/><path d="m77.745 145.58c5.038-17.058 24.059-21.669 32.94-21.842 8.914 0 18.893 1.387 22.768 2.08 13.951 1.664 17.439 11.788 17.439 16.641-0.775 9.569-2.261 16.815-2.906 19.242-3.488 15.809-16.632 25.308-22.768 28.082-13.176 5.824-26.804 2.427-31.972 0-19.764-7.489-18.569-32.589-15.501-44.203z" stroke="#000" stroke-width="10"/><path d="m245.93 145.06c-5.038-17.057-24.06-21.668-32.941-21.841-8.913 0-18.892 1.386-22.767 2.08-13.952 1.664-17.439 11.787-17.439 16.641 0.775 9.569 2.26 16.815 2.906 19.242 3.488 15.809 16.632 25.308 22.768 28.082 13.176 5.824 26.804 2.426 31.971 0 19.764-7.489 18.57-32.589 15.502-44.204z" stroke="#000" stroke-width="10"/><path d="m152.36 140.63c2.833-1.214 10.4-2.913 18 0" stroke="#000" stroke-width="10"/><line x1="118" x2="202" y1="123.99" y2="123.99" stroke="#000" stroke-width="10"/><line x1="250" x2="260" y1="150.43" y2="150.43" stroke="#000" stroke-linecap="round" stroke-width="10"/><line x1="72" x2="73" y1="150.43" y2="150.43" stroke="#000" stroke-linecap="round" stroke-width="10"/>';

        if (glassesType == GlassesType.NONE) {
            return '';
        } else if (glassesType == GlassesType.AVIATOR) {
            return string(abi.encodePacked(aviatorPartOne, blackLens, aviatorPartTwo, blackLens, aviatorPartThree));
        } else if (glassesType == GlassesType.AVIATOR_GOLD) {
            return string(abi.encodePacked(aviatorPartOne, goldLens, aviatorPartTwo, goldLens, aviatorPartThree));
        } else if (glassesType == GlassesType.ROUND) {
            return string(abi.encodePacked(roundPartOne, blackLens, roundPartTwo, blackLens, roundPartThree));
        } else {
            // ROUND_GOLD
            return string(abi.encodePacked(roundPartOne, goldLens, roundPartTwo, goldLens, roundPartThree));
        }
    }

    function _renderBodyAndBackground(
        ShirtType shirtType,
        BackgroundType backgroundType
    ) private view returns (string memory) {
        string memory partOne = '<g><rect width="380" height="380" fill="';
        string memory partTwo = '"/><rect x="153" y="253" width="94" height="187" fill="';
        string memory partThree = '"/><rect x="196.293" y="266.171" width="53.1566" height="201.704" transform="rotate(-15.3932 196.293 266.171)" fill="';
        string memory partFour = '"/><path d="M239.766 243C228.48 249.211 211.739 272.472 159.331 264.441" stroke="';
        string memory partFive = '" stroke-width="48"/><path d="M127 357C156.599 334.333 221.237 296.337 243 325.69" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/><path d="M153 280C146.39 289.981 131.936 319.356 127 357" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/><path d="M306 154.5C306 215.757 253.278 266 187.5 266C121.722 266 69 215.757 69 154.5C69 93.2426 121.722 43 187.5 43C253.278 43 306 93.2426 306 154.5Z" fill="white" stroke="#161B1F" stroke-width="12"/><path fill-rule="evenodd" clip-rule="evenodd" d="M193.152 273.263C193.218 273.261 193.285 273.259 193.351 273.257C193.352 273.257 193.352 273.257 193.352 273.257C193.285 273.259 193.219 273.261 193.152 273.263ZM258.364 72.6905C276.684 93.3708 288.08 120.12 288.92 149.592C289.962 186.16 274.542 219.468 249.218 242.741C280.786 223.446 301.053 189.368 299.978 151.646C299.068 119.718 283.042 91.2675 258.364 72.6905Z" fill="#E7E3E4"/><path d="M155 263.5C153.667 286.5 150.9 352.4 150.5 440" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/><path d="M242 256C250.333 277.833 272.5 347.9 294.5 453.5" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/><ellipse cx="122.682" cy="141.872" rx="7.68156" ry="11.8715" fill="#161B1F"/><ellipse cx="211.682" cy="141.872" rx="7.68156" ry="11.8715" fill="#161B1F"/><path d="M249.5 278C251.5 309.333 255.8 363.6 251 360C219 337.667 153.7 299.9 148.5 327.5" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/>';
        
        return string(abi.encodePacked(
            partOne, 
            BACKGROUND_COLORS[uint256(backgroundType)],
            partTwo, 
            SHIRT_COLORS[uint256(shirtType)],
            partThree,
            SHIRT_COLORS[uint256(shirtType)], 
            partFour,
            SHIRT_SHADOW_COLORS[uint256(shirtType)],
            partFive
        ));
    }

    function _renderFace(MouthType mouthType, EarType earType) private pure returns (string memory) {
        string memory mouth;
        string memory airpods = '<line x1="283.408" y1="185.637" x2="279.452" y2="185.05" stroke="#CCCDD1" stroke-width="5"/><path d="M288.108 165.137C287.443 170.064 282.913 173.518 277.99 172.853C273.068 172.189 269.615 167.658 270.28 162.731C270.945 157.804 275.476 154.351 280.398 155.015C285.32 155.679 288.773 160.21 288.108 165.137Z" fill="white" stroke="black" stroke-width="5"/><line x1="279.893" y1="172.491" x2="277.012" y2="191.271" stroke="black" stroke-width="5"/><line x1="288.185" y1="164.623" x2="283.789" y2="193.288" stroke="black" stroke-width="5"/><line x1="286.609" y1="191.231" x2="274.748" y2="189.407" stroke="black" stroke-width="5"/><ellipse cx="276.274" cy="162.371" rx="2.495" ry="2.5" transform="rotate(7.6862 276.274 162.371)" fill="black"/>';
        if (mouthType == MouthType.SERIOUS) {
            mouth = '<path d="M174.5 234.5C172.167 232.333 165.4 227.8 157 227" stroke="#161B1F" stroke-width="10" stroke-linecap="round"/>';
        } else {
            mouth = '<path d="M150 232.659C154.5 235 174 238 185 230" stroke="#161B1F" stroke-width="12" stroke-linecap="round"/>';
        }
        if (earType == EarType.NONE) {
            return mouth;
        } else {
            return string(abi.encodePacked(
                mouth, 
                airpods
            ));
        }
    }

    function renderPersonSvg(
        HatType hatType, 
        GlassesType glassesType, 
        EarType earType, 
        ShirtType shirtType, 
        MouthType mouthType, 
        BackgroundType backgroundType
    ) public view returns (string memory) {
        string memory bodyAndBackground = _renderBodyAndBackground(shirtType, backgroundType);
        string memory face = _renderFace(mouthType, earType);
        string memory hat = _renderHat(hatType);
        string memory glasses = _renderGlasses(glassesType);
        return string(abi.encodePacked(
            bodyAndBackground, 
            face,
            glasses,
            hat,
            '</g>'
        ));
    }
}