import { ethers } from "hardhat";

async function main() {
  // Get the Contract Factory for PreTransferHook
  const PreTransferHookFactory = await ethers.getContractFactory("PreTransferHook");

  // Define the parameters for the contract constructor
  const registryAddress = "0x000000006551c19487814612e58FE06813775758"; // 6551 Registry Address for Optimism | Base
  const molochShareAddress = "votingTokenAddress"; // Moloch Share Contracts are created when RDF is launched, and distributed to 6551 Accts.
  const implementationAddress = "0x55266d75D1a14E4572138116aF39863Ed6596E7F"; // 6551 Implementation Address for Optimism | Base
  const salt = "0x0000000000000000000000000000000000000000000000000000000000000000"; // Salt
  const chainId = "10"; // Optimism ChainId
  // const chainId = "8453"; // Base ChainId 
  const nftContract = "0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9"; // Replace with actual Manifold NFT Contract address for your project.

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
