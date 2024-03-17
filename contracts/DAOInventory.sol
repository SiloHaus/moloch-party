// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract NFTVaultSequential is ReentrancyGuard {
    address public owner;
    address public split; // Address to which funds will be sent on withdrawal
    IERC721 public nftContract;
    uint256 public price = 0.42 ether;

    // https://optimistic.etherscan.io/address/0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6#tokentxnsErc721    
    // Array of available token IDs, sorted low to high
    uint256[] public tokenIds = [2, 3, 6, 7, 8, 9, 10, 17, 22, 24, 26, 27, 31, 34];

    constructor(address _nftContract, address _split) {
        require(_split != address(0), "Split address cannot be zero.");
        owner = msg.sender;
        split = _split; // Set the split address
        nftContract = IERC721(_nftContract);
    }

    function buyNFT() public payable nonReentrant {
        require(msg.value >= price, "Insufficient ETH sent");
        require(tokenIds.length > 0, "No NFTs left to buy");

        // Select the lowest available token ID
        uint256 tokenId = tokenIds[0];

        // Transfer the NFT to the buyer
        nftContract.transferFrom(address(this), msg.sender, tokenId);

        // Remove the token ID from the start of the array
        for(uint i = 0; i < tokenIds.length - 1; i++) {
            tokenIds[i] = tokenIds[i + 1];
        }
        tokenIds.pop(); // Remove the last element now that it's been shifted

        // Transfer ETH to the split address
        payable(split).transfer(msg.value);
    }

    // Function to withdraw contract balance to split address - modified as per requirements
    function withdraw() public {
        require(address(this).balance > 0, "No funds to withdraw");
        payable(split).transfer(address(this).balance);
    }

    // Additional functions like depositing NFTs, setting prices, etc., can be added here.
}
