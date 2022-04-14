/*
                  ██▓▓▓▓▓▓▓▓██████                                                              
              ████░░░░░░░░░░░░▒▒▒▒████                                                          
            ██░░░░████████████░░▒▒▒▒▒▒██  ██████████████████████████████                        
          ██░░████░░░░░░░░░░░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██████                  
        ██░░██░░░░            ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████              
      ██░░██░░                  ░░██░░▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████          
    ██░░██░░                    ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██        
    ██░░██░░                    ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██      
  ██░░██░░                      ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██    
  ██░░██░░          ▓▓▓▓        ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██  
██░░██░░        ░░░░░░▓▓        ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██  
██░░██░░░░░░░░░░      ▒▒        ░░██░░▒▒▒▒▒▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██  
██░░██░░                ▒▒    ░░██░░▒▒▒▒▒▒▒▒██░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░██  
██░░██░░                  ▒▒  ░░██░░▒▒▒▒▒▒▒▒██░░▒▒▒▒▒▒▒▒████████████▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░██  
██░░██░░                    ░░██░░▒▒▒▒▒▒▒▒██▒▒▒▒████████            ████████▒▒▒▒▒▒░░░░░░░░░░██  
██▒▒░░██░░                  ░░██░░▒▒▒▒▒▒▒▒██████                            ██████▒▒▒▒░░░░░░██  
██▒▒░░██░░                ░░██░░▒▒▒▒▒▒▒▒▒▒██                              ██▒▒▒▒▒▒████▒▒░░░░░░██
████▒▒░░██░░░░        ░░░░██░░▒▒▒▒▒▒▒▒▒▒▓▓░░                              ██▒▒▒▒▒▒▒▒▒▒██▒▒░░░░██
████▒▒▒▒░░████░░░░░░░░████░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒░░██
██▒▒██▒▒▒▒▒▒░░██▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██░░                            ██▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██░░██
██░░░░██▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██░░██
██░░░░▒▒████▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▒▒▒▒██                    ██████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██
██░░▒▒██▒▒▒▒████▒▒▒▒▒▒▒▒██▒▒▒▒████            ██████████▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██
██░░▒▒██▒▒▒▒▒▒▒▒██████████░░░░██▒▒████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  
██░░██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██  
██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██    
  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██      
  ██░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██        
    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒░░██          
    ██░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒░░░░██            
      ██░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒░░░░████              
        ████░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒░░████                  
            ████░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒██████                      
                ████░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒██                          
                    ██████░░░░░░░░░░░░░░░░░░▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████                            
                          ██████████████████████▒▒▒▒▒▒▒▒████████                                
                                                ████████                                        

^I found this on Google.

0xPATERSON
April 5, 2022.                                             
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {ERC721A} from "ERC721A/contracts/ERC721A.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import {IWatchScratchers} from "./IWatchScratchers.sol";
import "./WatchScratchersLibrary.sol";

contract WatchScratchers is ERC721A, Ownable, ReentrancyGuard {
    mapping(uint256 => IWatchScratchers.WatchScratcher) watchScratchers;
    address public renderingContractAddress;
    uint256 private constant MAX_SUPPLY = 5000;
    uint256 private constant MINT_PRICE = 0.04 ether;
    uint256 private constant MAX_PER_ADDRESS = 10;


    event TickTickTickTick();

    error MintTooMany();
    error MintNotAuthorized();
    error MintMaxSupplyReached();
    error PaymentAmountInvalid();

    modifier onlyIfPaymentAmountValid(uint256 value) {
        if (msg.value != value) revert PaymentAmountInvalid();
        _;
    }

    modifier onlyIfStillHasSupply() {
        if (_currentIndex > MAX_SUPPLY) revert MintMaxSupplyReached();
        _;
    }
    
    constructor() ERC721A("Watch Scratchers", "WATCH") {
        /*
            Every Rolex is photographed at 31 seconds past 10:10.
            If it has a date, it is set to the 28th,
            and if it has a day, it is always Monday.
        */
        emit TickTickTickTick();
    }
    
    function mint(uint256 amount) 
        external 
        payable 
        nonReentrant 
        onlyIfStillHasSupply 
        onlyIfPaymentAmountValid(MINT_PRICE * amount) 
    {
        // check for amount exceeding max supply
        if (amount > MAX_PER_ADDRESS) revert MintTooMany();
        if (tx.origin != msg.sender) revert MintNotAuthorized();

        uint256 tokenId = _currentIndex;
        IWatchScratchers.WatchScratcher memory watchScratcher;
        watchScratcher.configuration = uint256(keccak256(abi.encodePacked(
                tokenId,
                msg.sender,
                block.difficulty,
                block.timestamp
            )));
        _safeMint(msg.sender, amount);
        watchScratchers[tokenId] = watchScratcher;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    }


}
