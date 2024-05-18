import { ethers } from "hardhat";

async function main() {
  // Define parameters for deployment
  const molochVaultAddress = "0xF1B3A985E3aC73dc81f8fcD419c4dda247d2292c"; // Placeholder for the Moloch Vault address
  const artistVaultAddress = "0x5304ebB378186b081B99dbb8B6D17d9005eA0448"; // Placeholder for the Artist Vault address
  const mintSupply = 9;
  const durationInDays = 1;
  const costToMint = ethers.utils.parseEther("0.01"); // 0.01 ETH
  const costToCommission = ethers.utils.parseEther("0.01"); // 0.01 ETH
  const artistSharePercentage = 10; // 10% to the artist

  // Existing TierI and TierII contract addresses
  const tierIAddress = "0x501f614674896972194Fd7ee2A2089B2b8B575F2"; // TierI OP
  const tierIIAddress = "0x447B8A9F8438Fd85058c5d38a4c3Ac74A1ce1C82"; // TierII OP

  // Deploy MolochParty contract
  const MolochParty = await ethers.getContractFactory("MolochParty");
  const molochParty = await MolochParty.deploy(
    mintSupply,
    durationInDays,
    molochVaultAddress,
    artistVaultAddress,
    costToMint,
    costToCommission,
    tierIAddress,
    tierIIAddress,
    artistSharePercentage
  );
  await molochParty.deployed();
  console.log("MolochParty deployed to:", molochParty.address);

  // Set the MolochParty address in both TierI and TierII
  const tierI = await ethers.getContractAt("TierI", tierIAddress);
  const tierII = await ethers.getContractAt("TierII", tierIIAddress);
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