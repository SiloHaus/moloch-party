# PRE-TRANSFER HOOK:

This Pre-Transfer Hook is meant to check and see whether or not an NFT has burned its Moloch Share.
It protects against a type of double-spend, where the membership share is burned, and then the NFT is sold after it has burned its share.

The Owner of this contract can use approveAddress() or revokeAddress().

To activate this contract, deploy it, and then go to the Write as Proxy section on OP Etherscan, for your Manifold Contract. Then, set the deployed address in setApproveTransfer().
Your Manifold contract will automatically set the pre-transfer hook to enabled.

To remove, enter 0x0 in setApproveTransfer().

[Manifold Developer Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions)

## LAUNCH PROCESS:

1) Mint your NFT Contract on Manifold.
2) Create a Manager Safe for your project.
Once you have your contract minted, you can use the [Moloch RDF Summoner](https://silohaus.github.io/silo-rdf-summoner/).

You will need: 
* Manifold Contract
* Manager Safe Address

3) Mint Collection | Sale -- Set your ETH to be deposited into your Manager Safe.

4) Use the [RDF Claim App](https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate) to enable shares. Then, locate your molochShareAddress from within the tokenbound accounts, or in DAO Settings. You are looking for the Voting Token, which ought to be a soulbound ERC20 in the Token Bound Accounts of each NFT.

![Screenshot 2024-02-01 at 12 38 41 PM](https://github.com/SiloHaus/manifold-approveTransfer/assets/54530373/f76616d3-2e45-406c-b6f1-eb59a55ab429)

5) Set the variables in the deploy.js file for the Pre-Transfer Hook Extension. 
6) Deploy Pre-Transfer Hook Extension to protect against selling NFTs after burning shares
7) Register the Pre-Transfer Hook Extension as an Extension in Manifold Studio
8) Enter the contract address into setApproveTransfer() in your Manifold NFT Contract Write as Proxy section on OP Etherscan
9) addApprovedAddress() for necessary sales and treasury addresses in OP Etherscan for your Extension Contract

**[Vulnerability]**: If you have all of your ETH in the RQ Treasury, and then only one person uses the [RDF Claim App](https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate), then that person will have the only share, and their share will be the entire treasury. So, it's best that you wait to have more people use the claim app before transfering ETH to the RQ Treasury.

It's best to do a batch claim, or individual claims rather than lose ETH due to people not claiming after getting their NFTs. The ETH lost in this case, is part of everyone's equity, due to the imbalance of ETH to claimed shares.

The Shaman is an admin contract, which you can find here, at the bottom of the DAO Page.
![Screenshot 2024-02-03 at 12 29 48 AM](https://github.com/SiloHaus/manifold-approveTransfer/assets/54530373/5ebaa9d1-34d6-4be1-833b-fb212dc1e1ba)

The Shaman has public claim functions accessible via Etherscan: 
![Screenshot 2024-02-03 at 12 30 49 AM](https://github.com/SiloHaus/manifold-approveTransfer/assets/54530373/f51e6bdb-520c-4f8a-8b06-3ebbe95faaa1)

Enter the tokenID for each NFT you'd like to claim on behalf of, if you have a situation where there is more ETH in the Treasury, and some shares have not yet been claimed by people who have bought into the DAO.

10) Transfer Funds from Manager Safe into Moloch Treasury
11) Give Perms | Ownership of Manifold Contract and Extension Contract to DAO.

## CAUTIONS: 

You'll notice that some things don't work in the contract:

1) The bool for setApproveTransferExtension doesn't work on the Manifold Contract. This is because it's automatically turned on.
2) The ability to setApproveTransfer and Bool doesn't work from the contract extension. This is because only the Admin of the Manifold contract can use these functions.

You also need to be aware of your Permissions moving forward:

1) Has your Deployer Address given permissions for Manifold over to the DAO?
2) Has your Deployer Address revoked its own permissions for the Manifold Contract?
3) Has your Deployer Address given Ownership of ApproveTransferEx.Sol over to the DAO?
4) Which addresses have been added to the approveAddress WL?

## EXTENSION INSTRUCTIONS:

1) Set up your dependencies and .env file.
2) Set up your deploy.js file with the correct variables.
3) npx hardhat compile
4) npx hardhat run scripts/deploy.js --network optimism
5) npx hardhat verify --network optimism /*deployed extension contract*/ /*"molochShareAddress"*/ "0x000000006551c19487814612e58FE06813775758" "0x55266d75D1a14E4572138116aF39863Ed6596E7F" "0x0000000000000000000000000000000000000000000000000000000000000000" "10" /*"nftContract from Manifold"*/

## DOTENV VARIABLES:

DEPLOYER_PRIVATE_KEY=

ALCHEMY_API_KEY_OPTIMISM=

ALCHEMY_API_KEY_SEPIOLA=

ETHERSCAN_API_KEY=
