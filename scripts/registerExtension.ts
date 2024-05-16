import { ethers } from "hardhat";

async function main() {
    // Addresses obtained from your previous deployment script outputs
    const creatorAddress = "0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9"; // Manifold Creator Core Contract address OP Mainnet
    const tierIAddress = "0xD84D227b2965a011561FDD6C2782bA74d4551c51"; // Replace with the actual deployed address of TierI
    const tierIIAddress = "0x3e22B269BAE7C670676df9314F15CE65aDAeBb80"; // Replace with the actual deployed address of TierII
    const baseURIForTierI = "https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/JSON/";
    const baseURIForTierII = "https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/PIXELJSON/";

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
