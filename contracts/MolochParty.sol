// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./TierI.sol";
import "./TierII.sol";

contract MolochParty is ReentrancyGuard, Ownable {
    uint256 public goalAmount;
    uint256 public raisedAmount;
    uint256 public endTime;
    bool public goalReached;

    uint256 public costToMint;
    uint256 public costToCommission;
    uint256 public mintSupply = 69; // Total NFTs allowed to be minted, value set in constructor

    uint256 public totalMinted; // Track the total number of NFTs minted

    address payable public molochVault;
    address payable public artistVault;

    // Percentage of each contribution that goes to the artist
    uint256 public artistSharePercentage;

    TierI public tierIContract;
    TierII public tierIIContract;

    event ContributionReceived(address contributor, uint256 amount, uint tier);
    event GoalReached(uint256 raisedAmount);

    constructor(
        uint256 _mintSupply,
        uint256 _durationInDays, 
        address payable _molochVault,
        address payable _artistVault,
        uint256 _costToMint,
        uint256 _costToCommission,
        address _tierIAddress,
        address _tierIIAddress,
        uint256 _artistSharePercentage
    ) Ownable(msg.sender) {
        require(_molochVault != address(0), "Moloch vault address cannot be the zero address.");
        require(_artistVault != address(0), "Artist vault address cannot be the zero address.");
        require(_tierIAddress != address(0), "Tier I contract address cannot be the zero address.");
        require(_tierIIAddress != address(0), "Tier II contract address cannot be the zero address.");
        require(_artistSharePercentage <= 100, "Artist share percentage must be between 0 and 100.");

        mintSupply = _mintSupply;
        goalAmount = mintSupply * _costToMint;
        endTime = block.timestamp + (_durationInDays * 1 days);
        molochVault = _molochVault;
        artistVault = _artistVault;
        costToMint = _costToMint;
        costToCommission = _costToCommission;
        artistSharePercentage = _artistSharePercentage;
        tierIContract = TierI(_tierIAddress);
        tierIIContract = TierII(_tierIIAddress);
    }

    function contributeTierI() public payable nonReentrant {
        require(block.timestamp <= endTime, "Campaign has ended.");
        require(totalMinted < mintSupply, "Mint supply limit reached.");
        require(msg.value >= costToMint, "Contribution does not meet the minimum cost to mint.");
        _handleContribution(costToMint, msg.sender, 1);
    }

    function contributeTierII() public payable nonReentrant {
        require(block.timestamp <= endTime, "Campaign has ended.");
        require(totalMinted < mintSupply, "Mint supply limit reached.");
        uint256 totalCost = costToMint + costToCommission;
        require(msg.value >= totalCost, "Contribution does not meet the total cost for commission tier.");
        _handleContribution(totalCost, msg.sender, 2);
    }

    function _handleContribution(uint256 amount, address contributor, uint tier) private {
        uint256 artistShare = (amount * artistSharePercentage) / 100;
        uint256 molochShare = amount - artistShare;

        raisedAmount += amount;
        molochVault.transfer(molochShare);
        artistVault.transfer(artistShare);

        if (!goalReached && raisedAmount >= goalAmount) {
            goalReached = true;
            emit GoalReached(raisedAmount);
        }

        // Minting logic based on the tier
        if (totalMinted < mintSupply) {
            if (tier == 1) {
                tierIContract.mint(contributor); // Directly mint for Tier I
            } else if (tier == 2) {
                tierIIContract.mintComm(contributor); // Directly mint for Tier II commission
            }
            totalMinted++;
            emit ContributionReceived(contributor, amount, tier);
        }
    }

    function finalizeCampaign() public onlyOwner {
        require(block.timestamp > endTime, "Campaign has not yet ended.");
        if (totalMinted < mintSupply) {
            uint256 remainder = mintSupply - totalMinted;
            // Assuming mintBatch function in TierI accepts the number of NFTs to mint
            tierIContract.mintBatch(molochVault, remainder);
            totalMinted += remainder;
        }
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "No funds to withdraw.");
        molochVault.transfer(address(this).balance);
    }
}
