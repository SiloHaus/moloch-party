// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "contracts/MolochParty.sol";
import "contracts/TierI.sol";
import "contracts/TierII.sol";

contract PartyFactory {
    // Array to keep track of all deployed campaigns
    address[] public campaigns;

    // Future integration: Placeholder for registry address
    // address public registry;

    event CampaignCreated(
        address indexed molochParty,
        address indexed tierI,
        address indexed tierII
    );

    // Function to deploy a new campaign
    function createCampaign(
        uint256 mintSupply,
        uint256 durationInDays,
        address payable molochVault,
        address payable artistVault,
        uint256 costToMint,
        uint256 costToCommission,
        uint256 artistSharePercentage,
        string memory tierIBaseURI,
        string memory tierIIBaseURI,
        address creatorAddress // Manifold creator address for Tier contracts
    ) public {
        TierI tierI = new TierI(creatorAddress);
        tierI.setBaseURI(tierIBaseURI);
        // Set additional configurations for TierI if needed

        TierII tierII = new TierII(creatorAddress);
        tierII.setBaseURI(tierIIBaseURI);
        // Set additional configurations for TierII if needed

        MolochParty molochParty = new MolochParty(
            mintSupply,
            durationInDays,
            molochVault,
            artistVault,
            costToMint,
            costToCommission,
            address(tierI),
            address(tierII),
            artistSharePercentage
        );

        // Linking Tier contracts with MolochParty
        tierI.setMolochPartyAddress(address(molochParty));
        tierII.setMolochPartyAddress(address(molochParty));

        // Recording the deployment
        campaigns.push(address(molochParty));

        emit CampaignCreated(address(molochParty), address(tierI), address(tierII));

        // Future integration: Register the campaign in a registry
        // registerCampaign(address(molochParty), address(tierI), address(tierII));
    }

    // Function to register the campaign in a registry
    // Placeholder for future implementation
    /*
    function registerCampaign(address molochParty, address tierI, address tierII) internal {
        // Logic to register the campaign with the registry goes here
    }
    */
}
