// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PartyRegistry {
    // Define a structure to hold campaign details
    struct Campaign {
        address molochParty;
        address tierI;
        address tierII;
        bool exists;
    }

    // Mapping from campaign ID (e.g., a unique identifier or index) to Campaign details
    mapping(uint256 => Campaign) public campaigns;
    
    // A counter to keep track of the campaign IDs
    uint256 public campaignCount = 0;

    // Event to emit when a new campaign is registered
    event CampaignRegistered(uint256 indexed campaignId, address indexed molochParty, address indexed tierI, address tierII);

    /**
     * @dev Registers a new campaign in the registry.
     * @param molochParty The address of the MolochParty contract for this campaign.
     * @param tierI The address of the TierI contract for this campaign.
     * @param tierII The address of the TierII contract for this campaign.
     */
    function registerCampaign(address molochParty, address tierI, address tierII) external {
        // Increment the campaign count to get a new ID
        campaignCount += 1;

        // Create and store the new campaign
        campaigns[campaignCount] = Campaign({
            molochParty: molochParty,
            tierI: tierI,
            tierII: tierII,
            exists: true
        });

        // Emit an event for the new campaign registration
        emit CampaignRegistered(campaignCount, molochParty, tierI, tierII);
    }

    /**
     * @dev Retrieves campaign details by ID.
     * @param campaignId The ID of the campaign to retrieve.
     * @return The addresses of the MolochParty, TierI, and TierII contracts for the specified campaign.
     */
    function getCampaign(uint256 campaignId) external view returns (address, address, address) {
        require(campaigns[campaignId].exists, "Campaign does not exist.");

        Campaign storage campaign = campaigns[campaignId];
        return (campaign.molochParty, campaign.tierI, campaign.tierII);
    }
}
