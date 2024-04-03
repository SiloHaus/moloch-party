// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract OGDistro is ReentrancyGuard {
    address public owner;
    address public treasury; // Treasury address from which NFTs are distributed
    IERC721 public nftContract;
    uint256 public price = 0.42 ether;
    uint256[] public tokenIds = [2, 3, 6, 7, 8, 9, 10, 17, 22, 24, 26, 27, 31, 34];
    
    // Variable to keep track of the available NFTs
    uint256 public availableNFTs;

    // Event to be emitted when the number of available NFTs changes
    event AvailableNFTsChanged(uint256 availableNFTs);

    constructor(address _nftContract, address _treasury) {
        owner = msg.sender;
        nftContract = IERC721(_nftContract);
        treasury = _treasury; // Initialize the treasury address
        availableNFTs = tokenIds.length; // Initialize with the total number of available NFTs
    }

    function ogDistro() public payable nonReentrant {
        require(msg.value >= price, "Insufficient ETH sent");
        require(tokenIds.length > 0, "No NFTs left to buy");

        // Select the lowest available token ID
        uint256 tokenId = tokenIds[0];

        // Transfer the NFT from the treasury to the buyer
        nftContract.transferFrom(treasury, msg.sender, tokenId);

        // Remove the token ID from the start of the array and update availableNFTs
        for(uint i = 0; i < tokenIds.length - 1; i++) {
            tokenIds[i] = tokenIds[i + 1];
        }
        tokenIds.pop(); // Remove the last element now that it's been shifted
        availableNFTs = tokenIds.length; // Update the availableNFTs count

        // Emit the event to notify about the change
        emit AvailableNFTsChanged(availableNFTs);
    }

    // Additional functions can be added as needed
}
