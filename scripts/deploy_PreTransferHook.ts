import { ethers } from "hardhat";

async function main() {
  // Get the Contract Factory for PreTransferHook
  const PreTransferHookFactory = await ethers.getContractFactory("PreTransferHook");

  // Define the parameters for the contract constructor
  const registryAddress = "0x000000006551c19487814612e58FE06813775758"; // Example 6551Registry address on Optimism
  const molochShareAddress = "votingTokenAddress"; // Replace with actual Moloch Share contract address for your project.
  const implementationAddress = "0x55266d75D1a14E4572138116aF39863Ed6596E7F"; // Example implementation address
  const salt = "0x0000000000000000000000000000000000000000000000000000000000000000"; // Example salt
  const chainId = "10"; // Example chain ID; ensure this matches your intended deployment chain.
  const nftContract = "manifoldNftContractAddress"; // Replace with actual Manifold NFT Contract address for your project.

  // Deploy the contract
  const preTransferHookInstance = await PreTransferHookFactory.deploy(
    molochShareAddress,
    registryAddress,
    implementationAddress,
    salt,
    chainId,
    nftContract
  );

  // Wait for the contract to be deployed
  await preTransferHookInstance.deployed();

  // Log the address of the deployed contract
  console.log("PreTransferHook deployed to:", preTransferHookInstance.address);
}

// Execute the main function and handle possible errors
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
