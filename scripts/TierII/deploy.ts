import { ethers } from "hardhat";

async function main(): Promise<void> {
  // Get the Contract Factory for TierII
  const TierIIFactory = await ethers.getContractFactory("TierII");

  // Define the parameter for the TierII contract constructor
  const creator = "0xCREATOR_ADDRESS"; // Placeholder for Manifold Creator Contract address

  // Deploy the TierII contract with the constructor argument
  const tierII = await TierIIFactory.deploy(creator);

  // Wait for the contract to be deployed
  await tierII.deployed();

  // Log the address of the deployed TierII contract
  console.log("TierII deployed to:", tierII.address);
}

// Execute the main function and handle possible errors
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
