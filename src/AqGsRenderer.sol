//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IWatchClubCaseRenderer.sol";


contract AqGsRenderer is IWatchClubCaseRenderer {
    constructor() {}

    function renderSvg(
        IWatchClubCaseRenderer.CaseType caseType
    ) external pure returns (string memory) {
        if (caseType == IWatchClubCaseRenderer.CaseType.AQ) {
            return '<rect transform="rotate(157.54 574.08 217.7)" x="574.08" y="217.7" width="44.553" height="87.035" fill="#ddd"/><rect transform="matrix(.84372 .53678 .53678 -.84372 169.96 182.34)" width="44.553" height="87.035" fill="#ddd"/><rect transform="matrix(.84372 .53678 .53678 -.84372 454.46 687.27)" width="44.553" height="87.035" fill="#ddd"/><rect transform="rotate(157.54 203.09 665.28)" x="203.09" y="665.28" width="44.553" height="87.035" fill="#ddd"/><rect transform="rotate(185 88.041 419.86)" x="88.041" y="419.86" width="45" height="81" fill="#ddd"/><rect transform="rotate(185 451.56 796.98)" x="451.56" y="796.98" width="73" height="130" fill="#aaa"/><rect transform="rotate(185 263.28 780.51)" x="263.28" y="780.51" width="73" height="130" fill="#aaa"/><rect transform="rotate(185 504.86 176.27)" x="504.86" y="176.27" width="73" height="130" fill="#aaa"/><rect transform="rotate(185 316.58 159.8)" x="316.58" y="159.8" width="73" height="130" fill="#aaa"/><rect transform="rotate(185 381.18 786.81)" x="381.18" y="786.81" width="119" height="116" fill="#ddd"/><rect transform="rotate(185 435 160.12)" x="435" y="160.12" width="119" height="116" fill="#ddd"/><circle transform="rotate(185 352.92 409.91)" cx="352.92" cy="409.91" r="262" fill="#ddd" stroke="#000" stroke-width="28"/><circle transform="rotate(185 352.92 409.91)" cx="352.92" cy="409.91" r="216" fill="#F6F5F6" stroke="#000" stroke-width="28"/><line x1="568.96" x2="499.92" y1="558.15" y2="704.69" stroke="#000" stroke-width="28"/><line x1="508.12" x2="454.31" y1="697.34" y2="715.72" stroke="#000" stroke-width="28"/><line transform="matrix(.26261 .9649 .9649 -.26261 127.93 514.7)" x2="161.99" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(.8758 .48267 .48267 -.8758 156.92 653.76)" x2="56.86" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="464.89" x2="441.98" y1="644.35" y2="802.96" stroke="#000" stroke-width="28"/><line transform="matrix(-.036022 .99935 .99935 .036022 215.72 621.97)" x2="160" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="380.3" x2="391.72" y1="796.77" y2="666.27" stroke="#000" stroke-width="28"/><line x1="255.78" x2="267.63" y1="785.88" y2="650.4" stroke="#000" stroke-width="28"/><line x1="457.06" x2="183.11" y1="791.44" y2="767.48" stroke="#000" stroke-width="28"/><line x1="260.9" x2="206.1" y1="692.97" y2="688.18" stroke="#000" stroke-width="28"/><line x1="452.17" x2="397.38" y1="709.7" y2="704.91" stroke="#000" stroke-width="28"/><line x1="383.06" x2="268.5" y1="742.31" y2="732.29" stroke="#000" stroke-width="28"/><line transform="matrix(-.26261 -.9649 -.9649 .26261 577.9 305.13)" x2="161.99" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.8758 -.48267 -.48267 .8758 548.91 166.07)" x2="56.86" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="136.88" x2="205.91" y1="261.69" y2="115.14" stroke="#000" stroke-width="28"/><line x1="197.71" x2="251.52" y1="122.49" y2="104.11" stroke="#000" stroke-width="28"/><line transform="matrix(.031071 -.99952 -.99952 -.031071 489.9 198.05)" x2="160.25" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="240.76" x2="262.85" y1="175.32" y2="16.855" stroke="#000" stroke-width="28"/><line transform="matrix(-.087156 .9962 .9962 .087156 461.01 34.912)" x2="131" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.087156 .9962 .9962 .087156 336.49 24.018)" x2="136" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 520.51 66.217)" x2="275" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 310.23 129.13)" x2="55" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 501.5 145.86)" x2="55" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 439.1 101.75)" x2="115" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><rect transform="rotate(185 85.7 423.68)" x="85.7" y="423.68" width="41" height="79" stroke="#000" stroke-width="28"/><path d="m347.14 533.88-9.061-0.792-14.115 59.496 26.745 2.34-3.569-61.044z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m342.54 559.58-4.388-0.384-7.245 33.496 12.951 1.133-1.318-34.245z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m284.48 513.67-7.395-5.297-42.445 44.016 21.825 15.634 28.015-54.353z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m267.43 533.44-3.581-2.565-23.293 25.138 10.569 7.57 16.305-30.143z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m403.27 524.11 8.193-3.949 34.265 50.645-24.184 11.657-18.274-58.353z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m416.67 546.51 3.968-1.912 18.635 28.761-11.711 5.645-10.892-32.494z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m422.62 297.38 7.383 5.312 42.539-43.925-21.792-15.68-28.13 54.293z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m439.71 277.64 3.575 2.572 23.346-25.088-10.552-7.593-16.369 30.109z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m303.73 287.98-8.194 3.949-34.265-50.645 24.184-11.657 18.275 58.353z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m290.32 265.57-3.967 1.912-18.635-28.761 11.71-5.645 10.892 32.494z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m456.04 482.65 5.302-7.391 54.33 28.059-15.651 21.813-43.981-42.481z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m478.53 495.9 2.567-3.579 30.131 16.329-7.579 10.563-25.119-23.313z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m227.18 389.91-0.793 9.061-61.044 3.569 2.34-26.745 59.497 14.115z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m201.08 389.98-0.384 4.388-34.245 1.318 1.133-12.951 33.496 7.245z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m480.71 412.09-0.793 9.061 59.496 14.115 2.34-26.744-61.043 3.568z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m506.41 416.69-0.384 4.388 33.496 7.245 1.133-12.951-34.245 1.318z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m467.6 346.72 3.862 8.235 58.544-17.652-11.399-24.307-51.007 33.724z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m492.13 337.8 1.87 3.988 32.608-10.545-5.52-11.77-28.958 18.327z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m252.19 328.28-5.233 7.439-54.589-27.55 15.446-21.958 44.376 42.069z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m229.58 315.24-2.534 3.602-30.281-16.047 7.48-10.633 25.335 23.078z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><path d="m239.54 463.71-3.939-8.199-58.377 18.198 11.626 24.199 50.69-34.198z" clip-rule="evenodd" fill="#525353" fill-rule="evenodd"/><path d="m215.09 472.85-1.907-3.97-32.508 10.849 5.629 11.718 28.786-18.597z" clip-rule="evenodd" fill="#F5F5F7" fill-rule="evenodd"/><rect transform="rotate(185 378.09 277.1)" x="378.09" y="277.1" width="26" height="40" fill="#DDDEDE" stroke="#000" stroke-width="5"/>';
        } else if (caseType == IWatchClubCaseRenderer.CaseType.GS) {
            return '<rect transform="rotate(185 433.02 766.48)" x="433.02" y="766.48" width="250" height="719" fill="#D3D2CC"/><rect transform="rotate(194.59 488.89 693.07)" x="488.89" y="693.07" width="38.335" height="94.476" fill="#D3D2CC"/><rect transform="matrix(-.99679 .080016 .080016 .99679 538.1 130.68)" width="38.335" height="94.476" fill="#D3D2CC"/><rect transform="rotate(194.59 207.65 201.69)" x="207.65" y="201.69" width="38.335" height="94.476" fill="#D3D2CC"/><rect transform="matrix(.99679 -.080016 -.080016 -.99679 145.4 660.01)" width="38.335" height="94.476" fill="#D3D2CC"/><rect transform="rotate(185 91.109 406.31)" x="91.109" y="406.31" width="42" height="61" fill="#D3D2CC"/><rect transform="rotate(185 91.109 406.31)" x="91.109" y="406.31" width="47" height="63" stroke="#000" stroke-width="28"/><circle transform="rotate(185 341.41 396.59)" cx="341.41" cy="396.59" r="247.5" fill="#D3D2CC" stroke="#000" stroke-width="28"/><circle transform="rotate(185 341.41 396.59)" cx="341.41" cy="396.59" r="203.5" fill="#F7F8F9" stroke="#000" stroke-width="28"/><line x1="552.78" x2="479.14" y1="525.4" y2="696.48" stroke="#000" stroke-width="28"/><line x1="489.05" x2="437.94" y1="688.48" y2="699.06" stroke="#000" stroke-width="28"/><line x1="448.82" x2="431.1" y1="688.12" y2="775.92" stroke="#000" stroke-width="28"/><line transform="matrix(.024621 .9997 .9997 -.024621 200 664.79)" x2="89.56" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(.22985 .97323 .97323 -.22985 124.51 483.52)" x2="186.26" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(.92914 .36974 .36974 -.92914 150.5 645.4)" x2="52.202" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="444.29" x2="175.23" y1="764.43" y2="741.92" stroke="#000" stroke-width="28"/><line x1="448.79" x2="455.81" y1="689.36" y2="620.72" stroke="#000" stroke-width="28"/><line x1="184.8" x2="191.82" y1="666.26" y2="597.62" stroke="#000" stroke-width="28"/><line x1="444.19" x2="377.44" y1="696.19" y2="690.35" stroke="#000" stroke-width="28"/><line x1="257.9" x2="191.16" y1="679.89" y2="674.05" stroke="#000" stroke-width="28"/><line x1="368.56" x2="379.2" y1="768.88" y2="647.34" stroke="#000" stroke-width="28"/><line x1="249.84" x2="260.48" y1="760.5" y2="638.96" stroke="#000" stroke-width="28"/><line x1="365.51" x2="259.92" y1="723.44" y2="714.2" stroke="#000" stroke-width="28"/><line transform="matrix(-.22985 -.97323 -.97323 .22985 558.31 309.66)" x2="186.26" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.92914 -.36974 -.36974 .92914 532.32 147.78)" x2="52.202" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.024621 -.9997 -.9997 .024621 483.82 128.48)" x2="89.56" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="234.99" x2="252.71" y1="105.14" y2="17.354" stroke="#000" stroke-width="28"/><line x1="130.04" x2="203.68" y1="267.79" y2="96.702" stroke="#000" stroke-width="28"/><line transform="matrix(-.99586 -.090935 -.090935 .99586 505.33 66.146)" x2="270" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.072498 .99737 .99737 .072498 511.96 127.93)" x2="69" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.072498 .99737 .99737 .072498 247.97 104.84)" x2="69" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line x1="193.52" x2="238.67" y1="104.83" y2="96.057" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 493.43 133.34)" x2="67" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 307.14 117.04)" x2="67" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.087156 .9962 .9962 .087156 446.75 35.899)" x2="122" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.087156 .9962 .9962 .087156 328.37 23.536)" x2="122" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><line transform="matrix(-.9962 -.087156 -.087156 .9962 420.68 92.845)" x2="106" y1="-14" y2="-14" stroke="#000" stroke-width="28"/><mask id="c" fill="white"><path d="m522.3 422.96 1.743-19.924-54.149-0.653-0.998 11.408 53.404 9.169z" clip-rule="evenodd" fill-rule="evenodd"/></mask><path d="m522.3 422.96 1.743-19.924-54.149-0.653-0.998 11.408 53.404 9.169z" clip-rule="evenodd" fill="#9A9998" fill-rule="evenodd"/><path d="m524.04 403.03 0.037-3 3.234 0.039-0.282 3.223-2.989-0.262zm-1.743 19.924 2.989 0.262-0.284 3.247-3.212-0.552 0.507-2.957zm-52.406-20.577-2.988-0.262 0.242-2.771 2.783 0.033-0.037 3zm-0.998 11.408-0.507 2.957-2.722-0.467 0.241-2.751 2.988 0.261zm58.136-10.493-1.743 19.924-5.977-0.523 1.743-19.924 5.977 0.523zm-57.101-3.915 54.149 0.653-0.073 6-54.149-0.653 0.073-6zm-4.023 14.147 0.998-11.409 5.977 0.523-0.998 11.409-5.977-0.523zm55.885 12.387-53.404-9.169 1.015-5.913 53.404 9.169-1.015 5.913z" fill="#B1B0AF" mask="url(#c)"/><mask id="b" fill="white"><path d="m315.04 577.48 19.924 1.744 0.653-54.15-11.408-0.998-9.169 53.404z" clip-rule="evenodd" fill-rule="evenodd"/></mask><path d="m315.04 577.48 19.924 1.744 0.653-54.15-11.408-0.998-9.169 53.404z" clip-rule="evenodd" fill="#9A9998" fill-rule="evenodd"/><path d="m334.97 579.22 3 0.036-0.039 3.234-3.223-0.282 0.262-2.988zm-19.924-1.744-0.262 2.989-3.247-0.284 0.552-3.212 2.957 0.507zm20.577-52.406 0.262-2.988 2.771 0.242-0.033 2.783-3-0.037zm-11.408-0.998-2.957-0.507 0.467-2.722 2.751 0.241-0.261 2.988zm10.493 58.136-19.924-1.743 0.523-5.977 19.924 1.743-0.523 5.977zm3.915-57.101-0.653 54.149-6-0.073 0.653-54.149 6 0.073zm-14.147-4.023 11.409 0.998-0.523 5.977-11.409-0.998 0.523-5.977zm-12.387 55.885 9.169-53.404 5.913 1.015-9.169 53.404-5.913-1.015z" fill="#B1B0AF" mask="url(#b)"/><mask id="a" fill="white"><path d="m346.77 214.87 19.924 1.743-8.759 53.44-11.409-0.998 0.244-54.185z" clip-rule="evenodd" fill-rule="evenodd"/></mask><path d="m346.77 214.87 19.924 1.743-8.759 53.44-11.409-0.998 0.244-54.185z" clip-rule="evenodd" fill="#9A9998" fill-rule="evenodd"/><path d="m366.69 216.61 2.961 0.486 0.523-3.192-3.222-0.282-0.262 2.988zm-19.924-1.743 0.262-2.988-3.247-0.284-0.015 3.259 3 0.013zm11.165 55.183-0.262 2.989 2.772 0.242 0.45-2.745-2.96-0.486zm-11.409-0.998-3-0.013-0.012 2.761 2.751 0.241 0.261-2.989zm20.43-55.43-19.924-1.743-0.523 5.977 19.924 1.743 0.523-5.977zm-6.061 56.914 8.76-53.44-5.921-0.971-8.76 53.44 5.921 0.971zm-14.63 1.505 11.408 0.998 0.523-5.977-11.408-0.998-0.523 5.977zm-2.495-57.187-0.244 54.185 6 0.027 0.244-54.185-6-0.027z" fill="#B1B0AF" mask="url(#a)"/><rect transform="rotate(154.55 422 559.13)" x="422" y="559.13" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="rotate(127.04 491.58 497.95)" x="491.58" y="497.95" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="matrix(.45464 .89068 .89068 -.45464 174.29 468.82)" x="2.018" y=".65406" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="rotate(-52.958 191.21 294.07)" x="191.21" y="294.07" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="matrix(-.45464 -.89068 -.89068 .45464 505.5 320.2)" x="-2.018" y="-.65406" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="matrix(-.81461 -.58001 -.58001 .81461 447.52 248.72)" x="-2.0919" y=".35189" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="matrix(.81461 .58001 .58001 -.81461 233.34 540.89)" x="2.0919" y="-.35189" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="rotate(-25.452 261.83 233.84)" x="261.83" y="233.84" width="7.7239" height="51.79" fill="#9A9998" stroke="#B1B0AF" stroke-width="3"/><rect transform="rotate(185 218.67 405.43)" x="218.67" y="405.43" width="50" height="39" fill="#D3D3D2" stroke="#9A9998" stroke-width="4"/><rect transform="rotate(185 214.13 400.01)" x="214.13" y="400.01" width="40" height="29" fill="#F6FAFA"/><rect transform="rotate(185 371.03 293.28)" x="371.03" y="293.28" width="40" height="6" fill="#F7F8F9"/><path d="m424.33 326.55-42.127 5.349-5.621 64.254" stroke="#E4E6E7"/><path d="m424.21 325.99c0.964 5.211 1.247 10.637 0.763 16.173-2.416 27.611-23.171 49.212-49.213 53.85 0.931 0.125 1.87 0.23 2.816 0.313 33.286 2.912 62.67-22.157 65.63-55.993 0.496-5.675 0.218-11.236-0.746-16.576l-19.25 2.233z" clip-rule="evenodd" fill="#E9EAEA" fill-rule="evenodd"/>';
        } else {
            revert IWatchClubCaseRenderer.WrongCaseRendererCalled();
        }
    }

}