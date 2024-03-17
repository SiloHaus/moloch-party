import { ethers } from "hardhat";

async function main(): Promise<void> {
    const contractAddress: string = "0xWHATEVER"; // Replace with your contract's deployed address

    // Get signer account from the Hardhat environment
    const [signer] = await ethers.getSigners();

    // Assuming ERC721LazyMint is the correct contract name and is available in your project
    const ERC721LazyMint = await ethers.getContractFactory("ERC721LazyMint");
    
    // Correcting the way to get an instance of the contract with the signer
    const contract = ERC721LazyMint.attach(contractAddress).connect(signer);

    // Call the withdraw function
    const tx = await contract.withdraw();
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`Withdrawal successful: Transaction Hash: ${tx.hash}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
