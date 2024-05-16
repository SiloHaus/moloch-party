# CONTRACTS

## MolochParty.sol

### fundingGoal.tsx [raisedAmount, goalAmount, stretchAmount] // Update | Reduce Variables on Frontend

* Connect these variables with a Read().

### React Hooks: memberCount.tsx [memberNumber]

* Create an RDF DAO, and activate Shares.
* Use Etherscan API to find Number of Moloch Shares for the Collection being Raised.

### React Hooks: daysLeft.tsx [daysLeft]

* Read | Listen Campaign Start Time
* Calculate | Display Countdown
* Create Pre-Launch State and Campaign Concluded State

## TierI.sol

### React Hooks: tier1.tsx

* Calculate Remaining NFTs
* Read Price

## TierII.sol

### React Hooks: tier2.tsx [commLeft] // Update | Removee Variables on Frontend

* Calculate Remaining NFTs
* Read Price

## PreTransferHook.sol | INFRA SECURITY

* A Manifold Extension which checks that a NFT still holds its Moloch Share before Transfer.

0) Deploy RDF for Manifold Contract | This creates MolochShare Token, which is checked for in the PreTransferHook.
1) Set the variables in the deploy.js file for the Pre-Transfer Hook Extension.
2) Deploy Pre-Transfer Hook Extension to protect against selling NFTs after burning shares
3) Register the Pre-Transfer Hook Extension as an Extension in Manifold Studio
4) Enter the contract address into setApproveTransfer() in your Manifold NFT Contract Write as Proxy section on OP Etherscan
5) addApprovedAddress() for necessary sales and treasury addresses in OP Etherscan for your Extension Contract

## DISCORD | TICKET BOT

* NFT Gated Discord Server. Ticket Bot has References and Commissioner provides TokenID, Description, References.

## PartyRegistry.sol | INFRA DATA

* You can create a PartyRegistry, which each campaign registers with on launch -- it would be more for long term housekeeping.
