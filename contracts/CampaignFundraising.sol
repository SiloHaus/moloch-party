// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Ownable.sol";

contract CampaignFundraising is ReentrancyGuard, Ownable {
    uint256 public goalAmount;
    uint256 public totalRaisedAmount;
    uint256 public endTime;
    bool public goalReached;

    mapping(address => uint256) public contributions;

    event ContributionReceived(address contributor, uint256 amount);
    event GoalReached(uint256 totalRaisedAmount);
    event FundsWithdrawn(address recipient, uint256 amount);

    constructor(uint256 _goalAmount, uint256 _duration) {
        goalAmount = _goalAmount;
        endTime = block.timestamp + _duration;
    }

    function contribute() public payable nonReentrant {
        require(block.timestamp <= endTime, "Campaign has ended.");
        require(msg.value > 0, "Contribution must be positive.");

        contributions[msg.sender] += msg.value;
        totalRaisedAmount += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if (totalRaisedAmount >= goalAmount && !goalReached) {
            goalReached = true;
            emit GoalReached(totalRaisedAmount);
        }
    }

    function withdrawFunds() external onlyOwner {
        require(block.timestamp > endTime, "Campaign is still active.");
        require(goalReached, "Goal not reached.");

        uint256 amount = address(this).balance;
        (bool success, ) = owner().call{value: amount}("");
        require(success, "Transfer failed.");

        emit FundsWithdrawn(owner(), amount);
    }

    // Additional logic to handle refunds if the goal is not reached, etc., could be added here.
}
