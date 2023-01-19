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

Every Rolex is photographed at 31 seconds past 10:10.
If it has a date, it is set to the 28th,
and if it has a day, it is always Monday.

0xPATERSON
April 5, 2022.                                             
*/

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";


contract EthereumWatchCo is ERC721, Ownable, ReentrancyGuard {
    using ECDSA for bytes32;
    /*==============================================================
    ==                        Custom Errors                       ==
    ==============================================================*/
    
    error CallerIsContract();
    error InvalidSignature();
    error MintNotActive();
    error MintTooMany();
    error MintNotAuthorized();
    error MintMaxSupplyReached();
    error PaymentAmountInvalid();

    event TickTickTickTick();

    uint256 private constant MAX_SUPPLY = 5711;
    uint256 private constant MINT_PRICE = 0.04 ether;
    uint256 private constant MINT_PRICE_CHOOSE_WATCH = 0.08 ether;
    uint256 private constant WATCH_CLUB_MINT_PRICE = 0.00 ether;
    uint256 private constant MAX_PER_ADDRESS = 5;

    uint256 public constant BIT_MASK_LENGTH = 14;
    uint256 public constant BIT_MASK = 2**BIT_MASK_LENGTH - 1;
    // watch trait lies on the 9th slot
    uint256 private constant WATCH_TRAIT_MULTIPLE = 9;

    // for pseudo-rng
    uint256 private _seed;
    uint256 private _totalSupply;

    address private _allowlist_signer;
    address private _watch_club_signer;
    bool public mintIsActive;
    bool public allowListMintIsActive;
    bool public watchClubMintIsActive;

    address public watchCoRenderer;

    // tokenId to dna
    mapping(uint256 => uint256) public dna;

    mapping(address => uint256) private allowListMintCountPerAddress;
    mapping(address => uint256) private watchClubMintCountPerAddress;

    constructor() ERC721("Watch Scratchers", "WATCH") {
        emit TickTickTickTick();
    }


    /**
     * @notice public mint
     * @param quantity max 5
     */
    function publicMint(uint256 quantity) external payable {
        uint256 currentSupply = _totalSupply;
        if (tx.origin != msg.sender) revert CallerIsContract();
        if (!mintIsActive) revert MintNotActive();
        if (currentSupply + quantity > MAX_SUPPLY) revert MintMaxSupplyReached();
        if (quantity > MAX_PER_ADDRESS) revert MintTooMany();
        if (quantity * MINT_PRICE != msg.value) revert PaymentAmountInvalid();

        unchecked {
            uint256 i;
            for (; i < quantity; ) {
                mint(currentSupply++, 0);
                ++i;
            }
        }
        _totalSupply = currentSupply;
    }

    /**
     * @notice mint where you can choose which watch you want
     * @param watch self-explanatory, the watch
     */
    function chooseWatchMint(uint256 watch) external payable {
        uint256 currentSupply = _totalSupply;
        if (tx.origin != msg.sender) revert CallerIsContract();
        if (!mintIsActive) revert MintNotActive();
        if (currentSupply + 1 > MAX_SUPPLY) revert MintMaxSupplyReached();
        if (MINT_PRICE_CHOOSE_WATCH != msg.value) revert PaymentAmountInvalid();

        unchecked {
            mint(currentSupply++, watch);
        }
        _totalSupply = currentSupply;
    }

    /**
     * @notice allowlist mint
     * @param signature signature used for verification
     * @param quantity max 10
     */
    function allowListMint(bytes calldata signature, uint256 quantity) external payable {
        uint256 currentSupply = _totalSupply;
        if (tx.origin != msg.sender) revert CallerIsContract();
        if (!allowListMintIsActive) revert MintNotActive();
        if (currentSupply + quantity > MAX_SUPPLY) revert MintMaxSupplyReached();
        if (msg.value != MINT_PRICE) revert PaymentAmountInvalid();
        if (quantity > 10 || allowListMintCountPerAddress[msg.sender] > MAX_PER_ADDRESS) revert MintTooMany();
        if (
            !verify(
                getMessageHash(msg.sender, 1, 0),
                signature,
                _allowlist_signer
            )
        ) revert InvalidSignature();

        unchecked {
            allowListMintCountPerAddress[msg.sender] += quantity;
            uint256 i;
            for (; i < quantity; ) {
                mint(currentSupply++, 0);
                ++i;
            }
        }

        _totalSupply = currentSupply;
    }

    /**
     * @notice azuki watch club mints for free. 1 per address.
     * @param signature signature used for verification
     */
    function watchClubMint(bytes calldata signature) external payable {
        uint256 currentSupply = _totalSupply;
        if (tx.origin != msg.sender) revert CallerIsContract();
        if (!allowListMintIsActive) revert MintNotActive();
        if (currentSupply + 1 > MAX_SUPPLY) revert MintMaxSupplyReached();
        if (msg.value != WATCH_CLUB_MINT_PRICE) revert PaymentAmountInvalid();
        if (watchClubMintCountPerAddress[msg.sender] > 0) revert MintTooMany();

        if (
            !verify(
                getMessageHash(msg.sender, 1, 0),
                signature,
                _allowlist_signer
            )
        ) revert InvalidSignature();

        watchClubMintCountPerAddress[msg.sender] = 1;

        unchecked {
            mint(currentSupply++, 0);
        }

        _totalSupply = currentSupply;
    }


    function mint(uint256 tokenId, uint256 watch) internal {
        unchecked {
            dna[tokenId] = setDna(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            tokenId,
                            block.coinbase,
                            block.timestamp,
                            _seed++
                        )
                    )
                ),
                watch
            );
        }
        _mint(msg.sender, tokenId);
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    }

    function setDna(uint256 scrollDna, uint256 watch)
        internal
        pure
        returns (uint256)
    {
        if (watch == 0) {
          return scrollDna;
        }
        uint256 newBitMask = ~(BIT_MASK <<
            (BIT_MASK_LENGTH * WATCH_TRAIT_MULTIPLE));
        return
            (scrollDna & newBitMask) |
            (watch << (BIT_MASK_LENGTH * WATCH_TRAIT_MULTIPLE));
    }

    /*==============================================================
    ==                    Only Owner Functions                    ==
    ==============================================================*/

    function setWatchCoRenderer(address _watchCoRenderer) external onlyOwner {
        watchCoRenderer = _watchCoRenderer;
    }

    function setAllowlistSigner(address signer) external onlyOwner {
        _allowlist_signer = signer;
    }

    function flipMint() external onlyOwner {
        mintIsActive = !mintIsActive;
    }

    function flipAllowListMint() external onlyOwner {
        allowListMintIsActive = !allowListMintIsActive;
    }

    function flipWatchClubMint() external onlyOwner {
        watchClubMintIsActive = !watchClubMintIsActive;
    }

    function setSeed(uint256 seed) external onlyOwner {
        _seed = seed;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    /*==============================================================
    ==                     Sig Verification                       ==
    ==============================================================*/

    function verify(
        bytes32 messageHash,
        bytes memory signature,
        address _signer
    ) internal pure returns (bool) {
        return
            messageHash.toEthSignedMessageHash().recover(signature) == _signer;
    }

    function getMessageHash(
        address account,
        uint256 quantity,
        uint256 cc0TraitIndex
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(account, quantity, cc0TraitIndex));
    }
}
