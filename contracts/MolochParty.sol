// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "contracts/TierI.sol";
import "contracts/TierII.sol";

// Campaign starts as soon as this is deployed, and lasts for 24 Hours.

contract MolochParty is ReentrancyGuard, Ownable {
    uint256 public goalAmount; 
    uint256 public raisedAmount;
    uint256 public stretchAmount;
    uint256 public startTime;
    uint256 public endTime;
    bool public goalReached;
    
    uint256 public costToMint;
    uint256 public costToCommission;
    uint256 public priceComm;
    
    uint256 public mintSupply;
    uint256 public totalMinted;
    uint256 public mintRemaining;

    address payable public molochVault; // Moloch Treasury Address | RQ
    address payable public artistVault; // ManagerVault | Non-RQ

    uint256 public artistSharePercentage;

    TierI public tierIContract;
    TierII public tierIIContract;

// EVENTS
    event GoalReached(uint256 raisedAmount);
    event CampaignFinalized(uint256 totalMinted, uint256 timeFinalized);
    event TokenMinted(uint256 totalMinted);

// CONSTRUCTOR
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
        mintRemaining = _mintSupply;
        goalAmount = _mintSupply * _costToMint;
        stretchAmount = _mintSupply * (_costToCommission + _costToMint);
        priceComm = _costToCommission + _costToMint;
        startTime = block.timestamp;
        endTime = startTime + (_durationInDays * 1 days);
        molochVault = _molochVault;
        artistVault = _artistVault;
        costToMint = _costToMint;
        costToCommission = _costToCommission;
        artistSharePercentage = _artistSharePercentage;
        tierIContract = TierI(_tierIAddress);
        tierIIContract = TierII(_tierIIAddress);
    }

// CAMPAIGN CONTRIBUTIONS
    // MINT
    function contributeTierI() public payable nonReentrant {
        require(block.timestamp <= endTime, "Campaign has ended.");
        require(totalMinted < mintSupply, "Mint supply limit reached.");
        require(msg.value >= costToMint, "Contribution does not meet the minimum cost to mint.");
        _handleContribution(costToMint, msg.sender, 1);
    }
    
    // CUSTOM COMMISSION MINT
    function contributeTierII() public payable nonReentrant {
        require(block.timestamp <= endTime, "Campaign has ended.");
        require(totalMinted < mintSupply, "Mint supply limit reached.");
        uint256 totalCost = costToMint + costToCommission;
        require(msg.value >= totalCost, "Contribution does not meet the total cost for commission tier.");
        _handleContribution(totalCost, msg.sender, 2);
    }

    function _handleContribution(uint256 amount, address contributor, uint tier) private {
    uint256 artistShare = 0;
    uint256 molochShare = 0;

    if (tier == 1) {
        // Calculate artist share and molochVault share for Tier I
        artistShare = (amount * artistSharePercentage) / 100;
        molochShare = amount - artistShare;
    } else if (tier == 2) {
        // For Tier II, first separate out the commission and calculate shares
        uint256 costToMintPortion = costToMint; // This is the part used for minting, not including commission
        uint256 commission = costToCommission; // Commission goes entirely to the artist

        // Calculate artist share from the minting portion only
        uint256 artistShareFromMint = (costToMintPortion * artistSharePercentage) / 100;

        // Total artist share is commission + share from minting portion
        artistShare = commission + artistShareFromMint;

        // Moloch share is the remainder of the mint portion after artist's share
        molochShare = costToMintPortion - artistShareFromMint;
    }

    // Process the shares
    raisedAmount += amount;
    molochVault.transfer(molochShare);
    artistVault.transfer(artistShare);

    if (!goalReached && raisedAmount >= goalAmount) {
        goalReached = true;
        emit GoalReached(raisedAmount);
    }

    // Minting logic remains unchanged
    if (totalMinted < mintSupply) {
        if (tier == 1) {
            tierIContract.mint(contributor); // Directly mint for Tier I
        } else if (tier == 2) {
            tierIIContract.mintComm(contributor); // Directly mint for Tier II commission
        }
        totalMinted++;
        mintRemaining--;
        emit TokenMinted(totalMinted); // Emit event each time totalMinted increases
    }
}

// CLOSE CAMPAIGN
    function finalizeCampaign() public onlyOwner {
        require(block.timestamp > endTime, "Campaign has not yet ended.");
        if (totalMinted < mintSupply) {
            uint256 remainder = mintSupply - totalMinted;
            tierIContract.mintBatch(molochVault, remainder);
            totalMinted += remainder;
        }
        emit CampaignFinalized(totalMinted, block.timestamp); // Emit event when the campaign finalizes
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "No funds to withdraw.");
        molochVault.transfer(address(this).balance);
    }
}