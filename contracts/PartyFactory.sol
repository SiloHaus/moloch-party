// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "contracts/MolochParty.sol";
import "contracts/TierI.sol";
import "contracts/TierII.sol";

/*
SETUP TIERI:
1. Register TierI extension with Manifold. // Create registerManifoldExtension()
2. setBaseURI() pointing to an Akord.
3. setMolochPartyAddress().
*/

/*
SETUP TIERII:
1. Register TierII extension with Manifold. // Create registerManifoldExtension()
2. setBaseURI() pointing to an Akord.
3. setMolochPartyAddress().
*/

/*

Might want to designate two different launch functions here: 

1. createCampaign()

Everything will be needed to launch a campaign from scratch.

2. extendCampaign()

Many components will not be needed, because they will be reused.

PreTransferHook
MolochShareAddress
Manifold Core Contract
artistVault
molochVault

If For Example, I am the only person who ever uses this platform, then I will only need to use createCampaign() once, and then can use extendCampaign() for all of the remaining campaigns. 

This will allow me to build out campaigns, where the membership number increases each time, and the molochTreasury incrases each time, and there is the same SudoSwap Pool, and the same Loot token. 

*/


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
