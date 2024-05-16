import { ethers } from "hardhat";
import { BigNumber } from "ethers";

async function main(): Promise<void> {
    // TierII contract's deployed address
    const tierIIContractAddress = "0x3e22B269BAE7C670676df9314F15CE65aDAeBb80";

    // Setup ethers provider, using the default provider here (e.g., Hardhat's local network)
    const provider = ethers.provider;

    // Get the signer to interact with the contract
    const signer = (await ethers.getSigners())[0];

    // Setup the contract instance with ABI and address
    const TierIIABI = [
        "function getMintedTokenIds() external view returns (uint256[])"
    ];
    const tierIIContract = new ethers.Contract(tierIIContractAddress, TierIIABI, signer);

    // Call the getMintedTokenIds function
    const mintedTokenIds: BigNumber[] = await tierIIContract.getMintedTokenIds();

    // Log each minted token ID, converting BigNumber to string for readability
    console.log("Minted Token IDs:", mintedTokenIds.map((id: BigNumber) => id.toString()));
}

main()
    .then(() => process.exit(0))
    .catch((error: Error) => {
        console.error(error);
        process.exit(1);
    });
