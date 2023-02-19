//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWatchClubPersonRenderer {
    enum HatType { BLACK, BROWN, RED, BLUE, NAVY, LAVENDER, WHITE, DENIM, NONE }
    enum GlassesType { ROUND, AVIATOR, ROUND_GOLD, AVIATOR_GOLD, NONE }
    enum EarType { AIRPODS, NONE }
    enum ShirtType { BLUE, RED, PURPLE, BROWN, NAVY, CREAM, GREY, WHITE}
    enum MouthType { SMILE, SERIOUS }
    enum BackgroundType { CREAM, ICE, SILVER, PLATINUM, ROSE, GOLD, OLIVE, PINK}

    function renderPerson(
        HatType hatType, 
        GlassesType glassesType, 
        EarType earType, 
        ShirtType shirtType, 
        MouthType mouthType, 
        BackgroundType backgroundType
    ) external view returns (string memory);
}