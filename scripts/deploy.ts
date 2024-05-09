import { ethers } from "hardhat";

async function main() {
    // Define parameters for deployment
    const creatorAddress = "0xCREATOR_ADDRESS"; // Placeholder for the Manifold Creator Contract address
    const molochVaultAddress = "0xMOLOCH_VAULT_ADDRESS"; // Placeholder for the Moloch Vault address
    const artistVaultAddress = "0xARTIST_VAULT_ADDRESS"; // Placeholder for the Artist Vault address
    const mintSupply = 69;
    const durationInDays = 1;
    const costToMint = ethers.utils.parseEther("0.1"); // 0.1 ETH
    const costToCommission = ethers.utils.parseEther("0.05"); // 0.05 ETH
    const artistSharePercentage = 20; // 20% to the artist

    // Deploy TierI contract
    const TierI = await ethers.getContractFactory("TierI");
    const tierI = await TierI.deploy(creatorAddress);
    await tierI.deployed();
    console.log("TierI deployed to:", tierI.address);

    // Deploy TierII contract
    const TierII = await ethers.getContractFactory("TierII");
    const tierII = await TierII.deploy(creatorAddress);
    await tierII.deployed();
    console.log("TierII deployed to:", tierII.address);

    // Deploy MolochParty contract
    const MolochParty = await ethers.getContractFactory("MolochParty");
    const molochParty = await MolochParty.deploy(
        mintSupply,
        durationInDays,
        molochVaultAddress,
        artistVaultAddress,
        costToMint,
        costToCommission,
        tierI.address,
        tierII.address,
        artistSharePercentage
    );
    await molochParty.deployed();
    console.log("MolochParty deployed to:", molochParty.address);

    // Set the base URIs for TierI and TierII
    const baseURIForTierI = "https://examplePathFromAkord.arweave.net/uniquePathHere/JSON/";
    await tierI.setBaseURI(baseURIForTierI);
    const baseURIForTierII = "https://examplePathFromAkord.arweave.net/CommsPathHere/JSON/";
    await tierII.setBaseURI(baseURIForTierII);

    // Set the MolochParty address in both TierI and TierII
    await tierI.setMolochPartyAddress(molochParty.address);
    await tierII.setMolochPartyAddress(molochParty.address);

    console.log("Configurations are set!");
}

main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
