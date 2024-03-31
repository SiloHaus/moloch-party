# CONTRACTS

## CommExtension.sol

A Commission Extension for a Manifold Collection, which allows for Minters to order custom pieces which exist with the same contract.
// Create Commissions MetaData Folder

## DAOInventory.sol

A distribution for the existing 14 NFTs in the DAO Treasury.

## MintExtension.sol

A Mint Extension for a Manifold PFP Project.

## PreTransferHook.sol

A Manifold Extension which checks that a NFT still holds its Moloch Share before Transfer.

1) Set the variables in the deploy.js file for the Pre-Transfer Hook Extension.
2) Deploy Pre-Transfer Hook Extension to protect against selling NFTs after burning shares
3) Register the Pre-Transfer Hook Extension as an Extension in Manifold Studio
4) Enter the contract address into setApproveTransfer() in your Manifold NFT Contract Write as Proxy section on OP Etherscan
5) addApprovedAddress() for necessary sales and treasury addresses in OP Etherscan for your Extension Contract
