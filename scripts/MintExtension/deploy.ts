// Import necessary Hardhat modules
import { ethers } from "hardhat";

async function main(): Promise<void> {
  // Get the Contract Factory for MintExtension
  const MintExtensionFactory = await ethers.getContractFactory("MintExtension");

  // Define the parameters for the contract constructor
  const creator = "0xWHATEVER"; // Placeholder for Manifold Creator Contract address
  const alchemistressesMolochTreasury = "0xTREASURY"; // Placeholder for DAO Treasury address
  const alchemixOpMultisig = "0xWHOMEVER"; // Placeholder for Cut Treasury address

  // Deploy the contract with all constructor arguments
  const mintExtension = await MintExtensionFactory.deploy(
    creator, 
    alchemistressesMolochTreasury, 
    alchemixOpMultisig
  );

  // Wait for the contract to be deployed
  await mintExtension.deployed();

  // Log the address of the deployed contract
  console.log("MintExtension deployed to:", mintExtension.address);
}

// Execute the main function and handle possible errors
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
