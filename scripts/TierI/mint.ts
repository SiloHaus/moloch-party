import { ethers } from "hardhat";

async function main(): Promise<void> {
    // Your contract's deployed address
    const contractAddress = "0x696Aacc96d55fF917790F73E19b2274C80A4E103";
    
    // Ensure your Hardhat network configuration and the account used have enough ETH for the minting fee

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the contract instance
    const ERC721LazyMint = await ethers.getContractFactory("ERC721LazyMint");
    const contract = new ethers.Contract(contractAddress, ERC721LazyMint.interface, signer);

    // Assuming the mint function requires sending value (minting fee)
    // Replace 'mintPriceInEth' with the actual mint price required by your contract's mint function
    const mintPriceInEth = "0.0042"; // Example price, adjust accordingly

    // Call the mint function with the value
    const tx = await contract.mint({
        value: ethers.utils.parseEther(mintPriceInEth)
    });

    // Wait for the transaction to be mined
    await tx.wait();

    console.log(`Minted: Transaction Hash: ${tx.hash}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: any) => {
        console.error(error);
        process.exit(1);
    });
