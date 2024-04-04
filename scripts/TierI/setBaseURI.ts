import { ethers } from "hardhat";

async function main(): Promise<void> {
    // Your TierI contract's deployed address
    const tierIContractAddress = "0xYourTierIContractAddressHere";
    
    // The new base URI you want to set
    const newBaseURI = "https://weirdManifestPathFromAkord.arweave.net/moreJibberishHere/JSON/";

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the TierI contract instance
    const TierI = await ethers.getContractFactory("TierI");
    const tierIContract = TierI.attach(tierIContractAddress).connect(signer);

    // Call the setBaseURI function
    const tx = await tierIContract.setBaseURI(newBaseURI);
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`TierI BaseURI set to: ${newBaseURI}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
