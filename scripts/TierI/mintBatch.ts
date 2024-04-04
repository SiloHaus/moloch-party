import { ethers } from "hardhat";

async function main(): Promise<void> {
    const contractAddress = "0xWHATEVER"; // Replace "0xWHATEVER" with your contract's deployed address
    
    // Get signer account from the Hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the contract instance
    const ERC721LazyMint = await ethers.getContractFactory("ERC721LazyMint");
    const contract = ERC721LazyMint.attach(contractAddress).connect(signer);

    // Call the mintBatchLimited function
    // Note: Adjust the function call if your batch mint function requires arguments or value
    const tx = await contract.mintBatchLimited({
        // If your function requires ETH (for example, to pay for the minting), include the value field
        // Example: value: ethers.utils.parseEther("AMOUNT_OF_ETH")
    });

    // Wait for the transaction to be mined
    await tx.wait();

    console.log(`Batch minted: Transaction Hash: ${tx.hash}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
