import { ethers } from "hardhat";

async function main(): Promise<void> {
    // TierII contract's deployed address
    const tierIIContractAddress = "0xYourTierIIContractAddressHere";
    
    // MolochParty contract's address that you want to set
    const molochPartyAddress = "0xYourMolochPartyContractAddressHere";

    // Get signer account from the hardhat environment
    const [signer] = await ethers.getSigners();

    // Get the TierII contract instance
    const TierII = await ethers.getContractFactory("TierII");
    const tierIIContract = TierII.attach(tierIIContractAddress).connect(signer);

    // Call the setMolochPartyAddress function on TierII
    const tx = await tierIIContract.setMolochPartyAddress(molochPartyAddress);
    await tx.wait(); // Wait for the transaction to be mined

    console.log(`MolochParty address set for TierII: ${molochPartyAddress}`);
}

// Execute the main function and handle possible errors
main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
