/*
DEPLOYMENT: 

1) Create Manifold Contract with Deployer Key | [You could still learn how to do this manually later.]
2) Create Moloch Vault Address [Using Test Wallet]
3) Create Artist Vault Address [Using Test Wallet]
4) Create NFT Collection that accomodates mintSupply
5) Upload TierI to Akord and list BaseURI [Uploaded | Listed]
6) Upload TierII to Akord and list Base URI [Uploaded | Listed]
7) Deploy
8) registerExtension.ts

*/

import { ethers } from "hardhat";

async function main() {
    // Define parameters for deployment
    const creatorAddress = "0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9"; // Sepolia Manifold Creator Contract address
    const molochVaultAddress = "0xF1B3A985E3aC73dc81f8fcD419c4dda247d2292c"; // Placeholder for the Moloch Vault address
    const artistVaultAddress = "0x5304ebB378186b081B99dbb8B6D17d9005eA0448"; // Placeholder for the Artist Vault address
    const mintSupply = 9;
    const durationInDays = 1;
    const costToMint = ethers.utils.parseEther("0.01"); // 0.01 ETH
    const costToCommission = ethers.utils.parseEther("0.01"); // 0.01 ETH
    const artistSharePercentage = 10; // 10% to the artist

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

    // Set the base URIs for TierI and TierII | These are for 0 - 8 of the Landscapes | Pixel Art Landscapes
    const baseURIForTierI = "https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/JSON/";
    await tierI.setBaseURI(baseURIForTierI);
    const baseURIForTierII = "https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/PIXELJSON/";
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
