import { ethers } from "hardhat";

async function main(): Promise<void> {
    const contractAddress = "0xWHATEVER"; // Replace "0xWHATEVER" with your contract's deployed address

    // Get signer account from the Hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the contract instance
    const contract = await ethers.getContractAt("ERC721LazyMint", contractAddress, signer);

    console.log("CapSupply being called by:", signer.address);

    // Calling the capSupply function
    const transaction = await contract.capSupply();
    await transaction.wait();

    console.log("Supply capped successfully.");
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
