import { ethers } from "hardhat";

async function main(): Promise<void> {
  // Get the Contract Factory for TierI
  const TierIFactory = await ethers.getContractFactory("TierI");

  // Define the parameter for the TierI contract constructor
  const creator = "0xCREATOR_ADDRESS"; // Placeholder for Manifold Creator Contract address

  // Deploy the TierI contract with the constructor argument
  const tierI = await TierIFactory.deploy(creator);

  // Wait for the contract to be deployed
  await tierI.deployed();

  // Log the address of the deployed TierI contract
  console.log("TierI deployed to:", tierI.address);
}

// Execute the main function and handle possible errors
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
