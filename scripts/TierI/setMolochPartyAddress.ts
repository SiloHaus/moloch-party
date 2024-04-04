import { ethers } from "hardhat";

async function main(): Promise<void> {
    // Your TierI contract's deployed address
    const tierIContractAddress = "0xYourTierIContractAddressHere";
    
    // The MolochParty contract address you want to set
    const molochPartyAddress = "0xYourMolochPartyContractAddressHere";

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the TierI contract instance
    const TierI = await ethers.getContractFactory("TierI");
    const tierIContract = TierI.attach(tierIContractAddress).connect(signer);

    // Call the setMolochPartyAddress function
    const tx = await tierIContract.setMolochPartyAddress(molochPartyAddress);
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`MolochParty address set to: ${molochPartyAddress}`);
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
