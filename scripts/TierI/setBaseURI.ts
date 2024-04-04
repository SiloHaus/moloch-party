import { ethers } from "hardhat";

async function main(): Promise<void> {
    // Your contract's deployed address
    const contractAddress = "0xWHATEVER";
    
    // The new base URI you want to set
    const newBaseURI = "https://weirdManifestPathFromAkord.arweave.net/moreJibberishHere/JSON/";

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the contract instance
    const ERC721LazyMint = await ethers.getContractFactory("ERC721LazyMint");
    // The below line is adjusted to use TypeScript syntax for creating a contract instance
    const contract = ERC721LazyMint.attach(contractAddress).connect(signer);

    // Call the setBaseURI function
    const tx = await contract.setBaseURI(newBaseURI);
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`Base URI set to: ${newBaseURI}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
