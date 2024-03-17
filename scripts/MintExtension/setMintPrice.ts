import { ethers } from "hardhat";

async function main(): Promise<void> {
    const contractAddress: string = "0xWHATEVER"; // Replace "0xWHATEVER" with your contract's deployed address
    
    // The new mint price you want to set (in ether)
    const newMintPrice: string = "0.05"; // Example: 0.05 ETH

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the contract instance
    // Note: The TypeScript version correctly uses an already compiled contract ABI and address to create a contract instance.
    // If you have the ABI, you should use it directly with `new ethers.Contract()` method.
    // Assuming `ERC721LazyMint` is the name of your contract, ensure it's compiled and Hardhat Ethers plugin can find it.
    const ERC721LazyMint = await ethers.getContractFactory("ERC721LazyMint");
    const contract = ERC721LazyMint.attach(contractAddress).connect(signer);

    // Call the setMintPrice function with the new price converted to wei
    const tx = await contract.setMintPrice(ethers.utils.parseEther(newMintPrice));
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`Mint price set to: ${newMintPrice} ETH`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
