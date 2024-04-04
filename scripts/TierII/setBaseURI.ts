import { ethers } from "hardhat";

async function main(): Promise<void> {
    // TierII contract's deployed address
    const tierIIContractAddress = "0xYourTierIIContractAddressHere";
    
    // The new base URI you want to set for TierII
    const newBaseURI = "https://examplePathFromAkord.arweave.net/uniquePathHere/JSON/";

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the TierII contract instance
    const TierII = await ethers.getContractFactory("TierII");
    const tierIIContract = TierII.attach(tierIIContractAddress).connect(signer);

    // Call the setBaseURI function on TierII
    const tx = await tierIIContract.setBaseURI(newBaseURI);
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`TierII BaseURI set to: ${newBaseURI}`);
}

// Execute the main function and handle possible errors
main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
