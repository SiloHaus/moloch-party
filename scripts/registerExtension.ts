import { ethers } from "hardhat";

async function main() {
    // Addresses obtained from your previous deployment script outputs
    const creatorAddress = "0xCREATOR_ADDRESS"; // Manifold Creator Core Contract address
    const tierIAddress = "0xYOUR_TIERI_ADDRESS"; // Replace with the actual deployed address of TierI
    const tierIIAddress = "0xYOUR_TIERII_ADDRESS"; // Replace with the actual deployed address of TierII
    const baseURIForTierI = "https://example.com/api/item/";
    const baseURIForTierII = "https://example.com/api/commission/";

    // Attach the Creator contract interface using the creatorAddress
    const Creator = await ethers.getContractAt("ICreatorCore", creatorAddress);

    // Register TierI Extension
    console.log("Registering TierI Extension...");
    let transaction = await Creator.registerExtension(tierIAddress, baseURIForTierI);
    await transaction.wait();
    console.log("TierI Extension registered successfully!");

    // Register TierII Extension
    console.log("Registering TierII Extension...");
    transaction = await Creator.registerExtension(tierIIAddress, baseURIForTierII);
    await transaction.wait();
    console.log("TierII Extension registered successfully!");
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
